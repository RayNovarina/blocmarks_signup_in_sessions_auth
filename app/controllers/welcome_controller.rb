# About this controller:
class WelcomeController < ApplicationController
  # before_action: whatever method you put here will be performed before the
  # specifed actions. before_actions are executed in the list order.

  # A frequent practice is to place the standard CRUD actions in each controller
  # in the following order: index, show, new, edit, create, update and destroy.
  def index
  end
end
