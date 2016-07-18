React         = require 'react'
Option        = require './option'

module.exports = React.createClass
  displayName: 'SelectDropdown'
    
  render: ->

    <select>
      <option disabled selected value="">{@props.placeholder_text}</option>
      {
        for option, option_index in @props.options_array
          <Option key={option_index} option_text={option} option_index={option_index} />
      }
    </select>