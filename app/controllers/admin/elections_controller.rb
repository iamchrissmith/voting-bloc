class Admin::ElectionsController < Admin::BaseController
  before_action :get_election, only: [:destroy, :edit, :update]
  before_action :get_candidates, only: [:new, :edit]

  def new
    @election = Election.new
  end

  def create
    @election = Election.create(election_params)
    if @election.save
      flash[:success] = "Election created!"
      redirect_to elections_path
    else
      render :new
    end
  end

  def destroy
    @election.destroy
    flash[:success] = "Election '#{@election.topic}' Deleted!"
    redirect_to elections_path
  end

  def edit
  end

  def update
    @election.update(election_params)
    if @election.save
      flash[:success] = "Election Updated!"
      redirect_to @election
    else
      render :edit
    end
  end

  private

   def election_params
     params[:election][:start_date] = Date.strptime(params[:election][:start_date],'%Y-%m-%d')
     params[:election][:end_date] = Date.strptime(params[:election][:end_date],'%Y-%m-%d')
     params.require(:election).permit(:start_date, :end_date, :topic, :description, candidate_ids:[])
   end

   def get_election
     @election = Election.find(params[:id])
   end

   def get_candidates
     @candidates = User.candidate
   end
end
