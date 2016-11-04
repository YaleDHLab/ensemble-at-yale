React                   = require 'react'

Footer = React.createClass
  displayName: 'Footer'

  render: ->
    <div>
    { if @props.display == 1
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
      else
        <div />
    }
    </div>

module.exports = Footer