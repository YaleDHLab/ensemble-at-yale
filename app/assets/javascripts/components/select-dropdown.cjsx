React         = require 'react'

module.exports = React.createClass
  displayName: 'SelectDropdown'
    
  render: ->

    <select onChange={@props.onSelect} placeholder={@props.value}>
      <option value={@props.placeholder}>{@props.placeholder}</option>
      {
        for option, option_index in @props.options_array
          <option key={option_index} value={option}>{option}</option>
      }
    </select>