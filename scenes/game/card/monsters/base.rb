module Scenes
    module Game
        module Card
            module monsters

                #カードの共通項目
                class Base
                @@card_ground_img = Gosu::Image.new("images/", tileable: true)  #カードの表面画像(土台の部分)
                @@card_ground_img = Gosu::Image.new("images/", tileable: true)  #カードの文字の枠画像
                @@name_font = Gosu::Font.new(, name: DirectorBase::)            #カードのモンスターなどの名前の部分
                @@atk_font = Gosu::Font.new(, name: DirectorBase::)             #カードのモンスターなどの攻撃力や効果の部分
                @@describe_font =Gosu::Font.new(, name: DirectorBase::)         #カードのモンスターなどの説明の部分

                WIDTH = 100               # カードの横幅(px)
                HEIGHT = 150              # カードの高さ(px)
                
                # 必要なアクセサメソッドの定義
                attr_accessor :num, :x, :y, :z

                # コンストラクタ
                def initialize(_num, _x, _y, _z = 1)
                    self.num = _num
                    self.x = _x
                    self.y = _y
                    self.z = _z
                    