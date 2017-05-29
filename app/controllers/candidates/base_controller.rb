class Candidates::BaseController < ApplicationController
  before_action :require_candidate

  def require_candidate
    render file: '/public/404' unless current_candidate?
  end
end
