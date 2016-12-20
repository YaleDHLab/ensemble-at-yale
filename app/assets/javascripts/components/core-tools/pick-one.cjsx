React                   = require 'react'
GenericTask             = require './generic'
LabeledRadioButton      = require 'components/buttons/labeled-radio-button'

NOOP = Function.prototype

module.exports = React.createClass
  displayName: 'SingleChoiceTask'

  statics:
    # Summary: Summary # don't use Summary (yet?)

    getDefaultAnnotation: ->
      value: null

  getDefaultProps: ->
    task: null
    annotation: null
    onChange: NOOP

  propTypes: ->
    task: React.PropTypes.object.isRequired
    annotation: React.PropTypes.object.isRequired
    onChange: React.PropTypes.func.isRequired

  render: ->
    answers = for answer in @props.task.tool_config.options
      answer._key ?= Math.random()
      checked = answer.value is @props.annotation.value
      classes = ['minor-button']
      classes.push 'active' if checked

      <LabeledRadioButton key={answer._key} classes={classes.join ' '} value={answer.value} checked={checked} onChange={@handleChange.bind this, answer.value} label={answer.label} />

    <GenericTask ref="inputs" {...@props} question={@props.task.instruction} answers={answers} />

  handleChange: (index, e) ->
    if e.target.checked
      @props.onChange({
        value: e.target.value
      })
      @forceUpdate() # update the radiobuttons after selection

window.React = React
