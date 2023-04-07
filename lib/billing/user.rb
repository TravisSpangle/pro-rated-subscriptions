module Billing
  class User < Struct.new(:id, :name, :activated_on, :deactivated_on, :customer_id, keyword_init: true)
    def activated_on
      @activated_on ||= Date.strptime(super, '%m-%d-%Y')
    end

    def deactivated_on
      @deactivated_on ||= super.nil?? nil : Date.strptime(super, '%m-%d-%Y')
    end

    def billable_days(bill_date)
      case Availabilty.new(self, bill_date).type
      when :full
        days_in_month(bill_date)
      when :invalid
        0
      when :deactivated
        deactivated_on.day - 1
      when :activated
        1 + days_in_month(bill_date) - activated_on.day
      end
    end

    private

    # this could be moved into a date object
    def days_in_month(bill_date)
      (bill_date.next_month - 1).day
    end
  end
end
