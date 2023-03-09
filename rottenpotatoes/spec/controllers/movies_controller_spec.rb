# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  before(:all) do
    if Movie.where(title: 'Big Hero 6').empty?
      Movie.create(title: 'Big Hero 6',
                   rating: 'PG',
                   release_date: '2014-11-07')
    end

    # TODO(student): add more movies to use for testing
    if Movie.where(title: 'Avatar').empty?
      Movie.create(title: 'Avatar',
                   rating: 'PG-13',
                   release_date: '2009-12-18')
    end
    if Movie.where(title: 'Terminator').empty?
      Movie.create(title: 'Terminator',
                   director: 'James Cameron',
                   rating: 'R',
                   release_date: '1984-10-26')
    end
    if Movie.where(title: 'Titanic').empty?
      Movie.create(title: 'Titanic',
                   director: 'James Cameron',
                   rating: 'PG-13',
                   release_date: '1997-12-19')
    end
  end

  describe 'when trying to find movies by the same director' do
    it 'returns a valid collection when a valid director is present' do
      # TODO(student): implement this test
      movie1 = Movie.find_by(title: 'Terminator')
      movie2 = Movie.find_by(title: 'Titanic')
      movie3 = Movie.find_by(title: 'Avatar')
      get :show_by_director, params: { id: movie1.id }
      expect(assigns(:movies)).to be_a_kind_of(Enumerable)
      expect(assigns(:movies)).to include(movie2)
      expect(assigns(:movies)).not_to include(movie3)
    end

    it 'redirects to index with a warning when no director is present' do
      # TODO(student): implement this test
      movie = Movie.find_by(title: 'Big Hero 6')
      get :show_by_director, params: { id: movie.id }
      expect(response).to redirect_to(movies_path)
      expect(flash[:warning]).to match(/'#{movie.title}' has no director info./)
    end
  end

  describe 'creates' do
    it 'movies with valid parameters' do
      get :create, params: { movie: { title: 'Cloud Atlas', director: 'Lana Wachowski',
                                      rating: 'R', release_date: '2012-10-26' } }
      expect(response).to redirect_to movies_path
      expect(flash[:notice]).to match(/Cloud Atlas was successfully created./)
      Movie.find_by(title: 'Cloud Atlas').destroy
    end
  end

  describe 'updates' do
    it 'redirects to the movie details page and flashes a notice' do
      movie = Movie.create(title: 'Ready Player One', director: 'Steven Spielberg',
                           rating: 'PG-13', release_date: '2018-3-29')
      get :update, params: { id: movie.id, movie: {
        description: 'Ready Player One is a sweetly nostalgic thrill ride ' \
                     'that neatly encapsulates Spielbergs strengths while ' \
                     'adding another solidly engrossing adventure to his filmography.' } }

      expect(response).to redirect_to movie_path(movie)
      expect(flash[:notice]).to match(/Ready Player One was successfully updated./)
      movie.destroy
    end

    it 'actually does the update' do
      movie = Movie.create(title: 'Ready Player One', director: 'Steven Spielberg',
                           rating: 'PG-13', release_date: '2018-3-29')
      get :update, params: { id: movie.id, movie: { director: 'Not Steven' } }

      expect(assigns(:movie).director).to eq('Not Steven')
      movie.destroy
    end
  end
end
