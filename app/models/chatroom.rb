class Chatroom < ApplicationRecord
  has_many :messages
  has_many :participants, dependent: :destroy

  def self.create_private_room(users, room_name)
    single_room = Chatroom.create(name: room_name)
    users.each do |user|
      Participant.create(user_id: user.id, chatroom_id: single_room.id )
    end
    single_room
  end
end
