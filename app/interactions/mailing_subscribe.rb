class MailingSubscribe < ActiveInteraction::Base
  string :email
  string :name

  validates :email, presence: true
  validates :name, presence: true

  def execute
    access_token = ENV['STIBEE_KEY']
    return if access_token.blank?

    list_id = ENV.fetch('STIBEE_LIST_ID'){ 7834 }
    url = "https://api.stibee.com/v1/lists/#{list_id}/subscribers"
    response = HTTParty.post(url,
      {
        headers: {
          'AccessToken' => access_token
        },
        body: {
          eventOccuredBy: 'SUBSCRIBER',
          confirmEmailYN: 'Y',
          subscribers: [
            {
              email: email,
              name: name
            }
          ]
        }.to_json
      })
    if response.code != 200
      errors.add(:base, :unknown)
      return
    end

    parsed_response = JSON.parse(response.body)
    error = parsed_response['Error']

    if parsed_response['Ok']
      value = parsed_response['Value']
      errors.add(:base, :unknown) and return if value.blank?

      unless value['success']&.any?
        if value['failExistEmail']&.any?
          errors.add(:base, :server, message: '이미 구독 신청된 이메일입니다.')
        elsif value['failWrongEmail']&.any?
          errors.add(:base, :server, message: '잘못된 형식의 이메일입니다.')
        else
          errors.add(:base, :unknown)
        end
      end
    else
      if error.present? && error['message'].present?
        errors.add(:base, :server, message: error['message'])
      else
        errors.add(:base, :unknown)
      end
    end
  end
end
