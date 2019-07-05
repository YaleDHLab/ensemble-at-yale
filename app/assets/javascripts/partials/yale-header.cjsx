React = require 'react'
{Link} = require 'react-router'
Router = require 'react-router'
# {Navigation, Link} = Router
Login = require '../components/login'

module.exports = React.createClass
  displayName: 'YaleHeader'

  getDefaultProps: ->
    user: null
    loginProviders: []

  render: ->

    <header classNameim='main-header'>
      <nav className='main-nav main-header-group'>
        <div className='header-content'>
          <a href='http://web.library.yale.edu/dhlab' className='main-header-item logo'>
            <img src={'assets/dh-mark.png'} />
          </a>

          <div className='brand-title-container'>
            <div className='brand-title-text-container'>
              <a href='/#/'>
                <div className='brand-title'>
                  <img src='assets/ensemble-logo.png' />
                </div>
              </a>
            </div>
          </div>

          <div className='workflow-tab-container'>
            <span>
              <a href={window.projectBuilderUrl || '#'} className='main-header-item main-header-button'>Transcribe</a>
              <div className='main-header-underline' />
            </span>
            <span>
              <a href='/#/about' activeClassName='selected' className='main-header-item main-header-button'>About</a>
              <div className='main-header-underline' />
            </span>
          </div>
        </div>
      </nav>

    </header>

