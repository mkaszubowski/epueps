$ ->
  info = $('.subjects-controller.info')

  getImageLightness($('.subject-image img')[0].src, (brightness) ->
    if brightness > 200
      $('.subject-info-header').addClass('light')
  )
