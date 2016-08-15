class Page < ApplicationRecord
  belongs_to :parent, :polymorphic => true

  validates_presence_of :content, :parent_id
end
