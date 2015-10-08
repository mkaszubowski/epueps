React = require('react')
$ = require('jquery')

{ div, iframe } = React.DOM

VideoFrame = React.createClass
  render: ->
    if @props.video == null
      div className: 'empty-video', ''
    else
      div
        className: 'video'
        div
          className: 'lesson-video-container'
          iframe(
            {
              className: 'lesson-video'
              src: @props.video.embed_link
              id: "video-#{@props.video.id}"
              allowFullScreen: 'allowFullScreen'
            },
            '')

module.exports = VideoFrame