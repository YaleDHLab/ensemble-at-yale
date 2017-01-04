React     = require 'react'

module.exports = React.createClass
  displayName: 'YaleLogin'

  render:->
    return <div className="login-page">
      <div className="hero-overlay-container">
        <div className="hero-overlay-title">Welcome</div>
        <div className="hero-overlay-text">To begin marking and transcribing programs, please log in to your prefered account</div>
        <a href="/users/auth/cas" className="hero-overlay-button">Yale Login</a>
        <a href="mailto:lindsay.king@yale.edu?Subject=Ensemble%20Login" target="_top" className="hero-overlay-button-help">Can't access your account?</a>
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
