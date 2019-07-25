React  = require 'react'
API    = require '../lib/api'
{Link} = require 'react-router'

SmallButton   = require('components/buttons/small-button')

GroupBrowser = React.createClass
  displayName: 'GroupBrowser'

  getInitialState:->
    groups:[]

  componentDidMount:->
    API.type('groups').get(project_id: @props.project.id).then (groups)=>
      group.showButtons = false for group in groups  # hide buttons by default
      @setState groups: groups

  showButtonsForGroup: (group, e) ->
    group.showButtons = true
    @forceUpdate() # trigger re-render to update buttons

  hideButtonsForGroup: (group, e) ->
    group.showButtons = false
    @forceUpdate() # trigger re-render to update buttons

  renderGroups: ->
    display_groups = []
    ordered_groups = {}

    for group in @state.groups
      order = parseInt(group.meta_data.order)
      ordered_groups[order] = group

    for i, index in Object.keys(ordered_groups)
      group = ordered_groups[i]

      buttonContainerClasses = []
      groupNameClasses = []
      if group.showButtons
        buttonContainerClasses.push 'active'
      else
        groupNameClasses.push 'active'

      if group.status == 'complete'
        group_status = (
          <div className='group-status'>
            <div className='group-status-icon'>
              <svg xmlns='http://www.w3.org/2000/svg' width='19.003' height='19.073' viewBox='0 0 19.003 19.073'>
                <path d='M261.5,3886.729a9.537,9.537,0,1,0,9.5,9.536A9.519,9.519,0,0,0,261.5,3886.729Zm-.448,13.659-.674.731-.646-.756-3.667-4.283,1.194-1.292,2.972,2.2,6.5-5.356,1.212,1.291Z' transform='translate(-252 -3886.729)' fill='#69a7c7'></path>
              </svg>
            </div>
            <div className='group-status-text'>Transcription is complete</div>
            <div className='program-buttons'>
              <Link to="/groups/#{group.id}" className='browse-programs-button'>Browse Programs</Link>
            </div>
          </div>
        )
      else if group.status == 'in_progress'
        group_status = (
          <div className='group-status'>
            <div className='group-status-icon'>
              <svg xmlns='http://www.w3.org/2000/svg' width='22' height='19.552' viewBox='0 0 22 19.552'>
                <path d='M15.377,3.274l3.445,3.445a.373.373,0,0,1,0,.527l-8.342,8.342-3.544.393a.743.743,0,0,1-.821-.821l.393-3.544L14.85,3.274a.373.373,0,0,1,.527,0ZM21.565,2.4,19.7.535a1.494,1.494,0,0,0-2.108,0L16.24,1.887a.373.373,0,0,0,0,.527L19.685,5.86a.373.373,0,0,0,.527,0l1.352-1.352a1.494,1.494,0,0,0,0-2.108Zm-6.9,10.92v3.888H2.444V4.985h8.777a.47.47,0,0,0,.325-.134l1.528-1.528a.458.458,0,0,0-.325-.783H1.833A1.834,1.834,0,0,0,0,4.374V17.818a1.834,1.834,0,0,0,1.833,1.833H15.278a1.834,1.834,0,0,0,1.833-1.833V11.791a.459.459,0,0,0-.783-.325L14.8,12.994A.47.47,0,0,0,14.667,13.319Z' transform='translate(0 -0.1)' fill='#69a7c7'/>
              </svg>
            </div>
            <div className='group-status-text'>Ready for transcription</div>
            <div className='program-buttons'>
              <Link to="/groups/#{group.id}" className='browse-programs-button left'>Browse</Link>
              <a href={window.projectBuilderUrl || '#'} className='transcribe-program-button right'>Transcribe</a>
            </div>
          </div>
        )
      else if group.status == 'coming_soon'
        group_status = (
          <div className='group-status'>
            <div className='group-status-icon'>
              <svg xmlns='http://www.w3.org/2000/svg' width='19' height='18.998' viewBox='0 0 19 18.998'>
                <path d='M269.965,4006.651h-2.647a6.529,6.529,0,0,0-.649-1.431l1.754-1.761a1.047,1.047,0,0,0,0-1.491l-.745-.744a1.057,1.057,0,0,0-1.491,0l-1.787,1.783a6.316,6.316,0,0,0-1.561-.631v-2.317a1.056,1.056,0,0,0-1.055-1.057h-1.055a1.057,1.057,0,0,0-1.054,1.057v2.317a6.192,6.192,0,0,0-1.7.713l-1.495-1.494a1.06,1.06,0,0,0-1.493,0l-.747.746a1.061,1.061,0,0,0,0,1.494l1.521,1.522a6.292,6.292,0,0,0-.7,1.823H253.08a1.057,1.057,0,0,0-1.059,1.056v1.054a1.056,1.056,0,0,0,1.059,1.053h2.12a6.234,6.234,0,0,0,.854,1.757l-1.435,1.436a1.057,1.057,0,0,0,0,1.493l.745.746a1.062,1.062,0,0,0,1.495,0l1.6-1.6a6.185,6.185,0,0,0,1.742.564v2.207a1.057,1.057,0,0,0,1.055,1.056h1.055a1.058,1.058,0,0,0,1.055-1.056v-2.479a6.2,6.2,0,0,0,1.493-.763l1.7,1.7a1.061,1.061,0,0,0,1.493,0l.746-.747a1.05,1.05,0,0,0,0-1.494l-1.861-1.865a6.289,6.289,0,0,0,.517-1.48h2.514a1.055,1.055,0,0,0,1.056-1.055v-1.055A1.059,1.059,0,0,0,269.965,4006.651Zm-8.706,4.487a2.637,2.637,0,1,1,2.64-2.638A2.636,2.636,0,0,1,261.259,4011.138Z' transform='translate(-252.021 -3999.002)' fill='#69a7c7'/>
              </svg>
            </div>
            <div className='group-status-text'>Transcription coming soon</div>
            <div className='program-buttons'>
              <Link to="/groups/#{group.id}" className='browse-programs-button'>Browse Programs</Link>
            </div>
          </div>
        )
      else
        group_status = (
          <div className='group-status'></div>
        )

      display_groups.push(
        <div className='drama-era-image-wrapper' key={i}>
          {group_status}
          <div className={'drama-era-image-container'} key={group.id}>
            <div className='drama-era-image' style={backgroundImage: "url(#{group['cover_image_url']})"}></div>
            <div className='drama-era-image-overlay'>
              {group.meta_data.start_year} &#8210; {group.meta_data.end_year} &#8231; {group.name}
            </div>
            <div className={'drama-era-hover-image drama-era-hover-image-' + index}></div>
          </div>
        </div>
      )
    return display_groups

  render: ->
    # Only display GroupBrowser if more than one group defined:
    return null if @state.groups.length <= 1
    groups = @renderGroups()

    <div className='group-area-wrapper' id='group-target'>
      <div className='group-area-prompt'>Browse 90 years of programs organized chronologically by era and see what we're working on now</div>
      {groups}
    </div>

module.exports = GroupBrowser
