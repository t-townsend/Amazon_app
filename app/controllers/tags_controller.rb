class TagsController < ApplicationController
  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.find params[:id]
    @taggings = Tagging.where("tag_id = ?", params[:id])
  end
end
