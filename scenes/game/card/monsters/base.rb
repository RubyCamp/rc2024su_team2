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

                WIDTH =                # カードの横幅(px)
                HEIGHT = 2              # カードの高さ(px)