require_relative "student/student_model.rb"
require_relative "student/student_short.rb"
require_relative "student/BST.rb"
require_relative 'student/file_strategy/file_json.rb'
require_relative 'student/file_strategy/file_yaml.rb'
require_relative "student/student_list/student_list.rb"
require 'fox16'

include Fox

class StudentApp < FXMainWindow
  def initialize(app)
    super(app, "Student Management", width: 800, height: 600)

    tab_book = FXTabBook.new(self, opts: LAYOUT_FILL)

    tab1 = FXTabItem.new(tab_book, "Students")
    tab_frame1 = FXVerticalFrame.new(tab_book, opts: LAYOUT_FILL)

    FXTabItem.new(tab_book, "Tab 2")
    FXVerticalFrame.new(tab_book, opts: LAYOUT_FILL)

    FXTabItem.new(tab_book, "Tab 3")
    FXVerticalFrame.new(tab_book, opts: LAYOUT_FILL)

    create_tab1_content(tab_frame1)
  end

  def create_tab1_content(parent)
    filter_frame = FXHorizontalFrame.new(parent, opts: LAYOUT_FILL_X)
    FXLabel.new(filter_frame, "Фильтр по фамилии:")
    FXTextField.new(filter_frame, 20)

    table_frame = FXVerticalFrame.new(parent, opts: LAYOUT_FILL)
    table = FXTable.new(table_frame, opts: LAYOUT_FILL)
    table.setTableSize(20, 5)
    table.editable = false
    table.setColumnText(0, "ID")
    table.setColumnText(1, "Фамилия")
    table.setColumnText(2, "Имя")
    table.setColumnText(3, "Гит")
    table.setColumnText(4, "Телефон")
    fill_table(table)

    button_frame = FXHorizontalFrame.new(parent, opts: LAYOUT_FILL_X)
    FXButton.new(button_frame, "Добавить")
    FXButton.new(button_frame, "Изменить")
    FXButton.new(button_frame, "Удалить")
    FXButton.new(button_frame, "Обновить")
  end

  def fill_table(table)
    20.times do |row|
      table.setItemText(row, 0, (row + 1).to_s)
      table.setItemText(row, 1, "Иванов #{row}")
      table.setItemText(row, 2, "Иван")
      table.setItemText(row, 3, "Да")
      table.setItemText(row, 4, "+7 (123) 456-78-90")
    end
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end
end

if __FILE__ == $0
  app = FXApp.new
  StudentApp.new(app)
  app.create
  app.run
end
