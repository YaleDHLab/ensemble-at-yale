
React         = require("react")
GroupBrowser  = require('./group-browser')
NameSearch    = require('./name-search')
{Navigation}  = require 'react-router'


HomePage = React.createClass
  displayName : "HomePage"
  mixins: [Navigation]

  componentWillReceiveProps: (new_props) ->
    @setState project: new_props.project

  markClick: ->
    @transitionTo 'mark', {}

  transcribeClick: ->
    @transitionTo 'transcribe', {}


  render:->
    <div className="home-page">
      <div className="page-content">
        <div className="hero-container">
          <div className="image-container">
            <div className="hero-image">
            
              <div className="hero-overlay-container">
                <div className="hero-overlay-title">
                  Help build a database of Yale theater history
                </div>

                <div className="hero-overlay-text">
                  Identify and transcribe important roles, dates, titles and more from 90+ years of digitized performance programs in the Yale University Library
Get started with one of these two tasks:.
                </div>

                <a href="/#/mark">
                  <div className="hero-overlay-button">MARK</div>
                </a>
                <a href="/#/transcribe">
                  <div className="hero-overlay-button">TRANSCRIBE</div>
                </a>
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
