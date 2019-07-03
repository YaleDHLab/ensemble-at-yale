React         = require 'react'
GroupBrowser  = require './group-browser'
NameSearch    = require './name-search'
{Navigation}  = require 'react-router'
require '../lib/scrolly'

HomePage = React.createClass
  displayName : 'HomePage'
  mixins: [Navigation]

  getInitialState: ->
    backgroundImageIndex: 0
    foregroundImageIndex: 0
    backgroundImageOpacity: 0
    heroImages: [
      '1952-DidoAnaes.jpg',
      '1956-right-you-are.jpg',
      '1987-PianoLesson.jpg',
      '2003-TamingShrew.jpg',
      '2012-WintersTale.jpg'
    ]
    backgroundPositions: [
      '50% 90%',
      '50% 50%',
      '50% 10%',
      '50% 93%',
      '50% 40%'
    ]
    backgroundImagePosition: '50% 90%'
    foregroundImagePosition: '50% 90%'

  componentWillMount: ->
    @requestImageUpdate()

  componentWillUnmount: ->
    this.requestImageUpdate = null
    this.updateImage = null

  componentWillReceiveProps: (new_props) ->
    @setState project: new_props.project

  markClick: ->
    @transitionTo 'mark', {}

  transcribeClick: ->
    @transitionTo 'transcribe', {}

  requestImageUpdate: ->
    self = this
    setTimeout ( ->
      try
        self.updateImage()
      catch e
    ), 6000

  updateImage: ->
    # first make the foreground and the background the same

    self = this
    currentBackgroundIndex = @state.backgroundImageIndex
    currentBackgroundPosition = @state.backgroundImagePosition
    nextIndexPosition = (currentBackgroundIndex+1) % 5
    nextBackgroundPosition = @state.backgroundPositions[nextIndexPosition]

    try
      @setState({
        foregroundImageIndex: currentBackgroundIndex,
        backgroundImageIndex: currentBackgroundIndex,
        foregroundImagePosition: currentBackgroundPosition,
        backgroundImagePosition: currentBackgroundPosition
      })
    catch e

    # then remove opacity from the background image
    setTimeout ( ->
      self.setState({
        backgroundImageOpacity: 0
      })
    ), 500

    # next set the background image to the next image to display
    setTimeout ( ->
      self.setState({
        backgroundImageIndex: nextIndexPosition,
        backgroundImagePosition: nextBackgroundPosition
      })
    ), 2000

    # then fade the new background into view
    setTimeout ( ->
      self.setState({
        backgroundImageOpacity: 1
      })
    ), 4000

    # then place the next update cycle on the call stack
    self.requestImageUpdate()

  render:->
    <div className='home-page'>
      <div className='page-content'>
        <div className='hero-container'>
          <div className='image-container'>
            <div className='next-hero-image-container'>
              <div className='next-hero-image' style={
                backgroundImage: 'url(/assets/' + @state.heroImages[@state.backgroundImageIndex] + ')',
                opacity: @state.backgroundImageOpacity,
                backgroundPosition: @state.backgroundImagePosition
              }></div>
            </div>
            <div className='hero-image' style={
              backgroundImage: 'url(/assets/' + @state.heroImages[@state.foregroundImageIndex] + ')',
              backgroundPosition: @state.foregroundImagePosition
              } >
              <div className='hero-overlay-container'>
                <div className='hero-overlay-content'>
                  <div className='hero-overlay-title'>
                    Help create a database of Yale theater
                  </div>

                  <div className='hero-overlay-text'>Click a button below to get started:</div>
                  <a href={window.projectBuilderUrl}>
                    <div className='hero-overlay-button'>Transcribe</div>
                  </a>
                  <div className='hero-overlay-button' onClick={() -> smoothScroll('group-target')}>Browse</div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div className='group-area'>
          <GroupBrowser project={@props.project} />
        </div>
      </div>
    </div>

module.exports = HomePage
