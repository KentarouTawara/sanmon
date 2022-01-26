require 'csv'

csv = CSV.read('db/fixtures/csv/words.csv')
csv.each do |word|
  Word.seed do |s|
    s.id = word[0]
    s.name = word[1]
  end
end