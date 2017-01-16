require "rails_helper"

RSpec.describe NoticeMailer, type: :mailer do
  describe "sendmail" do
    let(:mail) { NoticeMailer.sendmail }

    it "renders the headers" do
      expect(mail.subject).to eq("Sendmail")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
