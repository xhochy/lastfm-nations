class Library
  include DataMapper::Resource

  property :username, String, :key => true
  has n, :playcounts
end