React = require('react')
$ = require('jquery')

{section, h1, div, ul, li, h2, a, iframe} = React.DOM

SubjectPage = React.createClass
  getInitialState: ->
    return {
      subject: @props.subject,
      videos: [],
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
    console.log('change video')
    @setState({ currentVideo: video })



  render: ->
    unless @state.currentVideo == null
      videoFrame =
        div
          className: 'video'
          div
            className: 'lesson-video-container'
            iframe(
              {
                className: 'lesson-video'
                src: @state.currentVideo.embed_link
                id: "video-#{@state.currentVideo.id}"
                allowfullscreen: 'allowfullscreen'
              },
              '')
    else
      videoFrame = ''

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
        videoFrame



module.exports = SubjectPage
