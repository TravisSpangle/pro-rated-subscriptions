module Billing
  class Availabilty
    attr_reader :activated_on

    def initialize(user)
      @activated_on   = user.activated_on
      @deactivated_on = user.deactivated_on
    end

    def type
      case
      when deactivated_on_billing?
        :deactivated
      when activated_on_billing?
        :activated
      when billing_out_of_bounds?
        :invalid
      else
        :full
      end
    end

    private

    def deactivated_on
      # Just for the purpose of this calculation so it's private
      if @deactivated_on
        @deactivated_on
      elsif activated_on <= Billing.bill_date
        Billing.bill_date.next_month
      else
        activated_on.next_month
      end
    end

    def billing_out_of_bounds?
      !billing_in_bounds?
    end

    def billing_in_bounds?
      (activated_on..deactivated_on).cover?(Billing.bill_date)
    end

    def deactivated_on_billing?
      deactivated_on.year == Billing.bill_date.year &&
        deactivated_on.month == Billing.bill_date.month
    end

    def activated_on_billing?
      activated_on.year == Billing.bill_date.year &&
        activated_on.month == Billing.bill_date.month
    end
  end
end
