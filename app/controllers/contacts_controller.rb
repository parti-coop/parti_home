class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      flash[:success] = '협업 요청해 주셔서 감사합니다. 검토 후 빠른 시일 내로 연락드리겠습니다.'
      redirect_to root_url
    else
      errors_to_flash(@contact)
      render 'new'
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:project_subject, :solution_slug, :project_body, :attachment, :contact_org, :contact_manager, :contact_tel, :contact_email)
  end
end