module Scenes
    module Game
        module Turn
            class TurnEnd
            # [E]keyを押したらターンを終了する
                def update
                exit if Gosu.button_down?(Gosu::KB_ESCAPE)
                if Gosu.button_down?(Gosu::KB_E)
                    transition(:ending)
                    # ターンを終了する
                    # ターン数を加算する
                end
                end
            end
        end
    end
end