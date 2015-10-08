React = require('react')
$ = require('jquery')

VideoFrame = require('./videoFrame.js.jsx.coffee')

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
        ul
          className: 'lesson-menu',
          for lesson in @state.lessons
            lessonActive = if lesson == @state.currentLesson then 'active' else ''
            li
              className: "lesson #{lessonActive}",
              onClick: @setCurrentLesson.bind(this, lesson)
              key: 'lesson' + lesson.id,
              h2 {},
                a {},
                lesson.name
              ul
                className: 'lesson-videos'
                for video in lesson.videos
                  li
                    className: 'video-li',
                    onClick: @setCurrentVideo.bind(this, video)
                    a(
                      {
                        className: 'video-link',
                      },
                      video.name)
        React.createElement VideoFrame, video: @state.currentVideo



module.exports = SubjectPage
