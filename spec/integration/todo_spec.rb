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
        end
  end


