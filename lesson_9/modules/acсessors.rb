# frozen_string_literal: true

module Acсessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      var_name_history = "@#{name}_history".to_sym

      define_method(name) { instance_variable_get(var_name) }

      define_method("#{name}=".to_sym) do |value|
        if instance_variable_get(var_name_history)
          instance_variable_get(var_name_history) << instance_variable_get(var_name)
        else
          instance_variable_set(var_name_history, [])
        end
        instance_variable_set(var_name, value)
      end

      define_method("#{name}_history") { instance_variable_get(var_name_history) }
    end
  end

  def strong_attr_accessor(name, type)
    var_name = "@#{name}".to_sym
    define_method(name) { instance_variable_get(var_name) }

    define_method("#{name}=".to_sym) do |value|
      raise 'Неверный тип переменной' if value.class != type

      instance_variable_set(var_name, value)
    end
  end
end
