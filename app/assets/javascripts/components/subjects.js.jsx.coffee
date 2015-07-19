React = require('react')
$ = require('jquery')

Subject = require('./subject.js.jsx.coffee')

R = React.DOM

SubjectScopeLinks = React.createClass
  getInitialState: ->
    return {
      scope: @props.scope || 'popular'
    }

  handlePopularClick: (e)->
    @setState(scope: 'popular')
    @props.handlePopularClick(e)

  handleRecentClick: (e)->
    @setState(scope: 'recent')
    @props.handleRecentClick(e)

  render: ->
    recentClass = if @state.scope == 'recent' then 'subjects-recent active' else 'subjects-recent'
    popularClass = if  @state.scope == 'popular' then 'subjects-popular active' else 'subjects-popular'

    R.div
      className: 'subject-scope-options'
      R.a({href: '#', onClick: @handlePopularClick, className: popularClass}, 'Popularne ')
      '/'
      R.a({href: '#', onClick: @handleRecentClick, className: recentClass}, ' Najnowsze')


Subjects = React.createClass
  getInitialState: ->
    return {
      subjects: [],
      scope: @props.scope || 'popular'
      }

  loadSubjectsFromServer: ()->
    url = 'subjects?'
    if @props.hasOwnProperty('limit')
      url += 'limit=' + @props.limit + '&'

    url += 'scope=' + @state.scope

    $.ajax
      url: url
      dataType: 'JSON'
      success: (subjects) =>
        @setState({subjects: subjects})
      error: (xhr, status, error) ->
        console.log(error.toString())

  handlePopularClick: (e) ->
    e.preventDefault()
    @setState({scope: 'popular'}, ->
      @loadSubjectsFromServer())

  handleRecentClick: (e) ->
    e.preventDefault()
    @setState({scope: 'recent'}, ->
      @loadSubjectsFromServer())

  componentDidMount: ->
    @loadSubjectsFromServer()

  render: ->
    unless @props.showScopeLinks == false
      scopeLinks = 
        React.createElement SubjectScopeLinks, 
          scope: @state.scope,
          handleRecentClick: @handleRecentClick, 
          handlePopularClick: @handlePopularClick

    R.div
      className: 'subject-section'
      scopeLinks
      R.div
        className: 'subjects'
        for subject in @state.subjects
          React.createElement Subject, subject: subject

module.exports = Subjects
