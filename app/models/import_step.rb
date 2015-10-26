# == Schema Information
#
# Table name: import_steps
#
#  id            :integer          not null, primary key
#  import_job_id :integer
#  description   :string
#  totalrows     :integer
#  validrows     :integer
#  errorrows     :integer
#  errortext     :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class ImportStep < ActiveRecord::Base
  belongs_to  :import_job
  has_many    :import_row, dependent: :delete_all

  def to_s
    s = "Step: #{description}"
    s << " TotalRows: #{totalrows}" if totalrows
    s << " Valid: #{validrows}"     if validrows
    s << " Error: #{errorrows}"     if errorrows
    s << " Errors: #{errortext}"    if errortext
    s
  end

  def import_rows(scope_step, scope_state)
    if scope_step.to_i == self.id
      x = import_row.by_state(scope_state)
    else
      x = import_row.by_state(:invalid)
    end
    x
  end

  def <<(row)
    self.totalrows = self.totalrows.to_i + 1
    if row.has_error?
      import_row << row
      self.errorrows = self.errorrows.to_i + 1
    else
      import_row << row   # really log all valid rows??
      self.validrows = self.validrows.to_i + 1
    end
  end

end
