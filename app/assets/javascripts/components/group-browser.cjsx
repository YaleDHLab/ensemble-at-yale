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
        buttonContainerClasses.push "active"
      else
        groupNameClasses.push "active"

      display_groups.push(

        <div className="drama-era-image-wrapper" key={i}>
          <a href="/#/groups/#{group.id}" className="drama-era-group-link">
            <div
              className={'drama-era-image-container'} key={group.id}>
                <div className="drama-era-image" style={backgroundImage: "url(#{group['cover_image_url']})"}></div>
                <div className="drama-era-image-overlay">
                  {group.meta_data.start_year} &#8210; {group.meta_data.end_year} &#8231; {group.name}
                </div>
                <div className={"drama-era-hover-image drama-era-hover-image-" + index}></div>
            </div>
          </a>
        </div>
      )
    return display_groups

  render: ->
    # Only display GroupBrowser if more than one group defined:
    return null if @state.groups.length <= 1
    groups = @renderGroups()

    <div className="group-area-wrapper">
      {groups}
    </div>

    

module.exports = GroupBrowser
