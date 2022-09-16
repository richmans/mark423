module RenderHelper
  def js_escape(text)
    text.gsub("\n", "\\n").gsub("\r",'')
  end
end
