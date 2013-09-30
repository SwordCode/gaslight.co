module TrainingApp
  class Chapter < ActiveRecord::Base
    belongs_to :section
    validates :section, presence: true
    default_scope { order('sort_order') }
  end
end