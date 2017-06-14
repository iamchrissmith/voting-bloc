json.results(election) do |result|
  json.name result.first
  json.votes result.last
end
