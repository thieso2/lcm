# == Schema Information
#
# Table name: import_steps
#
#  id          :integer          not null, primary key
#  import_id   :integer
#  description :string
#  totalrows   :integer
#  validrows   :integer
#  errorrows   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
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
      if scope_state.to_sym == :all
        import_row.unscoped
      else
        import_row.by_state(scope_state)
      end
    else
      import_row
    end
  end

  def <<(row)
    super
    totalrows = totalrows.to_i + 1
    if row[:message].blank?
      validrows = validrows.to_i +1
    else
      errorrows = errorrows.to_i +1
    end

  end
end
