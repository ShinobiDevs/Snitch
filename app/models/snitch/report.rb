class Snitch::Report
  include Mongoid::Document
  include Mongoid::Timestamps

  attr_accessor :reported_to

  field :subject_id,          type: BSON::ObjectId
  field :subject_type,        type: String
  field :object_id,           type: BSON::ObjectId
  field :object_type,         type: String
  field :action,              type: String
  field :meta,                type: Hash, default: {}

  validates :subject, :object, :action, presence: true

  def collection_name
    "snitch_reports_#{self.reported_to.name.parameterize.underscore}_#{self.reported_to.id}"
  end

  def subject
    @subject ||= self.subject_type.constantize.where(id: self.subject_id).first
  end

  def object
    @object ||= self.object_type.constantize.where(id: self.object_id).first
  end

  def subject=(new_subject)
    self.subject_id = new_subject.id
    self.subject_type = new_subject.class.name
    true
  end

  def object=(new_object)
    self.object_id = new_object.id
    self.object_type = new_object.class.name
    true
  end
end