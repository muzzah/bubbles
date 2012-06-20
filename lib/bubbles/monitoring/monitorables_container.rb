module Bubbles

  class MonitorablesContainer
    include Enumerable

    def initialize synchronized=true
      @monitorables  = Hash.new
      @mutex = Mutex.new if synchronized
      @synchronized = synchronized
    end

    def add(monitorable)
      access_monitorables do |monitorables|
        raise ArgumentError, "Monitorable with name #{monitorable.name} already exists" if
                monitorables.has_key? monitorable.name

        monitorables[monitorable.name] = monitorable
      end

    end

    def [] monitorable_name
      access_monitorables do |monitorables|
        monitorables[monitorable_name]
      end
    end

    def each
      access_monitorables do |monitorables|
        monitorables.each_value do |monitorable|
          yield monitorable
        end
      end

    end

    def clear
      access_monitorables do |monitorables|
        monitorables.clear
      end
    end

    def size
      access_monitorables do |monitorables|
        monitorables.size
      end
    end

    def monitorables
      access_monitorables do |monitorables|
        monitorables.values
      end
    end

    private
    def access_monitorables
      if @synchronized
        @mutex.synchronize do
          yield @monitorables
        end
      else
        yield @monitorables
      end
    end
  end

end