React = require 'react'

module.exports = React.createClass
  displayName: 'MarkOrTranscribe'

  render: ->
    <div className="mark-or-transcribe-modal-container">
      <div className="mark-or-transcribe-modal">
        <div className="greeting">Thanks for your help! Please click a button to proceed:</div>

        <a className="transcribe-this-playbill-button"
            href={"/#/transcribe?subject_set_id=" + @props.subjectSetId}
            onClick={@props.onClick}>
          <div className="major-button">Transcribe this program</div>
        </a>

        <a className="mark-a-playbill-button"
            href={"/#/mark?new_subject_set" + Math.random() * 6}
            onClick={@props.onClick}>
          <div className="major-button">Mark another program</div>
        </a>
      </div>
    </div>
