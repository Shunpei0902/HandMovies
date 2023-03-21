class Movie < ApplicationRecord

    has_many_attached :movies  do |attachable|
        attachable.variant :thumb, resize: "100x100"
    end

end
