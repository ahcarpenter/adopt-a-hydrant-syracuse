class MainController < ApplicationController
  def index
    @required = I18n.t('labels.required') if @required.nil?
  end
end