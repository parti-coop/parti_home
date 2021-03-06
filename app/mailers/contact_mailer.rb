class ContactMailer < ApplicationMailer
  def new_contact
    @contact = params[:contact]
    mail(to: 'all@parti.coop', subject: "[도킹 요청][#{@contact.contact_org.presence || @contact.contact_manager.presence}] #{@contact.project_subject}")
  end
end
