React         = require 'react'

module.exports = React.createClass
  displayName: 'FirstPageThumbnail'

  componentDidMount: ->
    @setState
      hovered: 0
      
  getHref: (mark_or_transcribe) ->
    return '/#/' + mark_or_transcribe + '?subject_set_id=' + @props.page_json.subject_set_id

  render: ->
    <div className='collection-thumbnail'>
      <img src={@props.page_json.thumbnail} 
           className='group-page-image-thumbnail' />
      <div className='collection-thumbnail-button-container' >
        <a href={@getHref('mark')}>
          <div className='collection-thumbnail-mark'>MARK</div>
        </a>
        <a href={@getHref('transcribe')}>
          <div className='collection-thumbnail-transcribe'>TRANSCRIBE</div>
        </a>
      </div>
    </div>