require 'v2/models/child_queries'

module V2
  class Workflow < ActiveRecord::Base
    include UUIDSupport

    uuid_column :uuid

    belongs_to :user
    has_many :nodes
    serialize :subject, JSON

    validates :subject, presence: true
    validates :decider, presence: true
    validates :user_id, presence: true

    include ChildQueries

    def parent
      nil
    end

    def children
      nodes.where(parent_id: nil)
    end

    def workflow_id
      id
    end

    def deactivated?
      false
    end

    def complete!
      update_attributes(complete: true)
    end
  end
end