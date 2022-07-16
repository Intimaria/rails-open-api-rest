json.extract! api_v1_todo, :id, :task, :done, :due_by, :created_at, :updated_at, :owner
json.url api_v1_todo_url(api_v1_todo, format: :json)
