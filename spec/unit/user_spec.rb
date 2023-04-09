RSpec.describe Billing::User do
  let(:attr) do
    {
      id: 1,
      name: "Employee #1",
      activated_on: '04-03-2022',
      deactivated_on: '04-03-2023',
      customer_id: 1,
    }
  end

  context "Billiable Dates" do
    it "tallys all days in a month when valid" do
      bill_date(2022, 6)
      user = Billing::User.new(attr)
      result = user.billable_days

      expect(result).to eq 30
    end

    context "pro rates" do
      specify "when activated in billing month" do
        bill_date(2022, 4)
        user = Billing::User.new(attr)
        result = user.billable_days

        expect(result).to eq 28
      end

      specify "when deactivated in billing month" do
        bill_date(2023, 4)
        user = Billing::User.new(attr)
        result = user.billable_days

        expect(result).to eq 2
      end
    end

    it "returns 0 if billing month of user is deactivated" do
      bill_date(2024, 4)
      user = Billing::User.new(attr)
      result = user.billable_days

      expect(result).to eq 0
    end
  end
end
