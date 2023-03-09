class Movie < ActiveRecord::Base
  def others_by_same_director
    if director.blank?
      return 'director miss'
    else
      Movie.where(['director = :director', director: director])
    end
  end
end
