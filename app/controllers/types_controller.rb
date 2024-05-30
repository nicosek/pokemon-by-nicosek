class TypesController < ApplicationController
  # GET /types
  def index
    render json: Type.all.to_json(TypesRepresentations.index_options)
  end

  # GET /types/1
  def show
    # render json: TypeSerializer.new(type).serializable_hash
    render json: type.to_json(TypesRepresentations.show_options)
  end

  private

  def type
    @type ||= Type.find(params[:id])
  end
end
