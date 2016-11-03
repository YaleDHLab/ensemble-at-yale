React     = require 'react'
HelpModal = require './help-modal'
DraggableModal  = require 'components/draggable-modal'

module.exports = React.createClass
  displayName: 'YaleTutorial'

  getInitialState: ->
    currentPage: 0

  getNextPage:->
    page = @state.currentPage
    if page+1 == @props.pages.length
      @setState({currentPage: 0})
    else
      @setState({currentPage: page+1})

  updateCurrentPage: (newPage)->
    @setState({currentPage: newPage})

  render:->
    return <div className="yale-tutorial-modal">
        { if @props.displayed == 1
            <DraggableModal ref="tutorialModal"
                header={@props.header}
                doneButtonLabel={"Next"}
                onDone={@getNextPage}
                width={800}
                classes={"help-modal"}
                showCloseModal={1}
                closeTutorialClickHandler={@props.toggleYaleTutorial}
                >
              <div className="help">
                <div className="help-text">
                  {@props.pages[@state.currentPage].text}
                </div>
                <div className="help-modal-pagination-spacer" />
                <div className="help-modal-pagination">
                  <div className="help-pages-container"
                    style={{marginLeft: (0 - 10*@props.pages.length) + "px"}}>
                    {(<div className={
                      if page.pageNumber == @state.currentPage
                        "help-modal-page active"
                      else
                        "help-modal-page"
                      }
                      onClick={@updateCurrentPage.bind(this, page.pageNumber)}
                      key={idx} /> for page, idx in @props.pages)}
                  </div>
                </div>
              </div>
            </DraggableModal>
          else
            <div />
        }
    </div>