React = require 'react'
API   = require '../lib/api'

SmallButton   = require('components/buttons/small-button')

GroupBrowser = React.createClass
  displayName: 'GroupBrowser'

  getInitialState:->
    groups:[]
    foregroundImageIndex: 0
    backgroundImageIndex: 0
    backgroundImageOpacity: 0

  componentDidMount:->
    API.type("groups").get(project_id: @props.project.id).then (groups)=>
      group.showButtons = false for group in groups  # hide buttons by default
      @setState groups: groups
    @requestImageUpdate()

  showButtonsForGroup: (group, e) ->
    group.showButtons = true
    @forceUpdate() # trigger re-render to update buttons

  hideButtonsForGroup: (group, e) ->
    group.showButtons = false
    @forceUpdate() # trigger re-render to update buttons

  requestImageUpdate: ->
    self = this
    setTimeout ( ->
      self.updateImages()
    ), 6000

  updateImages: ->
    # first make the foreground and the background the same
    self = this
    currentBackgroundIndex = @state.backgroundImageIndex

    @setState({
      foregroundImageIndex: currentBackgroundIndex,
      backgroundImageIndex: currentBackgroundIndex
    })

    # then remove opacity from the background image
    setTimeout ( ->
      self.setState({
        backgroundImageOpacity: 0
      })
    ), 500

    # next set the background image to the next image to display
    setTimeout ( ->
      self.setState({
        backgroundImageIndex: (currentBackgroundIndex+1) % 2
      })
    ), 2000

    # then fade the new background into view
    setTimeout ( ->
      self.setState({
        backgroundImageOpacity: 1
      })
    ), 4000

    # then place the next update cycle on the call stack
    @requestImageUpdate()

  renderGroup: (group) ->
    isEven = 0
    if @state.groups.indexOf(group) + 2 %% 2 == 0
      isEven = 0
    else 
      isEven = 1

    buttonContainerClasses = []
    groupNameClasses = []
    if group.showButtons
      buttonContainerClasses.push "active"
    else
      groupNameClasses.push "active"

    <div className="drama-era-image-wrapper">
      <a href="/#/groups/#{group.id}" className="drama-era-group-link">
        <div
          className='drama-era-image-container'
          style={backgroundImage: "url(http://placehold.it/35" + @state.foregroundImageIndex + "x150)"}
          key={group.id}>
            <div className="drama-era-next-image"
              style={backgroundImage: "url(http://placehold.it/35" + @state.backgroundImageIndex + "x150)", opacity: @state.backgroundImageOpacity}>
            </div>
            <div className="drama-era-image-overlay">
              {group.meta_data.start_year} &#8210; {group.meta_data.end_year} &#8231; {group.name}
            </div>
        </div>
      </a>
    </div>

  render: ->
    # Only display GroupBrowser if more than one group defined:
    return null if @state.groups.length <= 1

    groups = [@renderGroup(group) for group in @state.groups]
    <div className="group-area-wrapper">
      {groups}
    </div>

    

module.exports = GroupBrowser
