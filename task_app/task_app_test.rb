require 'minitest/autorun'
require_relative 'task_manager'

class TaskManagerTest < Minitest::Test
  def setup
    @task_manager = TaskManager.new
  end

  before do
    allow(File).to receive(:exist?).and_return(false)
    allow(File).to receive(:write)
    allow(File).to receive(:read).and_return('[]')
  end

  def test_add_task
    @task_manager.stub(:gets, ['New Task', '2023-12-31']) do
      assert_equal 0, @task_manager.instance_variable_get(:@tasks).size
      @task_manager.send(:add_task)
      assert_equal 1, @task_manager.instance_variable_get(:@tasks).size
    end
    expect { task_manager.send(:add_task) }.to change { task_manager.instance_variable_get(:@tasks).size }.by(1)
  end

  def test_edit_task
    @task_manager.instance_variable_set(:@tasks, [{ id: 1, description: 'Old Task', deadline: '2023-12-31', completed: false }])
    @task_manager.stub(:gets, ['1', 'Updated Task', '2024-01-01', 'yes']) do
      @task_manager.send(:edit_task)
      task = @task_manager.instance_variable_get(:@tasks).first
      assert_equal 'Updated Task', task[:description]
      assert_equal '2024-01-01', task[:deadline]
      assert_equal true, task[:completed]
    end
  end

  def test_delete_task
    @task_manager.instance_variable_set(:@tasks, [{ id: 1, description: 'Task to delete', deadline: '2023-12-31', completed: false }])
    @task_manager.stub(:gets, '1') do
      assert_equal 1, @task_manager.instance_variable_get(:@tasks).size
      @task_manager.send(:delete_task)
      assert_equal 0, @task_manager.instance_variable_get(:@tasks).size
    end
  end

  def test_mark_task_completed
    @task_manager.instance_variable_set(:@tasks, [{ id: 1, description: 'Task to complete', deadline: '2023-12-31', completed: false }])
    @task_manager.stub(:gets, '1') do
      @task_manager.send(:mark_task_completed)
      task = @task_manager.instance_variable_get(:@tasks).first
      assert_equal true, task[:completed]
    end
  end
end