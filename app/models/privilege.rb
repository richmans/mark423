class Privilege < ApplicationRecord
  enum :role, [:viewer, :editor, :manager, :owner]

  belongs_to :user
  belongs_to :podcast
end
