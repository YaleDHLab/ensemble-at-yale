React     = require 'react'

module.exports = React.createClass
  displayName: 'YaleLogin'

  render:->
    return <div className="login-page">
      <div className="hero-overlay-container">
        <div className="hero-overlay-title">Welcome</div>
        <div className="hero-overlay-text">To begin marking and transcribing programs, please log in with either a Yale NetID...</div>
        <a href="/users/auth/cas" className="hero-overlay-button">Yale Login</a>
        <div className="hero-overlay-text">...or with a Facebook, Google+ or Twitter account:</div>
        <div className="hero-login-buttons">
          <a href="/users/auth/facebook" className="hero-login-button hero-login-facebook">
            <div className="hero-login-facebook-icon" />
          </a>
          <a href="/users/auth/google_oauth2" className="hero-login-button hero-login-google">
            <div className="hero-login-google-icon" />
          </a>
          <a href="/users/auth/twitter" className="hero-login-button hero-login-twitter">
            <div className="hero-login-twitter-icon" />
          </a>
        </div>
      </div>
    </div>
