React         = require 'react'

module.exports = React.createClass
  displayName: 'FirstPageThumbnail'

  componentDidMount: ->
    @setState
      hovered: 0
      
  getHref: (mark_or_transcribe) ->
    return '/#/' + mark_or_transcribe + '?subject_set_id=' + @props.page_json.subject_set_id

  getStyle: ->
    imagePath = @props.page_json.thumbnail
    return { "background": "url(" + imagePath + ") no-repeat center center" }

  render: ->
    <div className='collection-thumbnail'>
      <div style={@getStyle()}
           className='group-page-image-thumbnail' />
      <div className='collection-thumbnail-button-container' >
        {
          if @props.page_json.retired_from_mark != 1
            <a href={@getHref('mark')}>
              <div className='collection-thumbnail-mark'>MARK</div>
            </a>
          else
            <div className='collection-thumbnail-mark retired-from-workflow'>MARKED!</div>
        }

        {
          if @props.page_json.retired_from_transcribe != 1
            <a href={@getHref('transcribe')}>
              <div className='collection-thumbnail-transcribe'>TRANSCRIBE</div>
            </a>
          else
            <div className='collection-thumbnail-transcribe retired-from-workflow'>TRANSCRIBED!</div>
        }

      </div>
    </div>