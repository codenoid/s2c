require "qt5"
require "sass"

# Create the application first
qApp = Qt::Application.new

# We'll use a normal widget as window
window = Qt::Widget.new
window.window_title = "Sass to CSS Converter"

# We need to give it a layout
layout = Qt::VBoxLayout.new
window.layout = layout

# Create a label and a button, and push it into the layout
button = Qt::PushButton.new "CONVERT"
label = Qt::Label.new "Click the button!"
input = Qt::TextEdit.new

input.placeholder_text = "Put your SASS code here"

# input.read_only = true

layout << input << button

button.on_pressed do # This is how you connect to the `pressed` signal
  begin
    if !input.to_plain_text.empty?
      input.text = Sass.compile(input.to_plain_text)
    end
  rescue
    input.text = ""
    input.placeholder_text = "Failed to convert SASS Code..."
  end
end

# We're ready for showtime
window.show
window.resize(640, 230)

# And now, start it!
Qt::Application.exec
