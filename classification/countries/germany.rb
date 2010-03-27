# Country related tags

[
  'artists from germany', 'aus deutschland',
  'berlin', 'bavaria', 'bayern',
  'deutsch', 'deutschpunk', 'deutschrap', 'deutscher ska', 'deutschrock',
  'deutsch rock', 'deutschland', 'deutschpop', 'deutsch pop', 'deutsche',
  'deutscher gitarrenpop', 'deutsch indie', 'deutsch punk', 'deutschzeugs',
  'deutschsprachig und grandios', 'deutscher-deutsche', 'deutscher', 
  'deutsch undeutsch', 'deutsch aber cool', 'deutschsprachig', 'deutsche texte',
  'deutsche interpreten', 'deutsch alternative', 'deutchrock',
  'fresing', 'from: germany',
  'german', 'germany', 'german artists', 'german house', 'german ska',
  'german rock', 'german bands', 'german indie', 'german indiepop',
  'german pop', 'german alternative', 'germanindie', 'german indie combo',
  'gutes aus deutschland', 'german band', 'german but sing english',
  'german pop-rock', 'german music', 'giessen', 'german artist', 
  'good german stuff',
  'hamburger schule', 'hamburg',
  'jena', 'jena city punkrock',
  'koblenz',
  'made in germany', 'munich', 'muenchen',
  'neudeutsch', 'neo ndw', 'neue deutsche welle',
  'rock - made in germany', 'rock german'
].each do |tag|
  Classification::Resolver.add_mapping tag,  'Germany'
end

# Artists (tags) from Germany
[
  'andreas herde',
  'juli', 'jonas pfetzing',
  'marcel roemer', 'martin moeller',
  'silbermond', 'simon triebel'
].each do |artist|
  Classification::Resolver.add_mapping artist,  'Germany'
end
