class Chatroom < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :participants, dependent: :destroy

  def self.create_private_room(users, room_name)
    single_chatroom = Chatroom.create(name: room_name)
    users.each do |user|
      Participant.create(user_id: user.id, chatroom_id: single_chatroom.id )
    end
    single_chatroom
  end
end
