class Snitch::ReportWorker
  include Sidekiq::Worker

  sidekiq_options queue: 'snitch_reports', retry: false, backtrace: true

  def perform(report_to_id, report_to_class, report_attributes = {})
    report_to = report_to_class.constantize.where(id: report_to_id).first
    if report_to
      puts report_attributes.merge({reported_to: report_to}).inspect
      report = Snitch::Report.new(report_attributes.merge({reported_to: report_to}))
      report.save!
    end
  end
end