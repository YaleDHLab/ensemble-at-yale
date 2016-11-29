React = require 'react'

Login = React.createClass
  displayName : "Login"

  getInitialState:->
    error: null

  getDefaultProps: ->
    user: null
    loginProviders: []

  render:->
    <div className='login'>
      {@renderLoggedIn() if @props.user?.name? && ! @props.user.guest }
      {@renderLoggedInAsGuest() if @props.user && @props.user.guest }
      {@renderLoginOptions("Log In:","login-container") if !@props.user }
    </div>

  signOut:(e)->
    e.preventDefault()

    request = $.ajax
      url: '/users/sign_out'
      method: 'delete'
      dataType: "json"

    request.done =>
      @props.onLogout()

    request.error (request,error)=>
      @setState
        error : "Could not log out"


  renderLoggedInAsGuest: ->
    <span >
      { @renderLoginOptions('Log in to save your work:',"login-container") }
    </span>

  renderLoggedIn:->
    <span className={"login-container"}>
      { if @props.user.avatar
          <img src="#{@props.user.avatar}" />
      }
      <span className="label">Hello {@props.user.name} </span><a className="logout" onClick={@signOut} >Logout</a>
    </span>


  getIcon:(icon_id)->
    <object data="/assets/login-icons/#{icon_id}-login.svg" type="image/svg+xml">
      <img src="/assets/login-icons/#{icon_id}-login.png" />
    </object>

  renderLoginOptions: (label,classNames) ->
    self = this
    links = @props.loginProviders.map (link) ->
      <a key="login-link-#{link.id}"
          href={link.path}
          title="Log in using #{link.name}">
          {self.getIcon(link.id)}
      </a>

    <span className={classNames}>
      <span className="label">{ "Log In" }</span>
      <div className='options'>
        { links }
      </div>
    </span>


module.exports = Login
