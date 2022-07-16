json.extract! api_v1_todo, :id, :task, :owner, :done, :due_by, :created_at, :updated_at
json.url api_v1_todo_url(api_v1_todo, format: :json)
