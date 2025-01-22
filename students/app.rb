require 'fox16'
require_relative './view/student_view.rb'
require_relative './controllers/student_list_controller.rb'

include Fox

class App < FXMainWindow
    def initialize(app)
        super(app, "Students", width: 1024, height: 768)

        tabs = FXTabBook.new(self, opts: LAYOUT_FILL)

        FXTabItem.new(tabs, "Список студентов")
        student_list = FXVerticalFrame.new(tabs, opts: LAYOUT_FILL)
        student_list_view = StudentListView.new(student_list)
        student_list_view.refresh_data
    end

    def create
        super
        show(PLACEMENT_SCREEN)
    end

end