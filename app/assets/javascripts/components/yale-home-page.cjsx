React         = require 'react'
GroupBrowser  = require './group-browser'
NameSearch    = require './name-search'
{Navigation}  = require 'react-router'
require '../lib/scrolly'

HomePage = React.createClass
  displayName : 'HomePage'
  mixins: [Navigation]

  componentWillReceiveProps: (new_props) ->
    @setState project: new_props.project

  markClick: ->
    @transitionTo 'mark', {}

  transcribeClick: ->
    @transitionTo 'transcribe', {}

  render:->
    <div className='home-page'>
      <div className='page-content'>
        <div className='hero-container'>
          <div className='image-container'>
            <div className='next-hero-image-container'>
              <div className='next-hero-image'></div>
            </div>
            <div className='hero-image'>
              <div className='hero-overlay-container'>
                <div className='hero-overlay-content'>
                  <div className='hero-overlay-title'>
                    Transcribe programs to create<br/>a database of Yale theatre history
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
