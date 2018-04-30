module ApplicationHelper
    def login?
    return true if @current_user
    current_user = session[:current_user]
    return false unless current_user
    @current_user = User.find_by_id current_user['id']
    unless @current_user
      session.delete(:current_user)
      return false
    end
    true
  end

  def is_admin?
    return true if @is_admin
    if @current_user
      user = @current_user
    else
      user = User.find_by_id session[:current_user]['id']
    end
    @is_admin = user.admin?
    @is_admin
  end

  def is_editor?
    return @is_editor if @is_editor
    if @current_user
      user = @current_user
    else
      user = User.find_by_id session[:current_user]['id']
    end
    @is_editor = user.editor?
    @is_editor
  end
end
