class PartiMarkdownRender < Redcarpet::Render::HTML
  def image(link, title, alt_text)
    %(<figure><img src="#{link}" title="#{title}"><figcaption>#{alt_text}</figcaption></figure>)
  end
end