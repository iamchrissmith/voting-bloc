# json.(election), :first, :last)
# binding.pry
json.results(election) do |result|
  json.extract! result, :first, :last
end
