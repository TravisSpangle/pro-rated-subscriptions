RSpec.describe Billing::Availabilty do
  let(:user) do
    Billing::User.new({
      id: 1,
      name: "Employee #1",
      activated_on: '04-03-2022',
      deactivated_on: '04-03-2023',
      customer_id: 1,
    })
  end

  specify "when billing date is out of bounds" do
    result = Billing::Availabilty.new(user, Date.new(2021, 1)).type

    expect(result).to eq :invalid
  end

  specify "prorated due to deactivated during billing date" do
    result = Billing::Availabilty.new(user, Date.new(2023, 4)).type

    expect(result).to eq :deactivated
  end

  specify "prorated due to activated during billing date" do
    result = Billing::Availabilty.new(user, Date.new(2022, 4)).type

    expect(result).to eq :activated
  end

  specify "billing the full month" do
    result = Billing::Availabilty.new(user, Date.new(2022, 5)).type

    expect(result).to eq :full
  end
end
