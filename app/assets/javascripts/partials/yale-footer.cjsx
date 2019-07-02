React                   = require 'react'

Footer = React.createClass
  displayName: 'Footer'

  render: ->
    <div>
    { if @props.display == 1
        <div className='footer-container'>
          <div className='footer-content'>
            <div className='footer-left'>
              <a href='http://web.library.yale.edu/'>
                <img src={'/assets/dh-wordmark-white.png'} />
              </a>
            </div>

            <div className='footer-right-container'>
              <div className='footer-right'>
                A collaboration of the Yale Digital Humanities Laboratory & Robert B. Haas Family Arts Library
              </div>
            </div>
          </div>
        </div>
      else
        <div />
    }
    </div>

module.exports = Footer