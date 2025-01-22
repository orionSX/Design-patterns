require 'fox16'
require_relative '../lists/data_list.rb'
require_relative '../lists/data_list_student_short.rb'
require_relative '../models/student_model.rb'

include Fox



class StudentListView < FXVerticalFrame

  attr_accessor :controller, :current_page_label

  ROWS_PER_PAGE = 5

  
  def initialize(parent)
    super(parent, opts: LAYOUT_FILL)
    self.controller = StudentListController.new(self)

    self.filters = {}

    setup_filtering_area
    setup_table_area
    setup_control_buttons_area
    self.current_page_label = 1
    self.total_pages = 1
    self.refresh_data
  end


  def setup_filtering_area
    filtering_area = FXVerticalFrame.new(self, opts: LAYOUT_FILL_X | LAYOUT_SIDE_TOP)
    FXLabel.new(filtering_area, "Фильтрация")

    name_text_field = nil
    FXHorizontalFrame.new(filtering_area, opts: LAYOUT_FILL_X) do |frame|
      FXLabel.new(frame, "Фамилия и инициалы:")
      name_text_field = FXTextField.new(frame, 20, opts: TEXTFIELD_NORMAL)
    end

    self.filters['name'] = { text_field: name_text_field }

    add_filtering_row(filtering_area, "Git:")
    add_filtering_row(filtering_area, "Email:")
    add_filtering_row(filtering_area, "Телефон:")
    add_filtering_row(filtering_area, "Telegram:")

    FXButton.new(filtering_area, "Сбросить", opts: BUTTON_NORMAL).connect(SEL_COMMAND) do
      reset_filters
    end


  end


  def add_filtering_row(parent, label)
    FXHorizontalFrame.new(parent, opts: LAYOUT_FILL_X) do |frame|
      FXLabel.new(frame, label)
      combo_box = FXComboBox.new(frame, 3, opts: COMBOBOX_STATIC | FRAME_SUNKEN)

      combo_box.numVisible = 3
      combo_box.appendItem("Не важно")
      combo_box.appendItem("Да")
      combo_box.appendItem("Нет")

      text_field = FXTextField.new(frame, 15, opts: TEXTFIELD_NORMAL)
      text_field.enabled = false

      self.filters[label] = { combo_box: combo_box, text_field: text_field }

      combo_box.connect(SEL_COMMAND) do
        text_field.enabled = (combo_box.currentItem == 1)
      end
    end
  end


  def setup_table_area

    table_area = FXVerticalFrame.new(self, opts: LAYOUT_FILL)
    self.table = FXTable.new(table_area, opts: LAYOUT_FILL | TABLE_READONLY | TABLE_COL_SIZABLE)
    self.table.setTableSize(ROWS_PER_PAGE, 6)
    self.table.rowHeaderMode = LAYOUT_FIX_WIDTH
    self.table.rowHeaderWidth = 80

    controls = FXHorizontalFrame.new(table_area, opts: LAYOUT_FILL_X)
    self.prev_button = FXButton.new(controls, "<<<", opts: BUTTON_NORMAL | LAYOUT_LEFT)
    self.page_label = FXLabel.new(controls, "Страница: 1/1", opts: LAYOUT_CENTER_X)
    self.next_button = FXButton.new(controls, ">>>", opts: BUTTON_NORMAL | LAYOUT_RIGHT)

    self.prev_button.connect(SEL_COMMAND) { switch_page(-1) }
    self.next_button.connect(SEL_COMMAND) { switch_page(1) }

    self.table.columnHeader.connect(SEL_COMMAND) do |_, _, pos|
        self.controller.sort_table_by_column
        self.controller.refresh_data
    end

  end

    def setup_control_buttons_area
      button_area = FXHorizontalFrame.new(self, opts: LAYOUT_FILL_X | PACK_UNIFORM_WIDTH)
      self.add_button = FXButton.new(button_area, "Добавить", opts: BUTTON_NORMAL)
      self.edit_button = FXButton.new(button_area, "Изменить", opts: BUTTON_NORMAL)
      self.delete_button = FXButton.new(button_area, "Удалить", opts: BUTTON_NORMAL)
      self.update_button = FXButton.new(button_area, "Обновить", opts: BUTTON_NORMAL)

      self.add_button.connect(SEL_COMMAND) { on_add }
      self.update_button.connect(SEL_COMMAND) { on_update }
      self.edit_button.connect(SEL_COMMAND) { on_edit }
      self.delete_button.connect(SEL_COMMAND) { on_delete }
      self.table.connect(SEL_SELECTED) { update_button_states }
      self.table.connect(SEL_DESELECTED) { update_button_states }

      update_button_states
    end


  def set_table_params(column_names, whole_entities_count)
    column_names.each_with_index do |name, index|
      self.table.setColumnText(index, name)
    end

    self.total_pages = (whole_entities_count / ROWS_PER_PAGE.to_f).ceil
    update_page_label
  end


  def set_table_data(data_table)
    clear_table  
    (1...data_table.row_count).each do |row|
      (0...data_table.column_count).each do |col|
        self.table.setItemText(row - 1, col, data_table.get(row-1, col).to_s)
      end
    end
  end

  def refresh_data
    self.current_page_label = 1
    self.controller.refresh_data
  end

  private
  
  attr_accessor :table, :total_pages, :prev_button, :next_button, :sort_order, :add_button, :update_button, :edit_button, :delete_button,
  :filters, :page_label, :selected_rows

  

  def update_page_label
    self.page_label.text = "Страница: #{self.current_page_label}/#{self.total_pages}"
  end



  def clear_table
    (0...self.table.numRows).each do |row_index|
      (0...self.table.numColumns).each do |col_index|
        self.table.setItemText(row_index, col_index, "")
      end
    end

  end

  def on_add
    self.controller.add
  end
  
  def on_update
    self.refresh_data
  end
  
  def on_edit
    self.selected_rows = []
    (0...self.table.numRows).each do |index|
        self.selected_rows << index if self.table.rowSelected?(index)
    end
    self.controller.update(self.selected_rows[0])
  end
  
  def on_delete
    self.selected_rows = []
    (0...self.table.numRows).each do |index|
        self.selected_rows << index if self.table.rowSelected?(index)
    end
    self.controller.delete(self.selected_rows)
  end



  def switch_page(direction)
    new_page = self.current_page_label + direction
    if new_page > 0 && new_page <= self.total_pages
      self.current_page_label = new_page
      self.controller.refresh_data
    end
  end

  
  def get_selected_rows
    selected_rows = []

    (0...self.table.numRows).each do |row|
      selected_rows << row if self.table.rowSelected?(row)
    end

    selected_rows
  end

  def update_button_states
    selected_rows = get_selected_rows
  
    self.add_button.enabled = true
    self.update_button.enabled = true
  
    case selected_rows.size
    when 0
      self.edit_button.enabled = false
      self.delete_button.enabled = false
    when 1
      self.edit_button.enabled = true
      self.delete_button.enabled = true
    else
      self.edit_button.enabled = false
      self.delete_button.enabled = true
    end
  end


  def reset_filters
    self.filters.each_value do |field|
      field[:combo_box].setCurrentItem(0) if !field[:combo_box].nil?
      field[:text_field].text = ""
    end
    self.controller.refresh_data
  end
  
end