class Message < ApplicationRecord
  # before_create :confirm_participant

  belongs_to :chatroom
  belongs_to :user

  # def confirm_participant
  #   is_participant = Participant.where(user_id: self.user.id, chatroom_id: self.chatroom.id).first
  #   throw :abort unless is_participant
  # end
end
