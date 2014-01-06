class CodemarkMarkdownRenderer < Redcarpet::Render::HTML
  def normal_text(text)
    matches = text.scan(/\[CM(\d+[ \w]*)\]/)

    matches.each do |match|
      id, title = match.first.match(/(\d+)[ ]*([ \w]*)/).captures
      return unless cm = Codemark.find_by_id(id)

      title = cm.title if title.blank?
      if cm.resource.is_a?(Link)
        link = cm.resource.url
        cm_link = "<a href='#{link}' class='embedded_cm' target='_blank'>#{title}</a>"
      else
        link = "/codemarks/#{cm.id}"
        cm_link = "<a href='#{link}' class='embedded_cm'>#{title}</a>"
      end

      text = text.gsub(/\[CM#{match.first}\]/, cm_link)
    end
    text
  end
end
