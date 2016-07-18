React         = require("react")
GroupBrowser  = require('./group-browser')
GenericButton   = require('components/buttons/generic-button')
API           = require('../lib/api')

GroupPage = React.createClass
  displayName: "GroupPage"

  getInitialState: ->
    group: null

  componentDidMount: ->
    # make a request to http://localhost:3000/subject_set_first_pages?group_id=578b885e3dfe9ecf50896966
    # using the incoming query param, and use the results of that query to populate and update the view

    API.type("subject_set_first_pages").get(group_id: @props.params.group_id).then (first_pages_json) =>
      @setState
        first_pages_json: first_pages_json

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
      <div className='page-content'>
        <h1>{@state.group.name}</h1>

        <div className="group-page">

          <div className="group-information">
            <h3>{@state.group.description}</h3>

            <dl className="metadata-list">
              { for k,v of @state.group.meta_data when ['key','description','cover_image_url','external_url','retire_count'].indexOf(k) < 0
                  # Is there another way to return both dt and dd elements without wrapping?
                  <div key={k}>
                    <dt>{k.replace(/_/g, ' ')}</dt>
                    <dd>{v}</dd>
                  </div>
              }
              { if @state.group.meta_data.external_url?
                <div>
                  <dt>External Resource</dt>
                  <dd><a href={@state.group.meta_data.external_url} target="_blank">{@state.group.meta_data.external_url}</a></dd>
                </div>
              }
            </dl>

            <img className="group-image" src={@state.group.cover_image_url} />
          </div>

          <div className="group-stats">

            { if @state.group.stats?
                <div>
                  <dl className="stats-list">
                    <div>
                      <dt>Classifications In-Progress</dt>
                      <dd>{@state.group.stats?.total_pending ? 0}</dd>
                    </div>
                    <div>
                      <dt>Complete Classifications</dt>
                      <dd>{@state.group.stats?.total_finished ? 0}</dd>
                    </div>
                    <div>
                      <dt>Overall Estimated Completion</dt>
                      <dd>{parseInt((@state.group.stats?.completeness ? 0) * 100)}%</dd>
                    </div>
                  </dl>
                </div>
            }

            <div className='subject_sets'>
              { for set, i in @state.subject_sets ? []
                  <div key={i} className="subject_set">
                    <div className="mark-transcribe-buttons">
                      { for workflow in @props.project.workflows
                          if (set.counts[workflow.id]?.active_subjects ? 0) > 0
                            <GenericButton key={workflow.id} label={workflow.name} href={"#/#{workflow.name}?subject_set_id=#{set.id}"} />
                      }
                    </div>
                  </div>
              }
            </div>

          </div>


        </div>
      </div>


module.exports = GroupPage
