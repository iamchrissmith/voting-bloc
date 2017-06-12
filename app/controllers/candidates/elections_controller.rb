class Candidates::ElectionsController < Candidates::BaseController
  def update
    election = Election.find(params[:id])
    candidate = User.find(params[:user_id])
    election.candidates << candidate
    flash[:success] = "You are now running in this election!"
    redirect_to election
  end
end
