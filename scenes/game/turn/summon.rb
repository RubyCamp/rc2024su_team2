module Scenes
  module Game
    module Turn
      class Summon
        # [S]keyを押したらカードを召喚する
        def update
          exit if Gosu.button_down?(Gosu::KB_ESCAPE)
          if Gosu.button_down?(Gosu::KB_S)
            # カードを召喚する
            #空いているモンスターゾーンにカードを召喚する
            #モンスターゾーンがいっぱいの場合は召喚できない
            #フラグで召喚したかどうかを管理する？
          end
        end

        private
  
    #召喚するモンスターをキーボードの1~5のキーで選択する
      def summon_card
        puts "召喚するモンスターを1から5のキーを押して選択してください"

    end
  end
end