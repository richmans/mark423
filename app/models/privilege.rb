class Privilege < ApplicationRecord
  enum :role, [:viewer, :editor, :admin, :owner]

  belongs_to :user
  belongs_to :podcast
end
