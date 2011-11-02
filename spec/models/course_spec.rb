require 'spec_helper'

describe Course do
  it { should have_many(:teachers).through(:assignations) }
  it { should have_many(:course_assets) }
  it { should belong_to :network }

  it { should validate_presence_of :network }
  it { should validate_presence_of :name }
  it { should validate_presence_of :description }
  it { should validate_presence_of :start_date }
  it { should validate_presence_of :finish_date }

  describe 'assignation and teachers' do
    let(:teacher) { Factory(:teacher) }

    it 'should build and save asignation' do
      course = Factory.build(:course)
      course.assignations.build(:user => teacher, :admin => true)
      lambda { course.save }.should change(Assignation, :count).by(1)
    end
  end

  describe 'html description sanitization' do
    let(:course) { Factory(:course, :description => '<script>pure evil</script>')}
    it { course.description.should_not =~ /<script>/ }
    it { course.description.should be_html_safe }
  end
end
