class Api::V1::Todo < ApplicationRecord
    validates_presence_of :task
    attribute :done, :boolean, default: false

    alias_attribute :todo, :task
    alias_attribute :completed, :done
end
