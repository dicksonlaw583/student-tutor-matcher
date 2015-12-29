require 'spec_helper'

describe "messages/new" do
  before(:each) do
    @sender = FactoryGirl.create(:tutor)
    sign_in @sender
    assign(:message, stub_model(Message,
      :subject => "Test Subject",
      :body => "This is a test message."
    ).as_new_record)
  end

  it "renders new message form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => messages_path, :method => "post" do
      assert_select "input#recipient", :name => "recipient"
      assert_select "input#message_subject", :name => "message[subject]"
      assert_select "textarea#message_body", :name => "message[body]"
    end
  end
end
