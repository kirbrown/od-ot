class TodoItem < ApplicationRecord
  belongs_to :todo_list

  validates :content, presence: true, length: { minimum: 2 }

  scope :complete, -> { where('completed_at is not null') }

  def completed?
    completed_at.present?
  end

  def toggle_completion!
    if completed?
      update_attributes(completed_at: nil)
    else
      update_attributes(completed_at: Time.current)
    end
  end
end
