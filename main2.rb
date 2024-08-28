require 'gosu'

class MainWindow < Gosu::Window
  WIDTH = 800
  HEIGHT = 600
  FULL_SCREEN = false
  @@selected_card_index = 0
  @@summon_count = 0

  def initialize
    super WIDTH, HEIGHT, FULL_SCREEN
    self.caption = 'RubyCamp2024Summer tutorial'

    @char = Gosu::Image.new("images/card.png", tileable: false)
    @card_positions = [
      [230, 420],
      [340, 420],
      [450, 420],
      [560, 420],
      [670, 420]
    ]
    @summoned_card_positions = []
  end

  def update
    exit if Gosu.button_down?(Gosu::KB_ESCAPE)

    summon_card  # カードを選択するメソッドを呼び出す

    if Gosu.button_down?(Gosu::KB_S)
      puts "召喚"
      if @@summon_count < 3
        # 選択されたカードを特定の場所に描画する
        x_position = 450 + 50 * @@summon_count
        @summoned_card_positions << [x_position, 30]
        @@summon_count += 1
      end
    end
  end

  def draw
    @card_positions.each do |(x, y)|
      @char.draw(x, y, 0)
    end
    @summoned_card_positions.each do |(x, y)|
      @char.draw(x, y, 0)
    end
  end

  def button_down(id)
    if id == Gosu::KB_D  # "D" キーが押されたとき
      create_rectangles
      output_data  # `@data` の内容をターミナルに出力
    elsif id == Gosu::KB_R  # "R" キーが押されたとき
      random_remove
      output_data  # `@data` の内容をターミナルに出力
    elsif id == Gosu::KB_S
      puts "召喚"
    end
  end

  private

  # 召喚するモンスターをキーボードの1~5のキーで選択する
  def summon_card
    if Gosu.button_down?(Gosu::KB_1)
      @@selected_card_index = 1
    elsif Gosu.button_down?(Gosu::KB_2)
      @@selected_card_index = 2
    elsif Gosu.button_down?(Gosu::KB_3)
      @@selected_card_index = 3
    elsif Gosu.button_down?(Gosu::KB_4)
      @@selected_card_index = 4
    elsif Gosu.button_down?(Gosu::KB_5)
      @@selected_card_index = 5
    end
  end
end

# ゲーム開始
window = MainWindow.new
window.show
