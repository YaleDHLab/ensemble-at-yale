React = require("react")
App         = require './app'
Router      = require 'react-router'
{Handler, Root, RouteHandler, Route, DefaultRoute, Redirect, Navigation, Link, Transition} = Router

HomePage      = require './yale-home-page'
Mark          = require './mark'
Transcribe    = require './transcribe'
Verify        = require './verify'
GroupPage     = require './group-page'
GroupBrowser  = require './group-browser'
AboutPage    = require './yale-about-page'
YaleLogin     = require './yale-login'

Project       = require 'models/project.coffee'

class AppRouter
  constructor: ->
    API.type('projects').get().then (result)=>
      window.project = new Project(result[0])
      @runRoutes window.project

  saveRequestedRoute: (requestedRoute) ->
    $.post "/save_requested_route",
      requested_route: "/#" + requestedRoute
      (data) ->
        response = data
        # pass

  # function to check if the current route is restricted, and if so, to redirect
  # users to a login route
  checkForAuthentication: (Handler, state) ->
    self = this
    # check if the requested route is protected
    if state.pathname in ["/mark", "/transcribe"]

      # check if the current user is logged in
      request = $.getJSON "/current_user"

      request.done (result) =>
        if result?.data
          user = result.data
          if user.guest == true

            self.saveRequestedRoute(state.path)

            # note: React Router v13.x is now unsupported, and github docs are not comprehensive
            # but one can array the properties of the route handler with:
            # console.log(Object.getOwnPropertyNames(Handler))
            # and from there consult /node-modules/react-router/umd/ReactRouter.js to find
            # the object method of interest

            # Handler.transitionTo(routeToGoTo, {the: params}, {the: query})
            Handler.transitionTo('/login', {})
        else
          self.saveRequestedRoute(state.path)
          Handler.transitionTo('/login', {})

  runRoutes: (project) ->
    self = this
    routes =
      <Route name="root" path="/" handler={App} >

        <Redirect from="_=_" to="/" />

        <Route name="home" path="/home" handler={HomePage}/>

        { (w for w in project.workflows when w.name in ['mark','transcribe','verify']).map (workflow, key) =>
            handler = eval workflow.name.charAt(0).toUpperCase() + workflow.name.slice(1)
            <Route
              key={key}
              path={workflow.name}
              handler={handler}
              name={workflow.name}
            />
        }

        { (w for w, i in project.workflows when w.name in ['mark']).map (workflow, key) =>
            handler = eval workflow.name.charAt(0).toUpperCase() + workflow.name.slice(1)
            <Route
              key={key}
              path={workflow.name + '/:subject_set_id' + '/:subject_id'}
              handler={handler}
              name={workflow.name + '_specific_subject'}
            />
        }
        { (w for w, i in project.workflows when w.name in ['mark']).map (workflow, key) =>
            handler = eval workflow.name.charAt(0).toUpperCase() + workflow.name.slice(1)
            <Route
              key={key}
              path={workflow.name + '/:subject_set_id'}
              handler={handler}
              name={workflow.name + '_specific_set'}
            />
        }
        { (w for w, i in project.workflows when w.name in ['transcribe','verify']).map (workflow, key) =>
            handler = eval workflow.name.charAt(0).toUpperCase() + workflow.name.slice(1)
            <Route
              key={key}
              path={workflow.name + '/:subject_id' }
              handler={handler}
              name={workflow.name + '_specific'}
            />
        }
        { (w for w, i in project.workflows when w.name in ['transcribe']).map (workflow, key) =>
            handler = eval workflow.name.charAt(0).toUpperCase() + workflow.name.slice(1)
            <Route
              key={key}
              path={workflow.name + '/:workflow_id' + '/:parent_subject_id' }
              handler={handler}
              name={workflow.name + '_entire_page'}
            />
        }
        { # Project-configured pages:
          (w for w, i in project.pages when w.name in ['About']).map (page, key) =>
              <Route
                key={key}
                path={page.name}
                handler={AboutPage}
                name={page.name}
              />
        }

        <Route
          path='groups'
          handler={GroupBrowser}
          name='groups'
        />
        <Route
          path='groups/:group_id'
          handler={GroupPage}
          name='group_show'
        />
        <Route
          path='login'
          handler={YaleLogin}
          name='yale-login'
        />

        <DefaultRoute name="home-default" handler={HomePage} />
      </Route>

    Router.run routes, (Handler, state) ->
      self.checkForAuthentication(Handler, state)
      React.render <Handler />, document.body

  controllerForPage: (page) ->
    React.createClass
      displayName: "#{page.name}Page"

      componentDidMount: ->
        pattern = new RegExp('#/[A-z]*#(.*)')
        selectedID = "#{window.location.hash}".match(pattern)

        if selectedID
          $('.selected-content').removeClass("selected-content")

          $("div#" + selectedID[1]).addClass("selected-content")
          $("a#" + selectedID[1]).addClass("selected-content")

        elms = $(React.findDOMNode(this)).find('a.about-nav')
        elms.on "click", (e) ->
          e.preventDefault()
          $('.selected-content').removeClass("selected-content")
          $(this).addClass("selected-content")

          divId = $(this).attr('href')
          $(divId).addClass("selected-content")

        el = $(React.findDOMNode(this)).find("#accordion")
        el.accordion
          collapsible: true
          active: false
          heightStyle: "content"

      navToggle:(e)->

      render: ->
        formatted_name = page.name.replace("_", " ")
        <div className="page-content custom-page" id="#{page.name}">
          <h1>{formatted_name}</h1>
          <div dangerouslySetInnerHTML={{__html: marked(page.content)}} />
          {
            if page.group_browser? && page.group_browser != ''
              <div className='group-area'>
                <GroupBrowser project={project} title={page.group_browser} />
              </div>
          }
          <div className="updated-at">Last Update {page.updated_at}</div>
        </div>

module.exports = AppRouter
window.React = React
