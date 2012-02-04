require "spec_helper"

describe SupervisorMailer do
  
  before(:each) do
    @network = Factory(:network)
    @teacher = Factory(:teacher, :networks => [@network])
    @supervisor = Factory(:supervisor, :networks => [@network])
  end

  describe "new_teacher_registered" do
    let(:mail) { SupervisorMailer.new_teacher_registered(@teacher, @network) }

    it "renders the headers" do
      mail.subject.should eq("Un maestro ha solicitado acceso a tu red")
      mail.to.should eq([@supervisor.email])
      mail.from.should eq(["noreply@cursa.me"])
    end

    it "renders the body" do
      mail.body.encoded.should match("El maestro #{@teacher.name} ha solicitado ingresar a la red #{@network.name}")
    end
  end

end
