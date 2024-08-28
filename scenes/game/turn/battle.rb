module Scenes
    module Game
        module Turn
            class Battle
            # [B]keyを押したらバトルを開始する
                def update
                exit if Gosu.button_down?(Gosu::KB_ESCAPE)
                if Gosu.button_down?(Gosu::KB_B)
                # バトルを開始する
                #スコアを管理する変数に与えたダメージを加算する(モンスターの総合攻撃力を加算)
                # バトルの結果を表示する
                end
                end
            end
        end
    end
end 