# Copyright (C) 2012-2022 Zammad Foundation, https://zammad-foundation.org/

class CoreWorkflow::Condition::ContainsNot < CoreWorkflow::Condition::Backend
  def match
    return true if value.blank?

    result = false
    value.each do |current_value|
      current_match = false
      condition_value.each do |current_condition_value|
        next if current_condition_value.include?(current_value)

        current_match = true

        break
      end

      next if !current_match

      result = true

      break
    end
    result
  end
end
