React     = require 'react'
HelpModal = require './help-modal'
DraggableModal  = require 'components/draggable-modal'

module.exports = React.createClass
  displayName: 'YaleTutorial'

  propTypes:
    text: React.PropTypes.object.isRequired

  getInitialState: ->
    currentPage: 0

  handleDone:->
    console.log("done")

  render:->
    return <div>
        { if @props.displayed == 1
            <DraggableModal ref="tutorialModal" 
                header={'Help'} 
                doneButtonLabel={"Done"} 
                onDone={@handleDone} 
                width={800} 
                classes={"help-modal"}> 
              <div className="help">
                <div className="help-text">
                  {@props.pages[@state.currentPage]}
                </div>
              </div>
            </DraggableModal>
          else
            <div />
        }
    </div>