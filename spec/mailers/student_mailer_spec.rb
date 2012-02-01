require "spec_helper"

describe StudentMailer do
  before(:each) do
    @teacher = Factory(:teacher)
    @student = Factory(:student)
    @network = Factory(:network)
    @course = Factory(:course)
  end

  describe "accepted_on_course" do
    let(:mail) { StudentMailer.accepted_on_course(@teacher, @student, @course, @network) }

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
    let(:mail) { StudentMailer.new_homework(User.where("role = 'student'"), @course, @network) }

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
    let(:mail) { StudentMailer.new_survey }

    it "renders the headers" do
      mail.subject.should eq("New survey")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["noreply@cursa.me"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Tu profesor del curso #{course.name} ha publicado una nueva tarea!")
    end
  end

end
