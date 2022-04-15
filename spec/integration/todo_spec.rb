require 'swagger_helper'

RSpec.describe '../integration/api/v1/todos', type: :request do
path '/api/v1/todos' do
    3.times { |i| let(:api_v1_todo) { Api::V1::Todo.create(task: "foo-#{i}", done: false, due_by: Date.today + i) }}

    get 'Lists todos' do
        tags 'Todo'
        description 'Lists todo'
        produces 'application/json'
        response '200', 'success' do

          schema type: :array,
           items: {
             type: :object,
             properties: {
                id: { type: :integer },
                task: { type: :string },
                done: { type: :boolean},
                due_by: { type: :date},
                created_at: { type: :datetime},
                updated_at: { type: :datetime},
                url: { type: :string }
             }
           }
           run_test!
        end
      end

      post 'Creates a todo' do
        tags 'Todo'
        description 'Creates a new todo from provided data'
        operationId 'createTodo'
        consumes 'application/json'
        produces 'application/json'
        parameter name: :api_v1_todo, in: :body, schema: {
            type: :object,
            properties: {
                id: { type: :integer },
                task: { type: :string },
                done: { type: :boolean},
                due_by: { type: :date},
                created_at: { type: :datetime},
                updated_at: { type: :datetime},
                url: { type: :string }
             },
          required: [ 'task', 'done', 'due_by' ]
        }
  
        let(:api_v1_todo) {  { api_v1_todo: { task: 'foo', done: false, due_by: Date.today } } }
  
        response '201', 'success' do
          run_test!
        end
  
        response '422', 'invalid request' do
          let(:api_v1_todo) {{ api_v1_todo: {  } } }
          run_test! 
        end
      end
    end

    path '/api/v1/todos/{id}' do
        parameter name: :id, in: :path, type: :string

        let(:id) { api_v1_todo.id }
        let(:api_v1_todo) { Api::V1::Todo.create(task: 'foo', done: false, due_by: Date.today + 8) }

        get 'Retrieves a todo' do
            tags 'Todo'
            description 'Retrieves a specific todo by id'
            operationId 'getTodo'
            produces 'application/json'

            response '200', 'success' do
              schema type: :object,
                 properties: {
                   id: { type: :integer },
                   task: { type: :string },
                   done: { type: :boolean},
                   due_by: { type: :date},
                   created_at: { type: :datetime},
                   updated_at: { type: :datetime},
                   url: { type: :string }
                 }
               
               let(:id) { api_v1_todo.id }
               run_test!

               response '404', 'not found' do
                let(:id) { 'invalid' }
                run_test!
              end
            end
          end
        
        
          put 'Updates a todo' do
            tags 'Todo'
            description 'Updates a specific todo by id'
            operationId 'updateTodo'
            consumes 'application/json'
            produces 'application/json'
            parameter name: :id, in: :path, type: :integer
            parameter name: :api_v1_todo, in: :body, schema: {
                type: :object,
                properties: {
                    task: { type: :string },
                    done: { type: :boolean},
                    due_by: { type: :date},
                 }
            }

            response '200', 'success' do
                let(:id) { Api::V1::Todo.create(task: 'foo', done: false, due_by: Date.today + 8).id }
                let(:api_v1_todo) { {api_v1_todo: { done: false} }} 
                run_test!
            end
          end 


          delete 'Deletes a todo' do
            tags 'Todo'
            description 'Deletes a specific todo by id'
            operationId 'deleteTodo'
            produces 'application/json'
            parameter name: :id, in: :path, type: :integer

            response '204', 'success' do
                let(:id) { Api::V1::Todo.create(task: 'foo', done: false, due_by: Date.today + 8).id }
                run_test!
            end
          end 
     end
  end


