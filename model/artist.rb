class Artist
  include DataMapper::Resource

  property :id,             Serial
  property :name,           String
  property :country,        Text
  property :last_update_at, DateTime
end
