require 'slack-notifier'

class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)

    unless @contact.save
      errors_to_flash(@contact)
      render 'new'
    end

    flash[:success] = '협업 요청해 주셔서 감사합니다. 검토 후 빠른 시일 내로 연락드리겠습니다.'
    redirect_to root_url

    begin
      notifier = Slack::Notifier.new ENV["SLACK_DOCKING"]
      notifier.post username: '휴스턴 관제센터',
        attachments:
          [
            {
              color: "good",
              text: "[도킹 요청] #{@contact.solution_slug}",
              fields:
                %i(project_subject project_body
                attachment_name attachment_url
                contact_org contact_manager
                contact_tel contact_email).map do |attr|
                  {
                    "title": Contact.human_attribute_name(attr),
                    "value": @contact.send(attr),
                    "short": false
                  }
                end
            }
          ]
    rescue
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:project_subject, :solution_slug, :project_body, :attachment, :contact_org, :contact_manager, :contact_tel, :contact_email)
  end
end