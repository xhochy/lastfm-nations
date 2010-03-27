[
# Country related tags
  'american', 'americana', 'american pop', 'american street punk', 'america',
  'brooklyn',
  'california', 'californian punk', 'california punk',
  'detroit',
  'florida',
  'iowa',
  'jacksonville',
  'kentucky',
  'louisville', 'los angeles',
  'minnesota',
  'new wave of american metal', 'new york', 'new york city', 'nyc',
  'pennsylvania',
  'orange county',
  'san diego', 'seattle', 'seattle sound', 'seattle eclectica', 'san francisco',
  'texas punk',
  'united states', 'usa', 'us',
  'washington artists',
# Artists (tags) from the US
  'black kids', 'bloodhound gang',
  'lady gaga', 'ladygaga',
  'metro station', 'mason musso'
].each do |tag|
  Classification::Resolver.add_mapping tag, 'United States'
end

