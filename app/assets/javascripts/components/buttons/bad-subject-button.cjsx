React         = require 'react'
SmallButton   = require './small-button'

module.exports = React.createClass
  displayName: 'BadSubjectButton'

  render: ->
    label = @props.label ? ( if @props.active then 'Report Problem' else 'Report Problem?' )

    additional_classes = []
    additional_classes.push 'toggled' if @props.active
    additional_classes.push @props.className if @props.className?
    <SmallButton key="bad-subject-button" label={label} onClick={@props.onClick} className="ghost toggle-button #{additional_classes.join(' ')}" />
