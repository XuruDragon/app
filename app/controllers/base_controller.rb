class BaseController < ApplicationController
  skip_authorization_check
  before_filter :authenticate_user!, only: []

  def index
  end
end
