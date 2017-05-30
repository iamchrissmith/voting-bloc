class ElectionsController < ApplicationController
  before_action :require_user

  def index
    @elections = Election.all
  end

  def show
    @election = Election.find(params[:id])
    @vote = Vote.new
  end
end
