class MovieThumbnailJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    movie = Movie.find(video_id)
    thumbnail_path = Rails.root.join("tmp", "thumbnails", "#{movie.id}.jpg")
    movie_file = movie.file.download
    movie = FFMPEG::Movie.new(movie_file.path)
    movie.screenshot(thumbnail_path, { resolution: '200x200' }, preserve_aspect_ratio: :width)
    movie.thumbnail.attach(io: File.open(thumbnail_path), filename: "thumbnail.jpg")
    File.delete(thumbnail_path) if File.exist?(thumbnail_path)
  end
end
