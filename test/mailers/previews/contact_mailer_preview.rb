# URL PATH : /rails/mailers/contact_mailer/new?contact_id=1
class ContactMailerPreview < ActionMailer::Preview
  def new
    contact =  Contact.find_by(id: params[:contact_id])
    raise "Not found contact for #{parmas.insepct}" if contact.blank?

    ContactMailer.with(contact: contact).new_contact
  end
end
