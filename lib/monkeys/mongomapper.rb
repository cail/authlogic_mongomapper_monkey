require 'mongo_mapper'

module AuthlogicMonkeyPlugin
  
  module InstanceMethods
    def save(options={})
      if options == true or options == false
        options = {:validate => options}
      end
      super(options)
    end

    #
    # ActiveRecord emulation for authlogic
    #
    def readonly?
      false
    end
    
  end
  
  module ClassMethods
    #
    # ActiveRecord emulation for authlogic
    #
    def base_class
      self
    end
    #
    # hardcoded 'id'
    # TODO: update to some custom primary key?
    #
    def primary_key
      "id"
    end
    
    #
    # Hook for the ActiveRecord behaviour
    # TODO: implement options?
    def with_scope(options = {}, &block)
      raise ArgumentError.new("You must provide a block") unless block_given?
      result = yield
      result
    end
  
    #
    def named_scope(name, options = {}, &block)
      name = name.to_sym
      conditions = case options
        when Hash
          options
        when Proc
          options.call()
      end
      (class << self; self end).instance_eval do
        define_method name do |*args|
          #
          # TODO: Auth logic passes now SQL conditions! Translate these to mongo style, or???
          #
          self.find(:all, conditions)
        end
      end
    end
  
    #
    # ActiveRecord emulation for authlogic
    #
    def default_timezone
      :utc
    end
    
  end
  
end
