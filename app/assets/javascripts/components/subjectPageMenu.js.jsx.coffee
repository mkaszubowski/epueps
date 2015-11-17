React = require('react')
$ = require('jquery')

{ section, h1, div, ul, li, h2, a } = React.DOM

SubjectPageMenu = React.createClass
  render: ->
    ul
      className: 'lesson-menu',
      for lesson, index in @props.lessons
        lessonActive = if lesson == @props.currentLesson then 'active' else ''
        li
          className: "lesson #{lessonActive}",
          onClick: @props.setCurrentLesson.bind(null, index),
          key: 'lesson' + lesson.id,
          h2 {},
            a {},
            lesson.name
          React.createElement VideoSubmenu,
            lesson: lesson,
            currentVideo: @props.currentVideo
            setCurrentVideo: @props.setCurrentVideo

VideoSubmenu = React.createClass
  render: ->
    ul
      className: 'lesson-videos'
      for video, index in @props.lesson.videos
        videoClass = 'video-li'
        videoClass += ' watched' if video.watched
        videoClass += ' active' if video == @props.currentVideo

        li
          className: videoClass,
          onClick: @props.setCurrentVideo.bind(null, index),
          key: 'video' + video.id,
          a(
            {
              className: 'video-link',
            },
            video.name)

module.exports = SubjectPageMenu
