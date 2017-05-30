class VotesController < ApplicationController
  before_action :require_user

  def create
    # @election = Election.find(params[:election_id])
    @vote = Vote.create(vote_params)
    if @vote.save
      flash[:success] = "Your Vote has been recorded!"
      redirect_to @vote.election
    else
      flash[:error] = "There was a problem, please try again"
      redirect_to @vote.election
    end
  end

  private

   def vote_params
     params.require(:vote).permit(:voter_id, :recipient_id, :election_id)
   end
end
