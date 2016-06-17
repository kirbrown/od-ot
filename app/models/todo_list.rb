class TodoList < ActiveRecord::Base

  belongs_to :user
  has_many :todo_items, dependent: :destroy

  validates :title, presence: true
  validates :title, length: { minimum: 3 }

  def has_completed_items?
    todo_items.complete.size > 0
  end

  def has_incompleted_items?
    todo_items.incomplete.size > 0
  end

end
