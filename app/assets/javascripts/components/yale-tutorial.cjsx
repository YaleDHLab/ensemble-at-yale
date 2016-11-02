React     = require 'react'
HelpModal = require './help-modal'
DraggableModal  = require 'components/draggable-modal'

module.exports = React.createClass
  displayName: 'YaleTutorial'

  propTypes:
    text: React.PropTypes.object.isRequired

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
              <div className="help"></div>
            </DraggableModal>
          else
            <div />
        }
    </div>