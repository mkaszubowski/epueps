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
      currentLesson: null,
      lessonCurrentVideoIndex: 0,
      currentLessonIndex: 0
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
          lessonCurrentVideoIndex: 0,
          currentLessonIndex: 0,
        })
        console.log(lessons)

      error: (xhr, status, error) ->
        console.log(error.toString())

  componentDidMount: ->
    @loadResources()

  setCurrentLesson: (index) ->
    @setState({
      currentLessonIndex: index,
      currentLesson: @state.lessons[index]
      })

  setCurrentVideo: (index) ->
    @setState({
      lessonCurrentVideoIndex: index
      currentVideo: @state.currentLesson.videos[index]
      })

  playNextVideo: ->
    @markCurrentVideoAsWatched()
    if @lessonHasMoreVideos(@state.currentLesson)
      @playNextLessonVideo()
    else
      @playNextLesson()

  lessonHasMoreVideos: (lesson) ->
    index = @state.lessonCurrentVideoIndex + 1
    return lesson.videos_count > index

  playNextLessonVideo: ->
    index = @state.lessonCurrentVideoIndex + 1
    @setState({
      currentVideo: @state.currentLesson.videos[index],
      lessonCurrentVideoIndex: index
      })

  playNextLesson: ->
    index = @state.currentLessonIndex + 1
    if @state.lessons.length > index
      @setState({
        currentLesson: @state.lessons[index],
        currentVideo: @state.lessons[index].videos[0],
        currentLessonIndex: index,
        lessonCurrentVideoIndex: 0
        })

  markCurrentVideoAsWatched: ->
    lessons = @state.lessons
    lessonId = @state.currentLessonIndex
    videoId = @state.lessonCurrentVideoIndex
    lessons[lessonId].videos[videoId].watched = true
    @setState(lessons: lessons)

    @markAsWatchedOnServer()

  markAsWatchedOnServer: ->
    $.ajax
      url: '/profile_videos'
      dataType: 'json'
      method: 'POST'
      data: {
        video_id: @state.currentVideo.id
      }
      error: (xhr, status, error) ->
        console.log(error.toString())


  render: ->
    section
      className: 'subject-page',
      div
        className: 'main-subject-content',
        React.createElement SubjectPageMenu,
          lessons: @state.lessons,
          currentLesson: @state.currentLesson,
          currentVideo: @state.currentVideo,
          setCurrentLesson: @setCurrentLesson,
          setCurrentVideo: @setCurrentVideo

        React.createElement VideoFrame,
          video: @state.currentVideo,
          playNextVideo: @playNextVideo

module.exports = SubjectPage
