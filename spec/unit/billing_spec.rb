RSpec.describe Billing do
  let(:month) {"2022-5"}
  let(:subscription) { { id: 1, customer_id: 1, monthly_price_in_cents: 600, } }
  let(:users) do
    (1..2).map do |employee_num|
      {
        id: employee_num,
        name: "Employee ##{employee_num}",
        activated_on: "04-01-2022",
        deactivated_on: nil,
        customer_id: 1,
      }
    end
  end

  context "returns $0.00" do
    specify "when no active users" do
      no_active_users = users.each do |user|
        user[:activated_on]   = "01-01-1999"
        user[:deactivated_on] = "01-01-2000"
      end
      result = Billing.amount(month, subscription, no_active_users)
      expect(result).to be_zero
    end

    specify "when subscription is nil" do
      result = Billing.amount(month, nil, users)
      expect(result).to be_zero
    end
  end

  context "calculates the total amount" do
    specify "for two acitve users" do
      result = Billing.amount(month, subscription, users)
      expect(result).to eq 1178
    end

    specify "for two active users and one inactive user" do
      new_users = users.append({
          id: 3,
          name: "Employee #3",
          activated_on: "01-01-1999",
          deactivated_on: "01-01-2000",
          customer_id: 1,
        })
      result = Billing.amount(month, subscription, new_users)
      expect(result).to eq 1178
    end

    specify "for an active usesr and pro rated user" do
      user = users.last
      user[:activated_on]   = "01-01-1999"
      user[:deactivated_on] = "01-01-2000"

      result = Billing.amount(month, subscription, users)
      expect(result).to eq 589
    end
  end
end
