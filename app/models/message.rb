class Message < ActiveRecord::Base
  belongs_to :ad
  belongs_to :user
  has_many   :replies

  after_update :send_mail

  validates_presence_of :text

  scope :approved, -> { where(is_approved: true) }

  private
  def send_mail
    if is_approved_changed? && is_approved
      # send email here
      UserMailer.new_message_email(self).deliver_later
    end
  end
end
