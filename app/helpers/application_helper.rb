module ApplicationHelper
  def description
    desc = content_for?(:description) ? content_for(:description) : I18n.t('gaslight.description')
    truncate(HTMLEntities.new.decode(desc), length: 155)
  end

  def active_page_class(path)
    "active" if current_page?(path)
  end

  def viewing_blog?
    request.fullpath =~ /blog/
  end

  def viewing_training?
    request.fullpath =~ /training/
  end

  def viewing_work?
    request.fullpath =~ /work/
  end

  def player_iframe(source)
    %Q{<iframe src="#{source}" frameborder="0" allowtransparency="true" scrolling="no" width="500" height="30"></iframe>}
  end

  def gravatar_url(email, size = "32x32")
    return "" if email.nil?
    hash = Digest::MD5.hexdigest(email)
    "//www.gravatar.com/avatar/#{hash}?s=#{size}"
  end
end
