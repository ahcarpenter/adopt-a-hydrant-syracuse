class MainController < ApplicationController
  def index
    @required = Sidebar.translate_required if @required.nil?
  end
end