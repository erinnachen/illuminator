module ApplicationHelper
  def personal_page?(github_user)
    current_user.nickname == github_user.username
  end

  def starred_tab?
    params[:tab] == "starred" || request.fullpath.include?("/starred")
  end
end
