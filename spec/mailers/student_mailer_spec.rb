require "spec_helper"

describe StudentMailer do
  before(:each) do
    @teacher = Factory(:teacher)
    @student = Factory(:student)
    @network = Factory(:network)
    @course = Factory(:course)
    Enrollment.create(:course => @course, :user => @student, :admin => false, :role => 'student', :state => 'accepted')
  end

  describe "accepted_on_course" do
    let(:mail) { StudentMailer.accepted_on_course(@student, @course, @network) }

    it "renders the headers" do
      mail.subject.should eq("Solicitud de ingreso al curso #{@course.name} aceptada")
      mail.to.should eq([@student.email])
      mail.from.should eq(["noreply@cursa.me"])
    end

    it "renders the body" do
      mail.body.encoded.should match("ha aprobado tu ingreso al curso")
    end
  end

  describe "new_homework" do
    let(:mail) { StudentMailer.new_homework(@course.student_emails, @course, @network) }

    it "renders the headers" do
      mail.subject.should eq("Nueva tarea en uno de tus cursos")
      mail.to.should eq([@student.email])
      mail.from.should eq(["noreply@cursa.me"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Tu profesor del curso #{@course.name} ha publicado una nueva tarea!")
    end
  end

  describe "new_survey" do
    survey = Factory(:published_survey)
    let(:mail) { StudentMailer.new_survey(@course.student_emails, @course, survey, @network) }

    it "renders the headers" do
      mail.subject.should eq("Nuevo cuestionario en uno de tus cursos")
      mail.to.should eq([@student.email])
      mail.from.should eq(["noreply@cursa.me"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Tu profesor del curso #{@course.name} ha publicado el cuestionario #{survey.name}!")
    end
  end

end
