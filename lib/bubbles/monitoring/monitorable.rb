require 'thread'
require 'observer'

module Bubbles
  class Monitorable
    include Observable
    
    private
    attr_accessor :monitored_value
    
    public
    attr_reader :name
    attr_reader :description
    attr_reader :value_semantics


    def initialize
      raise "Cannot instantiate Monitorable, must use subclasses..."
    end

    def change_monitored_value &block
      @mutex.synchronize do
        @monitored_value = yield @monitored_value
      end
      raise_event
    end

    def value
      @mutex.synchronize do
        monitored_value
      end
    end
    
    def value= new_value
      @mutex.synchronize do
        @monitored_value=new_value
      end
      raise_event
    end

    private
    def init_properties(name, description, value_semantics, initial_value = nil)
      raise ArgumentError "Value Semantics is not a valid value => #{value_semantics}" unless ValueSemantics.is_acceptable_value(value_semantics)
      raise ArgumentError "Name cannot be blank" if name.nil?
      raise ArgumentError "Description cannot be blank" if description.nil?
      @name = name
      @description = description
      @value_semantics = value_semantics
      @mutex = Mutex.new
      @monitored_value= initial_value
    end

    def raise_event
      changed
      notify_observers(self)
    end

  end

end