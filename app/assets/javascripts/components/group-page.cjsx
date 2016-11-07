React              = require("react")
GroupBrowser       = require('./group-browser')
GenericButton      = require('components/buttons/generic-button')
FirstPageThumbnail = require('./first-page-thumbnail')
SelectDropdown     = require('./select-dropdown')
ReactSlider        = require('react-slider')
API                = require('../lib/api')

GroupPage = React.createClass
  displayName: "GroupPage"

  getInitialState: ->
    all_institutions: []
    all_playwrights: []

    placeholder_institution: "All Institutions"
    selected_institution:    "All Institutions"

    placeholder_playwright: "All Playwrights"
    selected_playwright:    "All Playwrights"

    # min, max year will indicate the range of years from which the user can select
    # while start and end years will indicate the actual years the user has selected
    min_year: 1920
    max_year: 1940
    start_year: 1920
    end_year: 1940
    group_name: ""
    group_description: ""


  componentDidMount: ->
    # make a request to http://localhost:3000/groups/{{requested group id}},
    # fetch metadata that describes the group name and description, and pass those values into
    # the application state
    API.type("groups").get(@props.params.group_id).then (group_json) =>
      this.setState({
        group_name: group_json.name,
        group_description: group_json.description
      })

    # make a request to http://localhost:3000/subject_set_first_pages?group_id={{requested group id}}
    # using the incoming query param, and use the results of that query to define the first page array
    # as well as the available institutions and playwrights that users can select
    API.type("subject_set_first_pages").get(group_id: @props.params.group_id).then (first_pages_json) =>
      all_institutions = []
      all_playwrights = []
      author_surnames = {}
      min_year = 9999
      max_year = 0
      min_max_year_array = []

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

    API.type("groups").get(@props.params.group_id).then (group) =>
      @setState
        group: group

    API.type("subject_sets").get(group_id: @props.params.group_id).then (sets) =>
      @setState
        subject_sets: sets


  initializeFirstPageArray: ->
    # iterate over all first pages to display and build the view
    first_pages_view = []
    for page_json, index in @state.all_first_pages
      first_pages_view.push <FirstPageThumbnail page_json={page_json} key={index} />
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
          "label": "selected_institution",
          "value": @state.selected_institution,
          "key_in_first_page_json": "location"
        }
      )

    if @state.selected_playwright != @state.placeholder_playwright
      selection_criteria.push(
        {
          "label": "selected_playwright",
          "value": @state.selected_playwright,
          "key_in_first_page_json": "written_by"
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


  render: ->
    if ! @state.group?
      <div className="group-page">
        <h2>Loading...</h2>
      </div>
    else
      <div className="collection-page-content">
        <div className="collection-title-container">
          <div className="collection-title">{@state.group_name}</div>
        </div>

        <div className="collection-container">
          <div className="collection-thumbnails">{ @state.first_page_array }</div>
          <div className="collection-browse-controls-container">
            <div className="collection-browse-controls-content">
              <div className="collection-description">{@state.group_description}</div>

              <div className="collection-performance-dates-container">
                <div className="collection-performance-dates-label">Performance Dates</div>
                <div className="collection-question-mark-outer">
                  <div className="collection-question-mark-inner">?</div>
                </div>

                <div className="min-max-dates-container">
                  <div className="min-date min-max-date">{@state.min_year}</div>
                  <div className="max-date min-max-date">{@state.max_year}</div>
                </div>

                <div className="collection-range-slider">
                  <ReactSlider 
                    onAfterChange={@updateYearSliderState}
                    ref="ReactYearSlider"
                    min={@state.min_year} 
                    max={@state.max_year} 
                    value={[@state.start_year, @state.end_year]} withBars />
                </div>
                
                <div className="custom-select collection-institution">
                  <SelectDropdown options_array={@state.all_institutions} 
                                  placeholder={@state.placeholder_institution}
                                  value={@state.selected_institution}
                                  onSelect={@updateSelectedInstitution} />
                </div>

                <div className="custom-select collection-playwright">
                  <SelectDropdown options_array={@state.all_playwrights} 
                                  placeholder={@state.placeholder_playwright}
                                  value={@state.selected_playwright}
                                  onSelect={@updateSelectedPlaywright} />
                </div>
              </div>
            </div>

            <div className="collection-mark-transcribe-container">
              <a href="/#/Mark">
                <div className="collection-button mark-button">MARK</div>
              </a>
              <a href="/#/Transcribe">
                <div className="collection-button transcribe-button">TRANSCRIBE</div>
              </a>
            </div>

            <div className="collection-progressbar-container">
              <div className="collection-progressbar" 
                   aria-valuenow={parseInt((@state.group.stats?.completeness ? 0) * 100)}
                   aria-valuemin="0" aria-valuemax="100"
                   style={{width: parseInt((@state.group.stats?.completeness ? 0) * 100) + "%"}}></div>
            </div>

            <div className="collection-browse-controls-content">
              <div className="collection-progress-details">
                <div className="collection-progress-overall">
                  <div className="collection-progress-overall-label">Overall completion:</div>
                  <div className="collection-progress-overall-value">{parseInt((@state.group.stats?.completeness ? 0) * 100)}%</div>
                </div>

                <div className="collection-progress-box-container">
                  <div className="collection-progress-box">
                    <div className="collection-progress-top">{@state.group.stats?.total_pending ? 0}</div>
                    <div className="collection-progress-bottom">In-Progress</div>
                  </div>

                  <div className="collection-progress-box collection-progress-box-right">
                    <div className="collection-completed-top">{@state.group.stats?.total_finished ? 0}</div>
                    <div className="collection-completed-bottom">Completed</div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>


module.exports = GroupPage
