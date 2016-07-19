React         = require 'react'

module.exports = React.createClass
  displayName: 'FirstPageThumbnail'

  componentDidMount: ->
    @setState
      hovered: 0
      
  render: ->
    <div className="collection-thumbnail">
      <img src={@props.page_json.thumbnail} 
           className="group-page-image-thumbnail" />
      <div className="collection-thumbnail-button-container" >
        <div className="collection-thumbnail-mark">MARK</div>
        <div className="collection-thumbnail-transcribe">TRANSCRIBE</div>
      </div>
    </div>