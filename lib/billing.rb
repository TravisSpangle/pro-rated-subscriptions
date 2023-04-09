require 'date'
require 'billing/user'
require 'billing/availabilty'
require 'billing/subscription'

module Billing
  module_function

  def amount(month, subscription, users)
    return 0 if subscription.nil?

    subscription = Subscription.new(subscription)
    @bill_date   = Date.strptime(month, '%Y-%m')
    users        = users.map { |user| User.new(user) }

    active_days(users) * subscription.daily_amount
  end

  def active_days(users)
    users.reduce(0) do |result, user|
      result + user.billable_days
    end
  end

  def bill_date
    @bill_date
  end

  def days_in_month
    (bill_date.next_month - 1).day
  end
end
