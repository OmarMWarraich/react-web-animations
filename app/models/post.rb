class Post < ApplicationRecord
    validates :title, presence: true, length: { minimum: 5, maximum: 50}
    validates :body, presence: true, length: { minimum: 5, maximum: 1000}
    belongs_to :user
    has_many :comments, dependent: :destroy

    has_rich_text :body
    has_one :content, class_name: 'ActionText::RichText', as: :record, dependent: :destroy

    has_noticed_notifications model_name: 'Notification'
    has_many :notifications, through: :user, dependent: :destroy

    def self.ransackable_attributes(auth_object = nil)
        [ "id", "updated_at", "views", "title", "body", "content" ]
    end

    def self.ransackable_associations(auth_object = nil)
        ["comments", "notifications", "user"]
    end
end
