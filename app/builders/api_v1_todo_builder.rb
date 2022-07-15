class ApiV1TodoBuilder

    attr_accessor :params, :owner, :todo_model
  
    # consider using a Struct if you keep a very basic initializer
    def initialize(owner, params)
      self.owner = owner
      self.params = params
    end
  
    def build
      todo_model
    end
  
    def create
      todo_model.tap{|m| m.save }
    end
  
    def todo_model
      @todo_model ||= Api::V1::Todo.new(default_values.merge(params))
    end
  
    def default_values
      {
        owner: self.owner
      }
    end
  end