module Scenes
    module Game
      module Card
        module monsters
  
          # カードの共通項目
          class Base
            @@card_ground_img = Gosu::Image.new("images/", tileable: true)                   # カードの表面画像(土台の部分)
            @@base_font = Gosu::Font.new(24, name: DirectorBase::FONT_FILENAME)              # カードのベースのフォント
            @@name_font = Gosu::Font.new(24, name: DirectorBase::FONT_FILENAME)              # カードのモンスターなどの名前のフォント
            @@atk_font = Gosu::Font.new(24, name: DirectorBase::FONT_FILENAME)               # カードのモンスターなどの攻撃力や効果のフォント
            @@describe_font = Gosu::Font.new(24, name: DirectorBase::FONT_FILENAME)          # カードのモンスターなどの説明のフォント
  
            WIDTH = 100               # カードの横幅(px)
            HEIGHT = 150              # カードの高さ(px)
            NAME_OFFSET_Y = 5         # 名前のY方向表示位置
            ATK_OFFSET_X = 75         # 攻撃力のX方向表示位置
            ATK_OFFSET_Y = 32         # 攻撃力のY方向表示位置
            DESCRIBE_OFFSET_Y = 120   # 説明のY方向表示位置
            SCALE = 1                 # スケール値を設定
            BORDER_COLOR = Gosu::Color::WHITE   # 枠の色を設定
            BORDER_THICKNESS = 2      # 枠の太さを設定
  
            # 必要なアクセサメソッドの定義
            attr_accessor :num, :x, :y, :z
  
            # コンストラクタ
            def initialize(_num, _x, _y, _z = 1)
              self.num = _num
              self.x = _x
              self.y = _y
              self.z = _z
              @num_w = @@name_font.text_width(self.class::MONSTERS_NAME)
              @num_h = @@name_font.height
            end
  
            # カードを画面に描画する
            def draw
              draw_ground
            end
  
            private
  
            # カードの土台の描画
            def draw_ground
              @@card_ground_img.draw(self.x, self.y, self.z)
              draw_name
              draw_atk
              draw_describe
            end
  
            # 四角い枠を描画するメソッド
            def draw_border(x, y, width, height, color = BORDER_COLOR)
              # 上辺
              Gosu.draw_rect(x, y, width, BORDER_THICKNESS, color, self.z + 1)
              # 下辺
              Gosu.draw_rect(x, y + height - BORDER_THICKNESS, width, BORDER_THICKNESS, color, self.z + 1)
              # 左辺
              Gosu.draw_rect(x, y, BORDER_THICKNESS, height, color, self.z + 1)
              # 右辺
              Gosu.draw_rect(x + width - BORDER_THICKNESS, y, BORDER_THICKNESS, height, color, self.z + 1)
            end
  
            # カードのモンスター名の描画
            def draw_name
              draw_border(self.x + (@@card_ground_img.width / 2) - (@num_w / 2) - 2, self.y + NAME_OFFSET_Y - 2, @num_w + 4, @num_h + 4)
              @@name_font.draw_text(
                self.class::MONSTERS_NAME,
                self.x + (@@card_ground_img.width / 2) - (@num_w / 2),
                self.y + NAME_OFFSET_Y,
                self.z,
                SCALE, SCALE)
            end
  
            # モンスターの攻撃力の描画
            def draw_atk
              atk_width = @@atk_font.text_width(self.class::MONSTERS_ATK)
              atk_height = @@atk_font.height
              draw_border(self.x + ATK_OFFSET_X - 2, self.y + ATK_OFFSET_Y - 2, atk_width + 4, atk_height + 4)
              @@atk_font.draw_text(
                self.class::MONSTERS_ATK,
                self.x + ATK_OFFSET_X,
                self.y + ATK_OFFSET_Y,
                self.z,
                SCALE, SCALE)
            end
  
            # モンスターの説明の描画
            def draw_describe
              describe_width = @@describe_font.text_width(self.class::MONSTERS_DESCRIBE)
              describe_height = @@describe_font.height
              draw_border(self.x + (@@card_ground_img.width / 2) - (describe_width / 2) - 2, self.y + DESCRIBE_OFFSET_Y - 2, describe_width + 4, describe_height + 4)
              @@describe_font.draw_text(
                self.class::MONSTERS_DESCRIBE,
                self.x + (@@card_ground_img.width / 2) - (describe_width / 2),
                self.y + DESCRIBE_OFFSET_Y,
                self.z,
                SCALE, SCALE)
            end
          end
        end
      end
    end
  end
  