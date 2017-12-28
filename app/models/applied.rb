class Applied < ApplicationRecord

	has_attached_file :resume

  validates_attachment :resume, size: { in: 0..5.megabytes },
  															presence: true
  do_not_validate_attachment_file_type :resume
end
