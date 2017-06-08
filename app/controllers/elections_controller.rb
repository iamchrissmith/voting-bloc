class ElectionsController < ApplicationController
  before_action :require_user

  def index
    if params[:elections] == "upcoming"
      @title = "Upcoming Elections"
      @elections = Election.upcoming_elections
    elsif params[:elections] == "past"
      @title = "Past Elections"
      @elections = Election.past_elections
    else
      @title = "Active Elections"
      @elections = Election.active_elections
    end
  end

  def show
    @election = Election.find(params[:id])
    @vote = Vote.new
  end
end
