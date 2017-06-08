class ElectionRelayJob < ApplicationJob
  def perform(election)
    # result = ElectionsController.render(partial: 'elections/results',
    #                                     locals: {election:election})
    ActionCable.server.broadcast "elections:#{election.id}:results",
                                  result:result

  end
end
