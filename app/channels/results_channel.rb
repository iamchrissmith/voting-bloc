class ResultsChannel < ApplicationCable::Channel
  def follow(data)
    stop_all_streams
    stream_from "results:#{data['result_id'].to_i}:results"
  end

  def unfollow
    stop_all_streams
  end
end
