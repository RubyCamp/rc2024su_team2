require 'gosu'
=begin
require_relative 'scenes/manager'
require_relative 'scenes/director_base'
require_relative 'scenes/title/director'
=end
=begin
require_relative 'scenes/game/director'
require_relative 'scenes/ending/director'
require_relative 'scenes/game_over/director'
=end
# ゲームのメインウィンドウ（メインループ）用クラス
class MainWindow < Gosu::Window
  # 各種定数定義
  WIDTH = 800
  HEIGHT = 600
  FULL_SCREEN = false
  @@selected_card_index = 0
  @@summon_count=0

  def initialize
    super 800, 600, false
    self.caption = 'RubyCamp2024Summer tutorial'

    @char = Gosu::Image.new("images/card.png", tileable: false)
    @card_positions=[
      [230,420],
      [340,420],
      [450,420],
      [560,420],
      [670,420]
    ]
    @summoned_card_positions=[]
  end

  def update
      exit if Gosu.button_down?(Gosu::KB_ESCAPE)
          if Gosu.button_down?(Gosu::KB_S)
            puts "召喚"
            if @@summon_count==0
              puts "0"
              @summoned_card_positions<<[450,30]
              @@summon_count+=1
            elsif @@summon_count==1
              @@summoned_card_positions<<[500,30]
              @@summon_count+=1
            elsif @@summon_count==2
              @@summoned_card_positions<<[550,30]
              @@summon_count+=1
            end
      end
  end

  def draw
    @card_positions.each do |(x,y)|
      @char.draw(x, y, 0)
    end
    @summoned_card_positions.each do |(x,y)|
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
    end
  elsif id==Gosu::KB_S
    puts "召喚"
  end
  private
  
  #召喚するモンスターをキーボードの1~5のキーで選択する
    def summon_card
      #puts "召喚するモンスターを1から5のキーを押して選択してください"
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
=begin
  # コンストラクタ
  def initialize
    super WIDTH, HEIGHT, FULL_SCREEN
    self.caption = 'RubyCamp2024Summer Example'

    @scene_manager = Scenes::Manager.instance
    @scene_manager.add(:title, Scenes::Title::Director.new)
    #@scene_manager.add(:game, Scenes::Game::Director.new)
    #@scene_manager.add(:ending, Scenes::Ending::Director.new)
    #@scene_manager.add(:game_over, Scenes::GameOver::Director.new)
    @scene_manager.set(:title)
  end

  # 1フレーム分の更新処理
  def update
    exit if Gosu.button_down?(Gosu::KB_ESCAPE)
    opt = {
      mx: self.mouse_x,
      my: self.mouse_y
    }
    @scene_manager.update(opt)
  end

  # 1フレーム分の描画処理
  def draw
    @scene_manager.draw
  end
end
=end
# ゲーム開始
window = MainWindow.new
window.show