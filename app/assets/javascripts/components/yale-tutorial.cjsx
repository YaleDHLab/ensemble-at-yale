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

  createHtml: (htmlString)->
    return {__html: htmlString}

  getPagination: ->
    if @props.pages.length > 1
      return (
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
      )

  getClass: ->
    if @props.pages.length > 1
      return ""
    else
      return " hide-buttons"

  render:->
    return <div className={"yale-tutorial-modal" + @getClass()}>
        { if @props.displayed == true
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
                <div className="help-text"
                   dangerouslySetInnerHTML={@createHtml(@props.pages[@state.currentPage].text)} />
                <div className="help-modal-pagination-spacer" />
                {@getPagination()}
              </div>
            </DraggableModal>
          else
            <div />
        }
    </div>

