module Billing
  class Subscription < Struct.new(:id, :customer_id, :monthly_price_in_cents, keyword_init: true)
    def daily_amount
      monthly_price_in_cents / Billing.days_in_month
    end
  end
end
