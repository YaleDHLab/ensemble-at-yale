React     = require 'react'

module.exports = React.createClass
  displayName: 'BooleanToggle'

  getDefaultProps: ->
    active: 0

  getClass: ->
    if @props.active == 1
      return "active boolean-toggle"
    return "boolean-toggle"

  getText: ->
    if @props.active == 1
      return "Yes"
    return "No"

  render: ->
    <div className={@getClass()}>
      <div className="track">
        <div className="knob" onClick={@props.clickHandler}>
          <div className="label">{@getText()}</div>
        </div>
      </div>
    </div>
