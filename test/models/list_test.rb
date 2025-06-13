# frozen_string_literal: true

require "test_helper"

class ListTest < ActiveSupport::TestCase
  test "a list is invalid without a title" do
    list = List.new(description: "desc")
    assert_not list.valid?
    assert_includes list.errors[:title], "can't be blank"
  end

  test "a list normalizes its title" do
    list = List.new(title: "  tItre test  ", description: "desc")
    list.save!
    assert_equal "Titre test", list.title
  end

  test "a list cannot be destroyed if it has incomplete tasks" do
    list = List.create!(title: "A", description: "B")
    list.tasks.create!(title: "Task", completed: false)
    assert_not list.destroy, "The list should not be deletable"
    assert_includes list.errors[:base], "Impossible de supprimer une liste avec des tâches incomplètes."
  end

  test "percent_complete returns the correct percentage" do
    list = List.create!(title: "A", description: "B")
    list.tasks.create!(title: "T1", completed: true)
    list.tasks.create!(title: "T2", completed: false)
    assert_equal 50, list.percent_complete
  end
end
