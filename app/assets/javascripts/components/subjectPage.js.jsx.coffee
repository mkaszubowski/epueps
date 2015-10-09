React = require('react')
$ = require('jquery')

VideoFrame = require('./videoFrame.js.jsx.coffee')
SubjectPageMenu = require('./subjectPageMenu.js.jsx.coffee')

{ section, h1, div, ul, li, h2, a } = React.DOM

SubjectPage = React.createClass
  getInitialState: ->
    return {
      subject: @props.subject,
      lessons: [],
      currentVideo: null,
      currentLesson: null
    }
  loadResources: ->
    url = '/subjects/' + @state.subject.slug + '/lessons'
    $.ajax
      url: url
      dataType: 'json'
      success: (lessons) =>
        @setState({
          lessons: lessons,
          currentLesson: lessons[0],
          currentVideo: lessons[0].videos[0]
        })

      error: (xhr, status, error) ->
        console.log(error.toString())

  componentDidMount: ->
    @loadResources()

  setCurrentLesson: (lesson) ->
    @setState({ currentLesson: lesson })

  setCurrentVideo: (video) ->
    @setState({ currentVideo: video })

  render: ->
    section
      className: 'subject-page',
      div
        className: 'main-subject-content',
        React.createElement SubjectPageMenu,
          lessons: @state.lessons,
          currentLesson: @state.currentLesson,
          setCurrentLesson: @setCurrentLesson,
          setCurrentVideo: @setCurrentVideo

        React.createElement VideoFrame, video: @state.currentVideo

module.exports = SubjectPage
