require "test_helper"

class TastTest < ActiveSupport::TestCase
  test "a task is invalid without a title" do
    task = Task.new(description: "desc", list: lists(:one))
    assert_not task.valid?
    assert_includes task.errors[:title], "can't be blank"
  end

  test "a task normalizes its title" do
    task = Task.new(title: "  tItre tâche  ", description: "desc", list: lists(:one))
    task.save!
    assert_equal "Titre Tâche", task.title
  end

  test "title uniqueness within a list" do
    list = List.create!(title: "A", description: "B")
    list.tasks.create!(title: "Task", completed: false)
    t2 = list.tasks.new(title: "Task", completed: false)
    assert_not t2.valid?
    assert_includes t2.errors[:title], "has already been taken"
  end

  test "scopes completed/incomplete" do
    list = List.create!(title: "A", description: "B")
    t1 = list.tasks.create!(title: "T1", completed: true)
    t2 = list.tasks.create!(title: "T2", completed: false)
    assert_includes Task.completed, t1
    assert_includes Task.incomplete, t2
  end

  test "enum priority works" do
    task = Task.new(title: "T", description: "D", list: lists(:one), priority: :high)
    assert_equal "high", task.priority
    assert task.high?
  end
end
