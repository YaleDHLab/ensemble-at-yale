React = require 'react'
API   = require '../lib/api'

SmallButton   = require('components/buttons/small-button')

GroupBrowser = React.createClass
  displayName: 'GroupBrowser'

  getInitialState:->
    groups:[]

  componentDidMount:->
    API.type("groups").get(project_id: @props.project.id).then (groups)=>
      group.showButtons = false for group in groups  # hide buttons by default
      @setState groups: groups

  showButtonsForGroup: (group, e) ->
    group.showButtons = true
    @forceUpdate() # trigger re-render to update buttons

  hideButtonsForGroup: (group, e) ->
    group.showButtons = false
    @forceUpdate() # trigger re-render to update buttons

  renderGroup: (group) ->
    buttonContainerClasses = []
    groupNameClasses = []
    if group.showButtons
      buttonContainerClasses.push "active"
    else
      groupNameClasses.push "active"

    <a href="/#/groups/#{group.id}" className="drama-era-group-link">
      <div
        className='drama-era-image-container'
        style={backgroundImage: "url(#{group.cover_image_url})"}
        key={group.id}>
          <div className="drama-era-image-overlay">
            {group.meta_data.start_year} &#8210; {group.meta_data.end_year} &#8231; {group.name}
          </div>
      </div>
    </a>

  render: ->
    # Only display GroupBrowser if more than one group defined:
    return null if @state.groups.length <= 1

    groups = [@renderGroup(group) for group in @state.groups]
    <div className="drama-era-gallery-container">
      <div className="drama-era-center">
        {groups}
      </div>
    </div>


module.exports = GroupBrowser
