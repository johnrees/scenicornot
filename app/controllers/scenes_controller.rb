# frozen_string_literal: true

class ScenesController < ApplicationController
  def index
    @q = Scene.ransack(params[:q])
    @scenes = @q.result.page(params[:page])
  end
end
