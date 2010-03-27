# Country related tags

[
  'american', 'americana', 'american pop', 'american street punk',
  'brooklyn',
  'california', 'californian punk', 'california punk',
  'detroit',
  'florida',
  'iowa',
  'jacksonville',
  'kentucky',
  'louisville',
  'minnesota',
  'new wave of american metal', 'new york', 'new york city', 'nyc',
  'orange county',
  'san diego', 'seattle', 'seattle sound', 'seattle eclectica', 'san francisco',
  'texas punk',
  'united states', 'usa', 'us',
  'washington artists'
].each do |tag|
  Classification::Resolver.add_mapping tag, 'United States'
end

# Artists (tags) from the US
[
  'black kids',
  'lady gaga', 'ladygaga'
].each do |tag|
  Classification::Resolver.add_mapping tag, 'United States'
end

