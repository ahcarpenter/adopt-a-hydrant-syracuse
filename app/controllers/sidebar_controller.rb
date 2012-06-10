class SidebarController < ApplicationController
  def combo_form
    @required = Sidebar.translate_required if @required.nil?
  end
end