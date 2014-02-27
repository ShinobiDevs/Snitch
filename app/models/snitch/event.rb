class Snitch::Event
  module Exceptions
    class NotImplemented < StandardError; end
  end

  attr_reader :report_to, :object, :subject, :action, :meta

  def initialize(report_to, object, subject, action, meta = {})
    @report_to = report_to
    @object = object
    @subject = subject
    @action = action
    @meta = meta
  end

  def should_report?
    raise Snitch::Event::Exceptions::NotImplemented
  end

  def report!
    if should_report?
      Snitch::ReportWorker.perform_async(report_to.id.to_s, report_to.class.name, attributes_for_report)
    end
  end

  def attributes_for_report
    {
      subject_id: self.subject.id.to_s,
      subject_type: self.subject.class.name,
      object_id: self.object.id.to_s,
      object_type: self.object.class.name,
      action: self.action,
      meta: self.meta
    }
  end
end