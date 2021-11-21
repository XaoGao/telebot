# frozen_string_literal: true

class ChooseItemAction < Command
  try :pass

  private

  def pass
    user.close_command
    user.save
  end
end
