class Movie < ActiveRecord::Base
  def self.other_same_director(id)
    movie = Movie.find(id)
    if movie.director.blank?
      'director miss'
    else
      Movie.where(['director = :director', director: movie.director])
    end
  end
end
