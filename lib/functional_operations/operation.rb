require "functional_operations/dsl"

class FunctionalOperations::Operation
  include FunctionalOperations::DSL

  def self.perform(params)
    new.call(params)
  end

  def call(params)
    @params = params

    process_arguments

    self.perform
  end

  protected

  def required(name, type = nil)
    raise "Missing required param: #{name}" if params[name].nil?

    if !type.nil?
      raise "Param #{name} has wrong type: #{params[name].class} instead of #{type}" unless params[name].is_a?(type)
    end

    instance_variable_set("@#{name}", params[name])
  end

  def optional(name, type = nil)
    if !params[name].nil? && !type.nil?
      raise "Param #{name} has wrong type: #{params[name].class} instead of #{type}" unless params[name].is_a?(type)
    end

    instance_variable_set("@#{name}", params[name])
  end

  def process_arguments
    arguments if respond_to?(:arguments)
  end

  def params
    @params
  end
end
