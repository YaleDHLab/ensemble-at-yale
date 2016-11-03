React     = require 'react'
HelpModal = require './help-modal'
DraggableModal  = require 'components/draggable-modal'

module.exports = React.createClass
  displayName: 'Tutorial'

  propTypes:
    onCloseTutorial: React.PropTypes.func.isRequired

  getInitialState:->
    currentTask: {}
    nextTask: {}
    completedSteps: 0
    doneButtonLabel: "Next"

  onClose: ->
    @animateClose()
    @props.onCloseTutorial()

  onClickStep: (index) ->
    taskKeys = Object.keys(@props.tutorial.tasks)
    taskKey = taskKeys[index]
    task = @props.tutorial.tasks[taskKey]
    @setState
      currentTask: taskKey
      nextTask: task.next_task
      completedSteps: index

  render:->
    <div />