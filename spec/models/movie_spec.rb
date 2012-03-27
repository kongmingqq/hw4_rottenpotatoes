require 'spec_helper'

describe Movie do
  fixtures :movies
  it 'should find all the movies with same director' do
    movies = Movie.find_director("George Lucas")
    movies.size.should == 2
  end
  it 'should prints 4' do
    movies = Movie.find("4")
  end
end
