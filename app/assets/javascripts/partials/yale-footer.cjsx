React                   = require 'react'

Footer = React.createClass
  displayName: 'Footer'

  propTypes:->
    privacyPolicy: @props.privacyPolicy

  getInitialState: ->
    categories: null

  render: ->
    <div className="footer-container">
  
      <div className="footer-left">
        <img src={'/assets/dh-wordmark-white.png'} />
      </div>

      <div className="footer-right-container">
        <div className="footer-right">
          <div className="footer-right-top">
            <div className="footer-top-text">MADE WITH</div>
            <img src={'/assets/scribe.jpg'} />
          </div>
          <div className="footer-right-bottom">
            <div className="footer-bottom-text">
              Document transcription, crowdsourced
            </div>
          </div>
        </div>
      </div>
    </div>

module.exports = Footer