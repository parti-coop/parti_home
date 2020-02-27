class MailingSubscribe < ActiveInteraction::Base
  string :email
  string :name

  validates :email, presence: true
  validates :name, presence: true

  def execute
    access_token = ENV['STIBEE_KEY']
    response = HTTParty.post("https://api.stibee.com/v1/lists/7834/subscribers", {
      headers: {
        "AccessToken" => access_token
      },
      body: {
        "eventOccuredBy": "SUBSCRIBER",
        "confirmEmailYN": "Y",
        "subscribers": [
          {
            "email": email,
            "name": name
          }
        ]
      }.to_json
    })
    if response.code != 200
      errors.add(:base, :unknown)
      return
    end

    parsed_response = JSON.parse(response.body)
    error = parsed_response["Error"]

    if parsed_response["Ok"] != true || error.present?
      if error.present? && error["message"].present?
        errors.add(:base, :server, message: error["message"])
      else
        errors.add(:base, :unknown)
      end
    end
  end
end
