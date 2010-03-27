# Country related tags

[
  'jag alskar sverige',
  'sweden', 'swedish', 'swedish rock', 'svenskt', 'swedish punk', 'svensk',
  'swedish pop', 'swedish indie pop', 'swedish indie', 'stockholm',
  'swede', 'svensk musik', 'swedes'
].each do |tag|
  Classification::Resolver.add_mapping tag, 'Sweden'
end

# Artists (tags) from Sweden

[
  'peter bjorn and john'
].each do |tag|
  Classification::Resolver.add_mapping tag, 'Sweden'
end

