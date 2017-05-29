class Admin::ElectionsController < Admin::BaseController
  def new
    @election = Election.new
    @candidates = User.candidate
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
    @election = Election.find(params[:id])
    @election.destroy
    flash[:success] = "Election '#{@election.topic}' Deleted!"
    redirect_to elections_path
  end

  private

   def election_params
     params[:election][:start_date] = Date.strptime(params[:election][:start_date],'%Y-%m-%d')
     params[:election][:end_date] = Date.strptime(params[:election][:end_date],'%Y-%m-%d')
     params.require(:election).permit(:start_date, :end_date, :topic, :description, user_ids:[])
   end
end
