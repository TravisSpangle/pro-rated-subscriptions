module Billing
  class User < Struct.new(:id, :name, :activated_on, :deactivated_on, :customer_id, keyword_init: true)
    def activated_on
      @activated_on ||= Date.strptime(super, '%m-%d-%Y')
    end

    def deactivated_on
      @deactivated_on ||= super.nil?? nil : Date.strptime(super, '%m-%d-%Y')
    end

    def billable_days
      case Availabilty.new(self).type
      when :full
        Billing.days_in_month
      when :invalid
        0
      when :deactivated
        deactivated_on.day - 1
      when :activated
        1 + Billing.days_in_month - activated_on.day
      end
    end
  end
end
