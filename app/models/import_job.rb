# == Schema Information
#
# Table name: import_jobs
#
#  id                :integer          not null, primary key
#  original_filename :string
#  temp_filename     :string
#  starttime         :datetime
#  finishtime        :datetime
#  user_id           :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class ImportJob < ActiveRecord::Base
  belongs_to  :user
  has_many    :import_step, dependent: :destroy

  before_save do
    @current_step.save! if @current_step
  end

  def initialize(options={})
    super options
    self.starttime = DateTime.now
    @current_step = nil
  end

  def finish
    self.finishtime =  DateTime.now
    save!
    FileUtils.remove(self.temp_filename)
  end

  def to_s
    "##{id} from: #{original_filename} starttime: #{starttime} finishtime: #{finishtime} "
  end

  def temp_filename=(filename)
    FileUtils.mv(filename, "/tmp/import-#{filename.hash}.xlsx" )
    super "/tmp/import-#{filename.hash}.xlsx"
  end

  def log(what, infos={})
    case what
    when :step
      log_step(infos)
    when :row
      log_row(infos)
    when :error
      log_error(infos)
    else
      raise ArgumentError, "Unknown Import-LogType: #{what}"
    end
  end

  def log_step(infos)
    @current_step.save! if @current_step

    import_step << @current_step = ImportStep.new(infos)
    # self.import_step  << @current_step
    @current_step
  end

  def <<(step)
    import_step << step
  end

  def log_row(infos)
    @current_step << @current_row = ImportRow.new(infos)
    @current_row
  end

  def log_error(infos)
    @current_step.errortext ||= ""
    @current_step.errortext << infos.to_s
  end

end
