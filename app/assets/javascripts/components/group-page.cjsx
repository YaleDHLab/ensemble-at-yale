React         = require("react")
GroupBrowser  = require('./group-browser')
GenericButton   = require('components/buttons/generic-button')
FirstPageThumbnail = require('./first-page-thumbnail')
API           = require('../lib/api')

GroupPage = React.createClass
  displayName: "GroupPage"

  getInitialState: ->
    group: null

  componentDidMount: ->
    # make a request to http://localhost:3000/subject_set_first_pages?group_id=578b885e3dfe9ecf50896966
    # using the incoming query param, and use the results of that query to populate and update the view

    API.type("subject_set_first_pages").get(group_id: @props.params.group_id).then (firstPagesJson) =>
      @setState
        all_first_pages: firstPagesJson
        current_first_pages: firstPagesJson

    API.type("groups").get(@props.params.group_id).then (group) =>
      @setState
        group: group

    API.type("subject_sets").get(group_id: @props.params.group_id).then (sets) =>
      @setState
        subject_sets: sets

  render: ->
    if ! @state.group?
      <div className="group-page">
        <h2>Loading...</h2>
      </div>

    else
      firstPages = []
      for page_json, index in @state.current_first_pages
        firstPages.push <FirstPageThumbnail page_json={page_json} key={index} /> 

      <div className="collection-page-content">
        <div className="collection-title-container">
          <div className="collection-title">James Bundy Era</div>
        </div>

        <div className="collection-container">
          <div className="collection-thumbnails">

            {firstPages}

          </div>

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
                  <select>
                    <option disabled selected value="">Select Institution</option>
                    <option value="0">Culinary Institute of America</option>
                  </select>
                </div>

                <div className="custom-select collection-playwright">
                  <select>
                    <option disabled selected value="">Select Playwright</option>
                    <option value="0">Bob Barker</option>
                  </select>
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