class Playcount
  include DataMapper::Resource

  property :id, Serial
  property :count, Integer
  belongs_to :artist
end