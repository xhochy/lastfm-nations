[
# Country related tags
  'canadian', 'canada',
  'ontario',
  'toronto',
# Artists (tags) from Canada
  'billy talent'
].each do |tag|
  Classification::Resolver.add_mapping tag, 'Canada'
end

