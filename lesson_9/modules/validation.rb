# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :validations
    def validate(name, type, args = nil)
      var_name = "@#{name}".to_sym
      @validations ||= []
      @validations << { name: name, type: type, args: args }
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |validate|
        value = instance_variable_get("@#{validate[:name]}")
        send("validate_#{validate[:type]}", value, *validate[:args])
      end
    end

    def validate_presence(value)
      raise '!!!Значение не заполнено!!!' if value.nil? || value.empty?
    end

    def validate_type(value, type)
      raise '!!!Неверный тип!!!' if value.class != type
    end

    def validate_format(value, format)
      raise '!!!Неверный формат!!!' if value !~ format
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end
  end
end
