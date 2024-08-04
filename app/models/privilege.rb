class Privilege < ApplicationRecord
  enum :role, [:viewer, :editor, :manager]

  belongs_to :user
  belongs_to :podcast
end
