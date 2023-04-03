class Movie < ApplicationRecord

	has_many_attached :movies  do |attachable|
		attachable.variant :thumb, resize: "100x100"
	end

	has_many_attached :thumbnail

	def generate_thumbnails
    movies.each do |movie|
      movie.movies.preview(resize: "100x100").processed
    end
	end


	has_many :comments, dependent: :destroy  #Movie.commentsで、投稿が所有するコメントを取得できる。
	belongs_to :user

	with_options presence: true do
		validates :title
		validates :movies
	end


end
