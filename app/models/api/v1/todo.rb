class Api::V1::Todo < ApplicationRecord
    attribute :done, :boolean, default: false
end
