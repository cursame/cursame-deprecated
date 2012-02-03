#encoding: utf-8

require "spec_helper"

describe UserMailer do

  before(:each) do
    @student = Factory(:student)
    @teacher = Factory(:teacher)
    @supervisor = Factory(:supervisor)
  end
  
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
      mail.body.encoded.should match("Visita tu #{/.+/x} para ver el comentario.")
    end
  end

  describe "new_discussion" do
    let(:mail) { UserMailer.new_discussion }

    it "renders the headers" do
      mail.subject.should eq("New discussion")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

  describe "new_comment_on_discussion" do
    let(:mail) { UserMailer.new_comment_on_discussion }

    it "renders the headers" do
      mail.subject.should eq("New comment on discussion")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

  describe "new_comment_on_course" do
    let(:mail) { UserMailer.new_comment_on_course }

    it "renders the headers" do
      mail.subject.should eq("New comment on course wall")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
