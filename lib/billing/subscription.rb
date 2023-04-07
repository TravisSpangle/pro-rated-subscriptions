module Billing
  class Subscription < Struct.new(:id, :customer_id, :monthly_price_in_cents, keyword_init: true)
    def daily_amount(bill_date)
      monthly_price_in_cents / days_in_month(bill_date)
    end

    # this could be moved into a date object
    def days_in_month(bill_date)
      (bill_date.next_month - 1).day
    end
  end
end
