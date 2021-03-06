class VotesController < ApplicationController
  before_action :require_user

  def create
    # @election = Election.find(params[:election_id])
    @vote = Vote.create!(vote_params)
    # if @vote.save
    #   # ActionCable.server.broadcast 'results',
    #   #   results: @vote.election.results
    #   #   # message: message.body,
    #   #   # user: message.user.first_name
    #   # head :ok
    #   flash[:success] = "Your Vote has been recorded!"
    #   # redirect_to @vote.election
    #   # render json: @vote.election
    # else
    #   flash[:error] = "There was a problem, please try again"
    #   redirect_to @vote.election
    #   # render json: @vote.election.errors, status: :unprocessable_entity
    # end
  end

  private

   def vote_params
     params.require(:vote).permit(:voter_id, :recipient_id, :election_id)
   end
end
