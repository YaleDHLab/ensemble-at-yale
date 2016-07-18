React         = require 'react'

module.exports = React.createClass
  displayName: 'Option'
    
  render: ->
    <option value={@props.option_text}>{@props.option_text}</option>