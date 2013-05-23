class Event < ActiveRecord::Base

  belongs_to :conference
  has_many :recordings,  dependent: :destroy

  validates_presence_of :conference
end