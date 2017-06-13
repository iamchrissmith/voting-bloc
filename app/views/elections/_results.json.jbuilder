json.results(election) do |result|
  json.candidate result.first
  json.votes result.last
end
