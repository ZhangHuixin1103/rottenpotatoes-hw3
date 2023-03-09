# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Movie, type: :model do
  before(:all) do
    if described_class.where(title: 'Big Hero 6').empty?
      described_class.create(title: 'Big Hero 6',
                             rating: 'PG',
                             release_date: '2014-11-07')
    end

    # TODO(student): add more movies to use for testing
    if described_class.where(title: 'Avatar').empty?
      described_class.create(title: 'Avatar',
                             rating: 'PG-13',
                             release_date: '2009-12-18')
    end
    if described_class.where(title: 'Terminator').empty?
      described_class.create(title: 'Terminator',
                             director: 'James Cameron',
                             rating: 'R',
                             release_date: '1984-10-26')
    end
    if described_class.where(title: 'Titanic').empty?
      described_class.create(title: 'Titanic',
                             director: 'James Cameron',
                             rating: 'PG-13',
                             release_date: '1997-12-19')
    end
  end

  describe 'others_by_same_director method' do
    it 'returns all other movies by the same director' do
      # TODO(student): implement this test
      movie1 = described_class.find_by(title: 'Terminator')
      movie2 = described_class.find_by(title: 'Titanic')
      movies_same_director = movie1.others_by_same_director
      expect(movies_same_director).to be_a_kind_of(Enumerable)
      expect(movies_same_director).to include(movie1)
      expect(movies_same_director).to include(movie2)
    end

    it 'does not return movies by other directors' do
      # TODO(student): implement this test
      movie1 = described_class.find_by(title: 'Avatar')
      movie2 = described_class.find_by(title: 'Titanic')
      movie3 = described_class.find_by(title: 'Ready Player One')
      movies_same_director = movie3.others_by_same_director
      expect(movies_same_director).not_to include(movie1)
      expect(movies_same_director).not_to include(movie2)
    end
  end
end
