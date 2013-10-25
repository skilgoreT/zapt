require_relative 'version'

class String
  def camel_case
    return self if self !~ /_/ && self =~ /[A-Z]+.*/
    split('_').map{|e| e.capitalize}.join
  end
end

module Zapt
  class Tasks

    class << self
      # This method defines a Tasks instance method that instance eval's the provided block
      # in the implementation context (e.g. package -> Package.new.instance_eval(&block)
      def define_task task_name
        define_method(task_name) do |args={}, &block|
          # instantiate class from string (there has to be a better way!)
          task = "Zapt::#{task_name.camel_case}Task".split('::').inject(Object) {|o,c| o.const_get c}.new(args)
          # for now we just execute immediately
          task.instance_eval &block unless block.nil?
        end
      end
    end

    # require all tasks
    root = File.dirname(File.absolute_path(__FILE__))
    Dir.glob(root + '/tasks/*.rb') do |task|
      require task
      Tasks.define_task File.basename(task, '_task.rb')
    end

  end
end
