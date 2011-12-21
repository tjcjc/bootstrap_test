class Subject < ActiveRecord::Base
  acts_as_tree
  has_many :articles
  has_many :users
  BASE_CACHE_KEY = "base_subject_key"

  scope :basic_subjects, where(:parent_id => nil)

  def self.cache_base_subject
    a = Rails.cache.read BASE_CACHE_KEY
    return a if !a.blank?
    result = []
    Subject.basic_subjects.each do |base_subject|
      temp_out_array  = []
      temp_out_array << base_subject.name
      temp_out_array << []
      base_subject.children.each do |child|
        temp_inner_array = []
        temp_inner_array << child.name
        temp_inner_array << child.id
        temp_out_array.last << temp_inner_array
      end
      result << temp_out_array
    end
    Rails.cache.write BASE_CACHE_KEY, result
    return result
  end
end
