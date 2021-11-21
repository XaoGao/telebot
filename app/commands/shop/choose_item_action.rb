# frozen_string_literal: true

class ChooseItemAction < Command
  try :pass

  private

  def pass
    user.clear
    user.save
  end
end
