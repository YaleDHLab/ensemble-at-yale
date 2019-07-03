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
                A collaboration of the <a href='http://dhlab.yale.edu'>Yale Digital Humanities Laboratory</a> & <a href='https://web.library.yale.edu/arts'>Robert B. Haas Family Arts Library</a>
              </div>
            </div>
          </div>
        </div>
      else
        <div />
    }
    </div>

module.exports = Footer