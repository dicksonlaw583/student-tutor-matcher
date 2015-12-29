require 'spec_helper'

describe "courses/new" do
  before(:each) do
    assign(:course, stub_model(Course,
      :course_code => "MyString",
      :name => "MyString",
      :description => "MyString"
    ).as_new_record)
  end

  it "renders new course form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => courses_path, :method => "post" do
      assert_select "input#course_course_code", :name => "course[course_code]"
      assert_select "input#course_name", :name => "course[name]"
      assert_select "textarea#course_description", :name => "course[description]"
    end
  end
end
