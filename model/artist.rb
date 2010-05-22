class Artist
  include DataMapper::Resource

  property :name, String, :key => true
  property :country, String
  has n, :playcounts
end