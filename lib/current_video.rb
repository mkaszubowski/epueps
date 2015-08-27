module CurrentVideo

  # returns lesson's current or
  # first video if lesson hadn't been played yet

  def current_video(subject)
    video_id =
      params[:video_id] ||
      current_video_from_cookie(subject) ||
      nil

    if video_id
      Video.find(video_id)
    else
      subject.lessons.first.videos.first unless subject.lessons.empty?
    end
  end

  def current_video_from_cookie(subject)
    cookies["s#{subject.id}-current-video"]
  end

  def create_example_video(lesson)
    lesson.videos.create(name: "example",
      link: "https://youtube.com/watch?v=example")
  end

  def set_current_video(subject, video)
    cookies["s#{subject.id}-current-video"] = video.id
  end

end