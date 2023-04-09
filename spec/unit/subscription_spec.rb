RSpec.describe Billing::Subscription do
  let(:sub) { Billing::Subscription.new({ id: 763, customer_id: 328, monthly_price_in_cents: 600 })}

  it "calculates the daily rate" do
    bill_date(2023, 4)
    result = sub.daily_amount

    expect(result).to eq(20)
  end
end
