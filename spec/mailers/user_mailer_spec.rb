#encoding: utf-8

require "spec_helper"

describe UserMailer do

  describe "new_comment_on_user" do
    comment = Factory(:comment_on_user)
    let(:mail) { UserMailer.new_comment_on_user(comment.commentable, comment.user, "tec") }

    it "renders the headers" do
      mail.subject.should eq("Nuevo comentario en tu muro")
      mail.to.should eq([comment.commentable.email])
      mail.from.should eq(["noreply@cursa.me"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hola #{/[a-zA-Z]+/x}")
      mail.body.encoded.should match("ha publicado un nuevo comentario en tu muro!")
    end
  end
  
  describe "new_comment_on_discussion" do
    comment = Factory(:comment_on_discussion)
    discussion = comment.commentable
    let(:mail) { UserMailer.new_comment_on_discussion(discussion, comment.user, "tec") }

    it "renders the headers" do
      mail.subject.should eq("Nuevo comentario en una de tus discusiones")
      mail.bcc.should eq([discussion.starter.email, comment.user.email])
      mail.from.should eq(["noreply@cursa.me"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hola!")
      mail.body.encoded.should match("El usuario #{comment.user.name} ha publicado un nuevo comentario en la discusión #{discussion.title}")
    end
  end


  describe "new_comment_on_course" do
    before do
      @comment = Factory(:comment_on_course)
      @course = @comment.commentable
      student = Factory(:student)
      @course.enrollments.create(:user => student, :role => 'student', :state => 'accepted')
      @course.reload
    end

    let(:mail) { UserMailer.new_comment_on_course(@course, @comment.user, "tec") }

    it "renders the headers" do
      mail.subject.should eq("Nuevo comentario en el muro de uno de tus cursos")
      mail.bcc.should eq([@course.all_emails])
      mail.from.should eq(["noreply@cursa.me"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hola!")
      mail.body.encoded.should match("El usuario #{@comment.user.name} ha publicado un nuevo comentario en el muro del curso #{@course.name}")
    end
  end
  
  describe "new_comment_on_comment" do
    before do
      @comment = Factory(:comment_on_comment)
    end

    let(:mail) { UserMailer.new_comment_on_comment(@comment.commentable, @comment, "tec") }

    it "renders the headers" do
      mail.subject.should eq("Nueva respuesta sobre tu comentario")
      mail.to.should eq([@comment.commentable.user.email])
      mail.from.should eq(["noreply@cursa.me"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hola #{@comment.commentable.user.name}!")
      mail.body.encoded.should match("El usuario #{@comment.user.name} ha publicado una respuesta a tu comentario.")
    end
  end

  describe "new_discussion" do
    before do
      @discussion = Factory(:discussion)
      @course = @discussion.course
      student = Factory(:student)
      @course.enrollments.create(:user => student, :role => 'student', :state => 'accepted')
    end

    let(:mail) { UserMailer.new_discussion(@discussion, "tec") }

    it "renders the headers" do
      mail.subject.should eq("Nueva discusión en uno de tus cursos")
      mail.bcc.should eq([(@course.all_emails||"")])
      mail.from.should eq(["noreply@cursa.me"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hola!")
      mail.body.encoded.should match("El usuario #{@discussion.starter.name} ha iniciado la discusión #{@discussion.title} en tu curso #{@discussion.course.name}")
    end
  end

end
