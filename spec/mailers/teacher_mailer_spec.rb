require "spec_helper"

describe TeacherMailer do

  before(:each) do
    @teacher = Factory(:teacher)
    @student = Factory(:student)
    @network = Factory(:network)
    @course = Factory(:course)
  end
  
  describe "pending_student_on_course" do
    let(:mail) { TeacherMailer.pending_student_on_course(User.where(:role => 'teacher'), @student, @course, @network) }

    it "renders the headers" do
      mail.subject.should eq("Un alumno ha solicitado acceso a uno de tus cursos")
      mail.to.should eq([@teacher.email])
      mail.from.should eq(["noreply@cursa.me"])
    end

    it "renders the body" do
      mail.body.encoded.should match("El alumno #{@student.name} ha solicitado ingresar a tu curso #{@course.name}, es necesario que lo apruebes para que tenga acceso a el.")
    end
  end

end
