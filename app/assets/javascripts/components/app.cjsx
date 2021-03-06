React = require("react")
MainHeader                    = require '../partials/yale-header'
Footer                        = require '../partials/yale-footer'
API                           = require '../lib/api'
Project                       = require 'models/project.coffee'

BrowserWarning                = require './browser-warning'

{RouteHandler}                = require 'react-router'

window.API = API

App = React.createClass
  getInitialState: ->
    routerRunning:        false
    user:                 null
    loginProviders:       []
    showFooter:           0
    routeHash:            ""

  componentWillMount: ->
    @checkFooter()
    @updateHash()

  componentDidMount: ->
    @fetchUser()

  componentWillUpdate: ->
    hash = window.location.hash
    if hash != @state.routeHash
      @setState({routeHash: hash})
      @checkFooter()

  updateHash: ->
    hash = window.location.hash
    @setState({routeHash: hash})

  fetchUser:->
    @setState
      error: null
    request = $.getJSON "/current_user"

    request.done (result)=>
      if result?.data
        @setState
          user: result.data
      else

      if result?.meta?.providers
        @setState loginProviders: result.meta.providers

    request.fail (error)=>
      @setState
        loading:false
        error: "Having trouble logging you in"

  setTutorialComplete: ->
    # Immediately ammend user object with tutorial_complete flag so that we can hide the Tutorial:
    @setState user: $.extend(@state.user ? {}, tutorial_complete: true)

    # Send a post to the db to indicate the tutorial is complete
    request = $.post "/tutorial_complete"
    request.fail (error)=>
      console.log "failed to set tutorial value for user"

  checkFooter: ->
    hash = window.location.hash
    location = hash.search(/mark/gi)
    if location != -1 or hash == "#/login"
      @setState({showFooter: 0})
    else
      @setState({showFooter: 1})

  render: ->
    project = window.project
    return null if ! project?

    style = {}
    style.backgroundImage = "url(#{project.background})" if project.background?

    <div className="footer-wrapper">
      <div className="react-wrapper">
        <div className="panoptes-main">

          <MainHeader
            workflows={project.workflows}
            feedbackFormUrl={project.feedback_form_url}
            discussUrl={project.discuss_url}
            blogUrl={project.blog_url}
            pages={project.pages}
            short_title={project.short_title}
            logo={project.logo}
            menus={project.menus}
            user={@state.user}
            loginProviders={@state.loginProviders}
            onLogout={() => @setState user: null}
          />

          <div className="main-content">
            <BrowserWarning />
            <RouteHandler hash={window.location.hash} project={project} onCloseTutorial={@setTutorialComplete} user={@state.user}/>
          </div>
        </div>
      </div>
      <Footer display={@state.showFooter} privacyPolicy={ project.privacy_policy } menus={project.menus} partials={project.partials} />
    </div>

module.exports = App
