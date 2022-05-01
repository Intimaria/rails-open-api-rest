class Api::V1::Todo < ApplicationRecord
    validates_presence_of :task
    attribute :done, :boolean, default: false

    alias_attribute :todo, :task
    alias_attribute :completed, :done

    scope :completed, -> { where(done: true) }
    scope :past_due, ->  {where("due_by <= ?", Date.today)}
end
