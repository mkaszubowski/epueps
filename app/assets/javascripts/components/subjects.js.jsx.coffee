React = require('react')
$ = require('jquery')

Subject = require('./subject.js.jsx.coffee')

R = React.DOM

SubjectScopeLinks = React.createClass
  render: ->
    R.div
      className: 'subject-scope-options'
      R.a({href: '#', onClick: @handlePopularClick, className: 'subjects-popular'}, 'Popularne ')
      '/'
      R.a({href: '#', onClick: @handleRecentClick, className: 'subjects-recent'}, ' Najnowsze')


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
      scopeLinks = React.createElement SubjectScopeLinks

    R.div
      className: 'subject-section'
      scopeLinks
      R.div
        className: 'subjects'
        for subject in @state.subjects
          React.createElement Subject, subject: subject

module.exports = Subjects
