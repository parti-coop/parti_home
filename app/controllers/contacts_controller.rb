class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    if Contact.save(contact_params)
    else
      render 'new'
    end
  end

  private 

  def contact_params
    params.require(:contact).permit(:project_subject, :project_category, :project_body, :attachment, :contact_org, :contact_manager, :contact_tel, :contact_email)
  end
end