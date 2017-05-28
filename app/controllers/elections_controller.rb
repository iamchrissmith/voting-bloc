class ElectionsController < ApplicationController
  before_action :require_user

  def index
    @elections = Election.all
  end
end
