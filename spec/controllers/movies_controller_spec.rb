require 'spec_helper'

describe MoviesController do
  describe 'find similar movies' do
    before :each do
      @fake_results = [mock('Movie1'), mock('Movie2')]
    end
    
    it 'should call the model method that search movies with same director' do
      fake_movie = mock('Movie',:director=>"George Lucas")
      Movie.should_receive(:find).with("1").and_return(fake_movie)
      Movie.should_receive(:find_director).with("George Lucas").and_return(@fake_results)
      get :search_similar, {:id => "1"}
    end
    
    it 'should redirect to home if no director info' do
      fake_movie = mock('Movie',:director=>nil,:title=>"a Movie")
      Movie.should_receive(:find).with("1").and_return(fake_movie)
      get :search_similar, {:id => "1"}
      response.should redirect_to(:action => 'index')
    end
    
    it 'should select the Search Results template for rendering' do 
      fake_movie = mock('Movie',:director=>"George Lucas")
      Movie.should_receive(:find).with("1").and_return(fake_movie)
      Movie.stub(:find_director).and_return(@fake_results)
      get :search_similar, {:id => "1"}
      response.should render_template('search_similar')
    end
    
    it 'should make the search results available to that template' do
      fake_movie = mock('Movie',:director=>"George Lucas")
      Movie.should_receive(:find).with("1").and_return(fake_movie)
      Movie.stub(:find_director).and_return(@fake_results)
      get :search_similar, {:id => "1"}
      assigns(:movies).should == @fake_results
    end
  end
end
