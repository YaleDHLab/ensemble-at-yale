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
        <a href={@getHref('mark')}>
          <div className='collection-thumbnail-mark'>View</div>
        </a>

      </div>
    </div>