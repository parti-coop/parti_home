require 'slack-notifier'

class ContactsController < ApplicationController
  def new
    @contact = Contact.new

    prepare_meta_tags(title: '협업 문의', description: '활동 영역 별 다양한 방식으로 여러분과 협업합니다.', url: new_contact_url)
  end

  def create
    @contact = Contact.new(contact_params)

    if !NewGoogleRecaptcha.human?(
      params[:new_google_recaptcha_token],
      "checkout",
      NewGoogleRecaptcha.minimum_score,
      @contact
    ) || !@contact.save
      errors_to_flash(@contact)
      render 'new' and return
    end

    append_flash_message(:success, '협업 요청해 주셔서 감사합니다. 검토 후 빠른 시일 내로 연락드리겠습니다.')
    redirect_to root_url

    if @contact.confirm_mailing?
      outcome = MailingSubscribe.run(name: @contact.contact_manager, email: @contact.contact_email)
      if outcome.valid?
        append_flash_message(:success, '민주주의 리포트 구독 확인 이메일을 발송했습니다. 보내드린 이메일을 확인하면 구독이 완료됩니다.')
      else
        messages = outcome.errors.full_messages.join('. ')
        logger.error messages
        if outcome.errors.added?(:base, :server)
          flash[:error] = messages
        else
          flash[:error] = '민주주의 리포트 구독이 실패했습니다. contact@parti.coop로 구독 신청 메일을 보내 주세요.'
        end
      end
    end

    begin
      notifier = Slack::Notifier.new ENV["SLACK_DOCKING"]
      notifier.post username: '휴스턴 관제센터',
        attachments:
          [
            {
              color: "good",
              text: "[도킹 요청] #{@contact.solution_slugs.join(', ')}",
              fields:
                %i(project_subject project_body project_why
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

    begin
      ContactMailer.with(contact: @contact).new_contact.deliver_later
    rescue
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:project_subject, :project_body, :project_why, :attachment, :contact_org, :contact_manager, :contact_tel, :contact_email, :confirm_privacy, :confirm_marketing, :confirm_mailing, solution_slugs: [])
  end

  def append_flash_message(type, msg)
    flash[type] ||= []
    flash[type] << msg
  end
end