React         = require("react")
GroupBrowser  = require('./group-browser')
GenericButton   = require('components/buttons/generic-button')
FirstPageThumbnail = require('./first-page-thumbnail')
SelectDropdown = require('./select-dropdown')
API           = require('../lib/api')

GroupPage = React.createClass
  displayName: "GroupPage"

  getInitialState: ->
    group: null

  componentDidMount: ->
    # make a request to http://localhost:3000/subject_set_first_pages?group_id={{requested group id}}
    # using the incoming query param, and use the results of that query to define the first page array
    # as well as the available institutions and playwrights that users can select
    API.type("subject_set_first_pages").get(group_id: @props.params.group_id).then (first_pages_json) =>
      all_institutions = []
      all_playwrights = []

      # iterate through the first pages and update the available institutions and playwright options
      for first_page_json in first_pages_json
        institution = first_page_json.meta_data.location
        playwright = first_page_json.meta_data.written_by

        if institution
          if institution not in all_institutions
            all_institutions.push(institution)

        if playwright
          if playwright not in all_playwrights
            all_playwrights.push(playwright)

      @setState
        all_first_pages: first_pages_json
        all_institutions: all_institutions
        all_playwrights: all_playwrights
        first_pages_initialized: 0

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
      first_pages_initialized: 1


  updateFirstPageArray: ->
    console.log("updating first page array")
    selected_institution = $(".collection-institution select").val()
    selected_playwright  = $(".collection-playwright select").val() 

    # define the selection criteria to be used to filter first page objects
    selection_criteria_options = [
      {
        "label": "selected_institution", 
        "value": selected_institution, 
        "key_in_first_page_json": "location"
      }, 
      {
        "label": "selected_playwright", 
        "value": selected_playwright,
        "key_in_first_page_json": "written_by"
      }
    ]

    # if either selected_institution or selected_playwright are == "",
    # don't use them as selection criteria
    selection_criteria = []
    for selection_criterion in selection_criteria_options
      if selection_criterion.value?
        selection_criteria.push(selection_criterion)

    console.log(selection_criteria)

    # iterate over the first page array and retain only those elements that match
    # the user-specified selection criteria
    first_pages_to_display = []
    for first_page in @state.all_first_pages
      keep_page = 1
      for selection_criterion in selection_criteria
        console.log(first_page.meta_data[selection_criterion.key_in_first_page_json], selection_criterion.value)
        if first_page.meta_data[selection_criterion.key_in_first_page_json] != selection_criterion.value
          keep_page = 0
          console.log("not keeping page")
      if keep_page == 1
        first_pages_to_display.push(first_page)

    # iterate over the first pages to display and build the view
    first_pages_view = []
    for page_json, index in first_pages_to_display
      first_pages_view.push <FirstPageThumbnail page_json={page_json} key={index} />
    @setState
      first_page_array: first_pages_view


  render: ->
    if ! @state.group?
      <div className="group-page">
        <h2>Loading...</h2>
      </div>
    else
      <div className="collection-page-content">
        <div className="collection-title-container">
          <div className="collection-title">James Bundy Era</div>
        </div>

        <div className="collection-container">
          <div className="collection-thumbnails">{ @state.first_page_array }</div>
          <div className="collection-browse-controls-container">
            <div className="collection-browse-controls-content">
              <div className="collection-description">Praesent vitae lobortis, tempor vitae magna sed interdum nascetur. Eu eget facilisi urna laoreet, risus numquam bibendum, pellentesque odio dictum. Risus quam qui amet pellentesque nonummy, feugiat sodales lacus luctus.</div>

              <div className="collection-performance-dates-container">
                <div className="collection-performance-dates-label">Performance Dates</div>
                <div className="collection-question-mark-outer">
                  <div className="collection-question-mark-inner">?</div>
                </div>
                <div className="collection-range-slider">Range slider goes here</div>
                
                <div className="custom-select collection-institution">
                  <SelectDropdown options_array={@state.all_institutions} 
                                  placeholder_text={"Select Institution"} 
                                  onSelect={@updateFirstPageArray} />
                </div>

                <div className="custom-select collection-playwright">
                  <SelectDropdown options_array={@state.all_playwrights} 
                                  placeholder_text={"Select Playwright"}
                                  onSelect={@updateFirstPageArray} />
                </div>
              </div>
            </div>

            <div className="collection-mark-transcribe-container">
              <a href="#Mark">
                <div className="collection-button mark-button">MARK</div>
              </a>
              <a href="#Transcribe">
                <div className="collection-button transcribe-button">TRANSCRIBE</div>
              </a>
            </div>

            <div className="collection-progressbar-container">
              <div className="collection-progressbar" aria-valuenow="72" aria-valuemin="0" aria-valuemax="100"></div>
            </div>

            <div className="collection-browse-controls-content">
              <div className="collection-progress-details">
                <div className="collection-progress-overall">
                  <div className="collection-progress-overall-label">Overall completion:</div>
                  <div className="collection-progress-overall-value">72%</div>
                </div>

                <div className="collection-progress-box-container">
                  <div className="collection-progress-box">
                    <div className="collection-progress-top">444</div>
                    <div className="collection-progress-bottom">In-Progress</div>
                  </div>

                  <div className="collection-progress-box collection-progress-box-right">
                    <div className="collection-completed-top">88</div>
                    <div className="collection-completed-bottom">Completed</div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>


module.exports = GroupPage