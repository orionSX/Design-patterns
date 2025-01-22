require 'fox16'
require_relative 'App.rb'

include Fox

app = FXApp.new("Students", "Students")
App.new(app)
app.create
app.run