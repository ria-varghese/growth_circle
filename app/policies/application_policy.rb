# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

    def initialize(user, record)
      @user = user
      @record = record
    end

    def show?
      user.admin?
    end

    def destroy?
      user.admin?
    end

    def history?
      user.admin?
    end

    def show_in_app?
      false
    end

    def dashboard?
      user.admin?
    end

    def index?
      user.admin?
    end

    def new?
      user.admin?
    end
    alias create? new?

    def edit?
      user.admin?
    end
    alias update? edit?

    def export?
      user.admin?
    end

    def rails_admin_index?
      true
    end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end

    private

    attr_reader :user, :scope
  end
end
