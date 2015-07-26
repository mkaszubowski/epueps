$ ->
  info = $('.subjects-controller.info')

  if info.length > 0
    getImageLightness($('.subject-image img')[0].src, (brightness) ->
      if brightness > 200
        $('.subject-info-header').addClass('light')
    )
