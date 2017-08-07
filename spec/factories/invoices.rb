FactoryGirl.define do
  factory :invoice do
    invoice_number "MyString"
    invoice_date "2017-07-29"
    billing_name "MyString"
    billing_address "MyText"
    billing_state "MyString"
    billing_state_code 1
    billing_gstid "MyString"
    description "MyText"
    quantity 1
    rate 1.5
    purchase_order_no "MyString"
  end
end
