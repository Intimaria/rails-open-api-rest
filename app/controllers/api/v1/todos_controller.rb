class Api::V1::TodosController < SecuredController
  skip_before_action :authorize_request, only: [:index, :show]
  before_action :set_api_v1_todo, only: %i[ show update destroy ]

  TodoReducer = Rack::Reducer.new(
    Api::V1::Todo.all,
    ->(done:) { where(done: done.downcase) },
  )

  # GET /api/v1/todos.json
  def index
    @api_v1_todos = TodoReducer.apply(params)
  end

  # GET /api/v1/todos/1.json
  def show
  end

  # POST /api/v1/todos.json
  def create
    @api_v1_todo = Api::V1::Todo.new(api_v1_todo_params)

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
    @api_v1_todo.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_todo
      @api_v1_todo = Api::V1::Todo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def api_v1_todo_params
      params.require(:api_v1_todo).permit(:task, :done, :due_by)
    end
end
