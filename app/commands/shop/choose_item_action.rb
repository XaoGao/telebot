# frozen_string_literal: true

class ChooseItemAction < CommandBase
  try :pass

  private

  def pass
    user.close_command
    user.save
  end
end
