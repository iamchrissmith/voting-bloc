class ElectionRelayJob < ApplicationJob
  queue_as :default

  def perform(results)
    ActionCable.server.broadcast "results",
                                  result:ElectionsController.render(partial: 'elections/results',
                                                                      locals: {election:results.election.results})
  end
end
