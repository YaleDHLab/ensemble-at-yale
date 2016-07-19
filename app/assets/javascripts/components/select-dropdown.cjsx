React         = require 'react'
Option        = require './option'

module.exports = React.createClass
  displayName: 'SelectDropdown'
    
  render: ->

    <select onChange={@props.onSelect}>
      <option value="" disabled selected>{@props.placeholder_text}</option>
      {
        for option, option_index in @props.options_array
          <Option key={option_index} 
                  option_text={option} 
                  option_index={option_index} />
      }
    </select>