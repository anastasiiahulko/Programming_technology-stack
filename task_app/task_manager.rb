require 'json'
require 'date'

class TaskManager
  DATA_FILE = 'tasks.json'

  def initialize
    @tasks = load_tasks
  end

  def run
    loop do
      puts "\nTask Manager"
      puts "1. Add Task"
      puts "2. Edit Task"
      puts "3. Delete Task"
      puts "4. List Tasks"
      puts "5. Filter Tasks"
      puts "6. Mark Task as Completed"
      puts "7. Exit"
      print "Choose an option: "
      option = gets.chomp.to_i

      case option
      when 1
        add_task
      when 2
        edit_task
      when 3
        delete_task
      when 4
        list_tasks
      when 5
        filter_tasks
      when 6
        mark_task_completed
      when 7
        save_tasks
        break
      else
        puts "Invalid option. Please try again."
      end
    end
  end

  private

  def load_tasks
    if File.exist?(DATA_FILE)
      JSON.parse(File.read(DATA_FILE), symbolize_names: true)
    else
      []
    end
  end

  def save_tasks
    File.write(DATA_FILE, JSON.pretty_generate(@tasks))
  end

  def add_task
    print "Enter task description: "
    description = gets.chomp
    deadline = nil
    loop do
      print "Enter deadline (YYYY-MM-DD): "
      deadline_input = gets.chomp
      begin
        deadline = Date.parse(deadline_input)
        break
      rescue ArgumentError
        puts "Invalid date format. Please enter a valid date in the format YYYY-MM-DD."
      end
    end
    @tasks << { id: next_id, description: description, deadline: deadline.to_s, completed: false }
    puts "Task added successfully."
  end

  def edit_task
    list_tasks
    print "Enter task ID to edit (or type 'exit' to cancel): "
    id_input = gets.chomp
    return if id_input.downcase == 'exit'
    id = id_input.to_i
    task = find_task_by_id(id)
    if task
      print "Enter new description (leave blank to keep current or type 'exit' to cancel): "
      new_description = gets.chomp
      return if new_description.downcase == 'exit'
      new_deadline = nil
      loop do
        print "Enter new deadline (YYYY-MM-DD, leave blank to keep current or type 'exit' to cancel): "
        new_deadline_input = gets.chomp
        return if new_deadline_input.downcase == 'exit'
        break if new_deadline_input.empty?
        begin
          new_deadline = Date.parse(new_deadline_input)
          break
        rescue ArgumentError
          puts "Invalid date format. Please enter a valid date in the format YYYY-MM-DD."
        end
      end
      print "Is the task completed? (yes/no, leave blank to keep current or type 'exit' to cancel): "
      new_status = gets.chomp
      return if new_status.downcase == 'exit'

      task[:description] = new_description unless new_description.empty?
      task[:deadline] = new_deadline.to_s unless new_deadline.nil?
      task[:completed] = new_status.downcase == 'yes' unless new_status.empty?

      puts "Task updated successfully."
    else
      puts "Task not found."
    end
  end

  def delete_task
    list_tasks
    print "Enter task ID to delete (or type 'exit' to cancel): "
    id_input = gets.chomp
    return if id_input.downcase == 'exit'
    id = id_input.to_i
    task = find_task_by_id(id)
    if task
      @tasks.delete(task)
      puts "Task deleted successfully."
    else
      puts "Task not found."
    end
  end

  def list_tasks
    if @tasks.empty?
      puts "No tasks available."
    else
      @tasks.each do |task|
        status = task[:completed] ? "[Completed]" : "[Pending]"
        puts "ID: #{task[:id]}, Description: #{task[:description]}, Deadline: #{task[:deadline]}, Status: #{status}"
      end
    end
  end

  def filter_tasks
    puts "Filter by:"
    puts "1. Status (Completed/Pending)"
    puts "2. Deadline (Before/After a specific date)"
    print "Choose an option: "
    option = gets.chomp.to_i

    case option
    when 1
      print "Enter status (completed/pending or type 'exit' to cancel): "
      status = gets.chomp.downcase
      return if status == 'exit'
      filtered_tasks = @tasks.select { |task| status == 'completed' ? task[:completed] : !task[:completed] }
      display_filtered_tasks(filtered_tasks)
    when 2
      date = nil
      loop do
        print "Enter date (YYYY-MM-DD or type 'exit' to cancel): "
        date_input = gets.chomp
        return if date_input.downcase == 'exit'
        begin
          date = Date.parse(date_input)
          break
        rescue ArgumentError
          puts "Invalid date format. Please enter a valid date in the format YYYY-MM-DD."
        end
      end
      print "Before or After the date? (before/after or type 'exit' to cancel): "
      filter_type = gets.chomp.downcase
      return if filter_type == 'exit'
      if filter_type == 'before'
        filtered_tasks = @tasks.select { |task| Date.parse(task[:deadline]) < date }
      elsif filter_type == 'after'
        filtered_tasks = @tasks.select { |task| Date.parse(task[:deadline]) > date }
      else
        puts "Invalid option."
        return
      end
      display_filtered_tasks(filtered_tasks)
    else
      puts "Invalid option."
    end
  end

  def mark_task_completed
    list_tasks
    print "Enter task ID to mark as completed (or type 'exit' to cancel): "
    id_input = gets.chomp
    return if id_input.downcase == 'exit'
    id = id_input.to_i
    task = find_task_by_id(id)
    if task
      task[:completed] = true
      puts "Task marked as completed."
    else
      puts "Task not found."
    end
  end

  def display_filtered_tasks(tasks)
    if tasks.empty?
      puts "No tasks match the filter criteria."
    else
      tasks.each do |task|
        status = task[:completed] ? "[Completed]" : "[Pending]"
        puts "ID: #{task[:id]}, Description: #{task[:description]}, Deadline: #{task[:deadline]}, Status: #{status}"
      end
    end
  end

  def find_task_by_id(id)
    @tasks.find { |task| task[:id] == id }
  end

  def next_id
    @tasks.empty? ? 1 : @tasks.map { |task| task[:id] }.max + 1
  end
end

# Run the TaskManager
if __FILE__ == $0
  TaskManager.new.run
end