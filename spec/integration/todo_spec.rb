require 'swagger_helper'
require 'generate_token'

RSpec.describe '../integration/api/v1/todos', type: :request do

    path '/api/v1/todos' do
        get 'Lists todos' do
            tags 'Todo'
            description 'Lists todos'
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
                 }, example: {
                    id: 1,
                    task: 'Water plants',
                    done: false,
                    due_by: Date.today,
                    created_at: Date.today,
                    updated_at: Date.today,
                    url: "https://open-api-swagger.herokuapp.com/api/v1/todos/1.json"
                }
               }
               run_test!
            end
          end
        end 
path '/api/v1/todos' do
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
             }, example: {
                id: 1,
                task: 'Water plants',
                done: false,
                due_by: Date.today,
                created_at: Date.today,
                updated_at: Date.today,
                url: "https://open-api-swagger.herokuapp.com/api/v1/todos/1.json"
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
        security [JWT: {}]
        parameter name: 'Authorization', in: :header, type: :string
        parameter name: :api_v1_todo, in: :body, schema: {
            type: :object,
            properties: {
                task: { type: :string },
                done: { type: :boolean, nullable: true},
                due_by: { type: :date, nullable: true},
             }, example: {
                task: 'Water plants',
                done: false,
                due_by: Date.today,
            },
          required: [ 'task', 'done', 'due_by' ]
        }
  
        let(:api_v1_todo) {  { api_v1_todo: { task: 'foo', done: nil, due_by: Date.today } } }
  
        response '201', 'success' do
           let(:'Authorization') {"#{GenerateToken.test_token}"}
            examples 'application/json' => {
                task: 'Water plants',
                done: false,
                due_by: Date.today,
            }
          run_test!
        end
  
        response '422', 'invalid request' do
          let(:api_v1_todo) {{ api_v1_todo: {  } } }
          examples 'application/json' => {
            done: false,
            due_by: Date.today,
        }
          run_test! 
        end

        response '401', 'unauthorized request' do
          let(:'Authorization') {"#{nil}"}
          examples 'application/json' => {
              task: 'Water plants',
              done: false,
              due_by: Date.today,
          }
          run_test!
        end
      end
    end

    path '/api/v1/todos/{id}' do
        parameter name: :id, in: :path, type: :string

        let(:id) { Api::V1::Todo.create(task: 'foo', done: false, due_by: Date.today + 8).id }
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
                 examples 'application/json' => {
                    id: 1,
                    task: 'Water plants',
                    done: false,
                    due_by: Date.today,
                    created_at: Date.today,
                    updated_at: Date.today,
                    url: "https://open-api-swagger.herokuapp.com/api/v1/todos/1.json"
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
            security [JWT: {}]
            parameter name: 'Authorization', in: :header, type: :string
            parameter name: :id, in: :path, type: :integer
            parameter name: :api_v1_todo, in: :body, schema: {
                type: :object,
                properties: {
                    task: { type: :string },
                    done: { type: :boolean},
                    due_by: { type: :date},
                 }, example: {
                    task: 'Water plants',
                    done: false,
                    due_by: Date.today,
                }
            }

            response '200', 'success' do
              let(:'Authorization') {"#{GenerateToken.test_token}"}
                examples 'application/json' => {
                    task: 'Water plants',
                    done: false,
                    due_by: Date.today,
                }
                let(:id) { Api::V1::Todo.create(task: 'foo', done: false, due_by: Date.today + 8).id }
                let(:api_v1_todo) { {api_v1_todo: { done: false} } } 
                run_test!
            end
            response '422', 'invalid request' do
              let(:'Authorization') {"#{GenerateToken.test_token}"}
                let(:api_v1_todo) {{ api_v1_todo: {  } } }
                run_test! 
              end
            response '401', 'unauthorized request' do
              let(:'Authorization') {"#{nil}"}
              let(:id) { Api::V1::Todo.create(task: 'foo', done: false, due_by: Date.today + 8).id }
              let(:api_v1_todo) { {api_v1_todo: { done: false} } } 
              run_test!
            end
          end 

          patch 'Updates a todo' do
            tags 'Todo'
            description 'Updates a specific todo by id'
            operationId 'patchTodo'
            consumes 'application/json'
            produces 'application/json'
            security [JWT: {}]
            parameter name: 'Authorization', in: :header, type: :string
            parameter name: :id, in: :path, type: :integer
            parameter name: :api_v1_todo, in: :body, schema: {
                type: :object,
                properties: {
                    task: { type: :string },
                    done: { type: :boolean},
                    due_by: { type: :date},
                 }, example: {
                    done: true,
                }
            }

            response '200', 'success' do
              let(:'Authorization') {"#{GenerateToken.test_token}"}
                examples 'application/json' => {
                    done: false,
                }
                let(:id) { Api::V1::Todo.create(task: 'foo', done: false, due_by: Date.today + 8).id }
                let(:api_v1_todo) { {api_v1_todo: { done: false} } } 
                run_test!
            end
            response '422', 'invalid request' do
              let(:'Authorization') {"#{GenerateToken.test_token}"}
                let(:api_v1_todo) {{ api_v1_todo: {  } } }
                run_test! 
              end
              response '401', 'unauthorized request' do
                let(:'Authorization') {"#{nil}"}
                let(:id) { Api::V1::Todo.create(task: 'foo', done: false, due_by: Date.today + 8).id }
                let(:api_v1_todo) { {api_v1_todo: { done: false} } } 
                run_test!
              end
          end


          delete 'Deletes a todo' do
            tags 'Todo'
            description 'Deletes a specific todo by id'
            operationId 'deleteTodo'
            produces 'application/json'
            security [JWT: {}]
            parameter name: 'Authorization', in: :header, type: :string
            parameter name: :id, in: :path, type: :integer

            response '204', 'success' do
                let(:'Authorization') {"#{GenerateToken.test_token}"}
                let(:id) { Api::V1::Todo.create(task: 'foo', done: false, due_by: Date.today + 8).id }
                run_test!
            end
          end 
     end

     path '/api/v1/todos?done={done}' do
        get 'Lists completed or pending todos' do
            tags 'Todo'
            description 'Lists completed or pending todos'
            produces 'application/json'
            parameter name: :done, in: :path, type: :boolean
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
                 }, example: {
                    id: 1,
                    task: 'Water plants',
                    done: true,
                    due_by: Date.today,
                    created_at: Date.today,
                    updated_at: Date.today,
                    url: "https://open-api-swagger.herokuapp.com/api/v1/todos/1.json"
                }
               }
               run_test!
            end
          end
        end
  end


