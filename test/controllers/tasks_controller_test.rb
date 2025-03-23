require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task1 = Task.create(title: "Task 1", description: "Description 1", username: "User1", email: "user1@example.com")
    @task2 = Task.create(title: "Task 2", description: "Description 2", username: "User2", email: "user2@example.com")
  end

  test "should return tasks in descending order when feature flag is enabled" do
    Flipper.enable(:new_task_feature)

    get tasks_url, as: :json  # Explicitly request JSON

    puts response.body  # Debugging: Print response to check what it contains

    assert_response :success
    response_data = JSON.parse(response.body)
    assert_equal [@task2.id, @task1.id], response_data.map { |t| t["id"] }
  end

  test "should return tasks in default order when feature flag is disabled" do
    Flipper.disable(:new_task_feature)

    get tasks_url, as: :json  # Explicitly request JSON

    puts response.body  # Debugging: Print response to check what it contains

    assert_response :success
    response_data = JSON.parse(response.body)
    assert_equal [@task1.id, @task2.id], response_data.map { |t| t["id"] }
  end
end
