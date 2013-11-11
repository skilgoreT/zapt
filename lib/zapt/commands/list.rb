require_relative '../../zapt'
module Zapt

  class CLI < Thor

    desc "list", "list tasks in provided task file"
    method_option :tasks, :aliases => "-t", :type=>:string, :required=>true, :desc => "Task file"
    def list
      # quiet zapt for this command
      $logger.level = Logger::ERROR
      task_file = options[:tasks]
      Zapt.load_and_eval task_file, foo:'bar'
      printf("%-20s%-60s\n", "Task Name", "Description")
      printf("%-80s\n", "-" * 80)
      Zapt::Tasks.registry.each do |k,v|
        printf("%-20s%-60s\n", k, v.desc)
      end
    end

  end
end