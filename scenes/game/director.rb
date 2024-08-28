require_relative 'turn/draw'

module Scenes
    module Game
      # エンディングシーンの担当ディレクタークラス
      class Director < DirectorBase
        # コンストラクタ
        def initialize
          super
          @bg_img = Gosu::Image.new("images/bg_game.png", tileable: true)
        #   @bgm = load_bgm("bgm3.mp3", 0.3)
        end
    
        # 1フレーム分の更新処理
        def update(opt = {})
          if key_push?(Gosu::KB_SPACE)
            transition(:ending)
            # @bgm.stop if @bgm && @bgm.playing?
          end
        end
  
        # 1フレーム分の描画処理
        def draw
          @bg_img.draw(0, 0, 1)
        end
      end
    end
  end