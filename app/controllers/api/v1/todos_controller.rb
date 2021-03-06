class Api::V1::TodosController < ApplicationController
  include Secured


  # before_action :authenticate_request!
  before_action :set_owner
  before_action :set_api_v1_todo, only: %i[ show update destroy ]

  TodoReducer = Rack::Reducer.new(
    Api::V1::Todo.all,
    ->(done:) { where(done: done.downcase) },
  )

  # GET /api/v1/todos.json
  def index
    @api_v1_todos = TodoReducer.apply(params).where(owner: @owner)
  end

  # GET /api/v1/todos/1.json
  def show
  end

  # POST /api/v1/todos.json
  def create
    @api_v1_todo = Api::V1::Todo.new(default_values.merge(api_v1_todo_params))

    if @api_v1_todo.save
      render :show, status: :created, location: @api_v1_todo
    else
      render json: @api_v1_todo.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/todos/1.json
  def update
    if @api_v1_todo.update(api_v1_todo_params)
      render :show, status: :ok, location: @api_v1_todo
    else
      render json: @api_v1_todo.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/todos/1.json
  def destroy
    if @api_v1_todo.nil?
      render json: { message: 'Task not found' }, status: :not_found
    elsif @api_v1_todo.destroy
      render :show, status: :ok, location: @api_v1_todo
    end 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_todo
      @api_v1_todo = Api::V1::Todo.find_by(id: params[:id], owner: @owner)
    end

    def set_owner 
      @owner = @token[:sub]
    end 

    def default_values
      {
        owner: @owner
      }
    end
    # Only allow a list of trusted parameters through.
    def api_v1_todo_params
      params.require(:api_v1_todo).permit(:task, :done, :due_by)
    end
end
