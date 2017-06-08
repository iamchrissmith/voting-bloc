json.(results, :first, :last)
json.results(@election.results) do |result|
  json.extract! result, :first, :last
end
