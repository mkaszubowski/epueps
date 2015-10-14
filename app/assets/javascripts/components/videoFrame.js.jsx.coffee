React = require('react')
$ = require('jquery')
YouTube = require('react-youtube')

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
          React.createElement YouTube,
            url: @props.video.link,
            className: 'lesson-video',
            opts: {
              playerVars: {
                autoplay: 1
              }
            },
            onEnd: @props.playNextVideo

module.exports = VideoFrame