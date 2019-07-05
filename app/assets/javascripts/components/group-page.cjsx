React              = require 'react'
GroupBrowser       = require './group-browser'
GenericButton      = require 'components/buttons/generic-button'
FirstPageThumbnail = require './first-page-thumbnail'
SelectDropdown     = require './select-dropdown'
ReactSlider        = require 'react-slider'
API                = require '../lib/api'


sort_first_pages_json = (a, b) ->
  (2 * a['retired_from_mark'] + a['retired_from_transcribe']) -
  (2 * b['retired_from_mark'] + b['retired_from_transcribe'])

GroupPage = React.createClass
  displayName: 'GroupPage'

  getInitialState: ->
    group_stats: {
      total_marks: 0
      total_transcriptions: 0
      total_completed: 0
    }

    all_institutions: []
    all_playwrights: []

    placeholder_institution: 'All Institutions'
    selected_institution:    'All Institutions'

    placeholder_playwright: 'All Playwrights'
    selected_playwright:    'All Playwrights'

    # min, max year will indicate the range of years from which the user can select
    # while start and end years will indicate the actual years the user has selected
    min_year: 1920
    max_year: 1940
    start_year: 1920
    end_year: 1940
    group_name: ''
    group_description: ''

  componentDidMount: ->
    # make a request to /groups/{{ group_id }},
    # fetch metadata that describes the group name and description, and pass those values into
    # the application state
    API.type('groups').get(@props.params.group_id).then (group_json) =>
      @setState
        group_name: group_json.name,
        group_description: group_json.description,
        group_json: group_json

    # make a request to /group_stats?group_id={{ group_id }}
    # using the incoming data to set completion stats
    API.type('group_stats').get(group_id: @props.params.group_id).then (stats_json) =>
      @setState
        group_stats: stats_json[0]


    # make a request to /subject_set_first_pages?group_id={{ group_id }}
    # using the incoming query param, and use the results of that query to define the first page array
    # as well as the available institutions and playwrights that users can select
    API.type('subject_set_first_pages').get(group_id: @props.params.group_id).then (first_pages_json) =>
      all_institutions = []
      all_playwrights = []
      author_surnames = {}
      min_year = 9999
      max_year = 0
      min_max_year_array = []

      # sort the first_pages_json so transcribed + marked appear later
      first_pages_json.sort(sort_first_pages_json)

      # iterate through the first pages and update the available institutions and playwright options
      for first_page_json in first_pages_json

        try
          institution = first_page_json.meta_data.location
          playwright = first_page_json.meta_data.written_by
          year = first_page_json.meta_data.year

          if institution
            if institution not in all_institutions
              all_institutions.push(institution)

          if playwright
            split_playwright = playwright.split(',')
            playwright_name = {
              last: split_playwright[0],
              first: split_playwright[1],
              raw: playwright
            }

            try
              if playwright not in author_surnames[playwright_name.last]
                author_surnames[playwright_name.last].push(playwright)

            catch e
              author_surnames[playwright_name.last] = [playwright]

          if year
            year_int = parseInt(year)
            if year_int < min_year
              min_year = year_int
            if year_int > max_year
              max_year = year_int

        catch e

      # create an array of sorted playwright names
      sorted_playwright_names = []
      for surname in Object.keys(author_surnames).sort()
        for author in author_surnames[surname]
          sorted_playwright_names.push(author)

      @setState
        all_first_pages: first_pages_json
        all_institutions: all_institutions
        all_playwrights: sorted_playwright_names
        min_year: min_year
        max_year: max_year
        start_year: min_year
        end_year: max_year

      @initializeFirstPageArray()

    API.type('groups').get(@props.params.group_id).then (group) =>
      @setState
        group: group

    API.type('subject_sets').get(group_id: @props.params.group_id).then (sets) =>
      @setState
        subject_sets: sets


  initializeFirstPageArray: ->
    # iterate over all first pages to display and build the view
    first_pages_view = []
    marked = []
    transcribed = []
    for page_json, index in @state.all_first_pages
      if page_json.retired_from_mark == 1
        marked.push page_json
      else
        if page_json.retired_from_transcribe == 1
          transcribed.push page_json
        else
          first_pages_view.push <FirstPageThumbnail page_json={page_json} key={index} />

    for page_json, index in marked
      first_pages_view.push <FirstPageThumbnail page_json={page_json} key={'marked-' + index} />

    for page_json, index in transcribed
      first_pages_view.push <FirstPageThumbnail page_json={page_json} key={'marked-' + index} />

    @setState
      first_page_array: first_pages_view

  updateSelectedInstitution: (e)->
    @setState({selected_institution: e.target.value}, @updateFirstPageArray)

  updateSelectedPlaywright: (e)->
    @setState({selected_playwright: e.target.value}, @updateFirstPageArray)

  updateFirstPageArray: ->
    # define the selection criteria to be used to filter first page objects
    selection_criteria = []

    if @state.selected_institution != @state.placeholder_institution
      selection_criteria.push(
        {
          'label': 'selected_institution',
          'value': @state.selected_institution,
          'key_in_first_page_json': 'location'
        }
      )

    if @state.selected_playwright != @state.placeholder_playwright
      selection_criteria.push(
        {
          'label': 'selected_playwright',
          'value': @state.selected_playwright,
          'key_in_first_page_json': 'written_by'
        }
      )

    # iterate over the first page array and retain only those elements that match
    # the user-specified selection criteria
    first_pages_to_display = []
    for first_page in @state.all_first_pages
      keep_page = 1

      # ensure year falls within user-selected range
      try
        page_year = first_page.meta_data.year
        page_year_as_int = parseInt(page_year)
        if page_year_as_int < @state.start_year
          keep_page = 0
        if page_year_as_int > @state.end_year
          keep_page = 0

        # iterate over the selection criteria and continue filtering
        for selection_criterion in selection_criteria
          if first_page.meta_data[selection_criterion.key_in_first_page_json] != selection_criterion.value
            keep_page = 0
        if keep_page == 1
          first_pages_to_display.push(first_page)
      catch e

    # iterate over the first pages to display and build the view
    first_pages_view = []
    for page_json, index in first_pages_to_display
      first_pages_view.push <FirstPageThumbnail page_json={page_json} key={index} />
    @setState
      first_page_array: first_pages_view


  updateYearSliderState: (start_end_year_array) ->
    @setState
      start_year: start_end_year_array[0]
      end_year: start_end_year_array[1]
      @updateFirstPageArray


  getStatusMessage: (group_status) ->
    if group_status == 'complete'
      return (
        <div className='group-status-message'>
          <svg xmlns='http://www.w3.org/2000/svg' width='19.003' height='19.073' viewBox='0 0 19.003 19.073'>
            <path d='M261.5,3886.729a9.537,9.537,0,1,0,9.5,9.536A9.519,9.519,0,0,0,261.5,3886.729Zm-.448,13.659-.674.731-.646-.756-3.667-4.283,1.194-1.292,2.972,2.2,6.5-5.356,1.212,1.291Z' transform='translate(-252 -3886.729)' fill='#69a7c7'></path>
          </svg>
          <div className='status-top'>Transcription is complete</div>
          <p>Thank you to all volunteers who helped us transcribe this era. The Ensemble@Yale team is working on the data produced. Programs on this page are browsable, but buttons to mark and transcribe have been turned off.</p>
          <p>To transcribe, browse available <a href={window.projectBuilderUrl}>programs here.</a></p>
        </div>
      )

    else if group_status == 'in_progress'
      return (
        <div className='group-status-message'>
          <svg xmlns='http://www.w3.org/2000/svg' width='22' height='19.552' viewBox='0 0 22 19.552'>
            <path d='M15.377,3.274l3.445,3.445a.373.373,0,0,1,0,.527l-8.342,8.342-3.544.393a.743.743,0,0,1-.821-.821l.393-3.544L14.85,3.274a.373.373,0,0,1,.527,0ZM21.565,2.4,19.7.535a1.494,1.494,0,0,0-2.108,0L16.24,1.887a.373.373,0,0,0,0,.527L19.685,5.86a.373.373,0,0,0,.527,0l1.352-1.352a1.494,1.494,0,0,0,0-2.108Zm-6.9,10.92v3.888H2.444V4.985h8.777a.47.47,0,0,0,.325-.134l1.528-1.528a.458.458,0,0,0-.325-.783H1.833A1.834,1.834,0,0,0,0,4.374V17.818a1.834,1.834,0,0,0,1.833,1.833H15.278a1.834,1.834,0,0,0,1.833-1.833V11.791a.459.459,0,0,0-.783-.325L14.8,12.994A.47.47,0,0,0,14.667,13.319Z' transform='translate(0 -0.1)' fill='#69a7c7'/>
          </svg>
          <div className='status-top'>Transcription is underway</div>
          <p>We’re focusing on this era now! Click the Transcribe button above to help. Programs on this page are browsable, but buttons to mark and transcribe have been turned off.</p>
        </div>
      )

    else if group_status == 'coming_soon'
      return (
        <div className='group-status-message'>
          <svg xmlns='http://www.w3.org/2000/svg' width='19' height='18.998' viewBox='0 0 19 18.998'>
            <path d='M269.965,4006.651h-2.647a6.529,6.529,0,0,0-.649-1.431l1.754-1.761a1.047,1.047,0,0,0,0-1.491l-.745-.744a1.057,1.057,0,0,0-1.491,0l-1.787,1.783a6.316,6.316,0,0,0-1.561-.631v-2.317a1.056,1.056,0,0,0-1.055-1.057h-1.055a1.057,1.057,0,0,0-1.054,1.057v2.317a6.192,6.192,0,0,0-1.7.713l-1.495-1.494a1.06,1.06,0,0,0-1.493,0l-.747.746a1.061,1.061,0,0,0,0,1.494l1.521,1.522a6.292,6.292,0,0,0-.7,1.823H253.08a1.057,1.057,0,0,0-1.059,1.056v1.054a1.056,1.056,0,0,0,1.059,1.053h2.12a6.234,6.234,0,0,0,.854,1.757l-1.435,1.436a1.057,1.057,0,0,0,0,1.493l.745.746a1.062,1.062,0,0,0,1.495,0l1.6-1.6a6.185,6.185,0,0,0,1.742.564v2.207a1.057,1.057,0,0,0,1.055,1.056h1.055a1.058,1.058,0,0,0,1.055-1.056v-2.479a6.2,6.2,0,0,0,1.493-.763l1.7,1.7a1.061,1.061,0,0,0,1.493,0l.746-.747a1.05,1.05,0,0,0,0-1.494l-1.861-1.865a6.289,6.289,0,0,0,.517-1.48h2.514a1.055,1.055,0,0,0,1.056-1.055v-1.055A1.059,1.059,0,0,0,269.965,4006.651Zm-8.706,4.487a2.637,2.637,0,1,1,2.64-2.638A2.636,2.636,0,0,1,261.259,4011.138Z' transform='translate(-252.021 -3999.002)' fill='#69a7c7'/>
          </svg>
          <div className='status-top'>Transcription coming soon</div>
          <p>There is now only one era available to transcribe at a time. Once that era is complete, we will move to the next chronologically. Programs on this page are browsable, but buttons to mark and transcribe have been turned off.</p>
          <p>To transcribe, browse available <a href={window.projectBuilderUrl}>programs here.</a>.</p>
        </div>
      )
    else
      return (<span />)

  getStatusRegion: (group_status) ->
    if group_status == 'in_progress'
      return (
        <div>
          <div className='collection-mark-transcribe-container'>
            <a href={window.projectBuilderUrl}>
              <div className='collection-button transcribe-button'>Transcribe</div>
            </a>
          </div>
          <div className='group-status-container short'>
            {@getStatusMessage(group_status)}
          </div>
        </div>
      )
    else
      return (
        <div>
          <div className='group-status-container tall'>
            {@getStatusMessage(group_status)}
          </div>
        </div>
      )


  render: ->
    if ! @state.group?
      <div className='group-page'>
        <h2>Loading...</h2>
      </div>
    else
      <div className='collection-page-content'>
        <div className='collection-title-container'>
          <div className='collection-title'>{@state.group_name}</div>
        </div>

        <div className='collection-container'>
          <div className='collection-thumbnails'>{ @state.first_page_array }</div>
          <div className='collection-browse-controls-container'>
            <div className='collection-browse-controls-content'>
              <div className='collection-description'>{@state.group_description}</div>

              <div className='collection-performance-dates-container'>
                <div className='collection-performance-dates-label'>Performance Dates</div>

                <div className='min-max-dates-container'>
                  <div className='min-date min-max-date'>{@state.min_year}</div>
                  <div className='max-date min-max-date'>{@state.max_year}</div>
                </div>

                <div className='collection-range-slider'>
                  <ReactSlider
                    onAfterChange={@updateYearSliderState}
                    ref='ReactYearSlider'
                    min={@state.min_year}
                    max={@state.max_year}
                    value={[@state.start_year, @state.end_year]} withBars />
                </div>

                <div className='custom-select collection-institution'>
                  <SelectDropdown options_array={@state.all_institutions}
                                  placeholder={@state.placeholder_institution}
                                  value={@state.selected_institution}
                                  onSelect={@updateSelectedInstitution} />
                </div>

                <div className='custom-select collection-playwright'>
                  <SelectDropdown options_array={@state.all_playwrights}
                                  placeholder={@state.placeholder_playwright}
                                  value={@state.selected_playwright}
                                  onSelect={@updateSelectedPlaywright} />
                </div>
              </div>
            </div>
            { @getStatusRegion(@state.group_json.status) }
          </div>
        </div>
      </div>


module.exports = GroupPage
