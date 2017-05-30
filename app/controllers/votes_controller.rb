class VotesController < ApplicationController
  before_action :require_user

  def create
    @election = Election.find(params[:election_id])
    @vote = Vote.new(vote_params)
    @vote.election_id = @election.id
    binding.pry
    if @vote.save
      flash[:success] = "Your Vote has been recorded!"
      redirect_to @election
    else
      flash[:error] = "There was a problem, please try again"
      redirect_to @election
    end
  end

  private

   def vote_params
     params.require(:vote).permit(:voter_id, :recipient_id)
   end
end
