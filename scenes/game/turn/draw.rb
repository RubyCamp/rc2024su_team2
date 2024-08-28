module Scenes
  module Game
    class Draw

      def initialize
        @hands_of_cards = Scenes::Manager.instance
        self.caption = "Rectangle Display"
        @rectangles = []  # 長方形を格納する配列
        @first_call = true # 初回呼び出しフラグ
      end

      def update
        # 特に更新する内容はなし
      end
      
      def draw
        @rectangles.each do |rect|
          draw_rect(rect[:x], rect[:y], rect[:width], rect[:height], rect[:color])
        end
      end

      def button_down(id)
        if id == Gosu::KB_D  # "D" キーが押されたとき
          create_rectangles
        elsif id == Gosu::KB_R  # "R" キーが押されたとき
          random_remove
        end
      end

      def create_rectangles
        width = 100
        gap = 10
        required_count = 5
        x_start = 230
        current_x_positions = @rectangles.map { |rect| rect[:x] }  # 既存の長方形の x 座標を取得
        colors = [Gosu::Color::WHITE, Gosu::Color::RED, Gosu::Color::YELLOW, Gosu::Color::BLUE]  # 色の配列
    
        x = x_start
    
        while @rectangles.size < required_count
          unless current_x_positions.include?(x)
            color = colors[@rectangles.size % colors.size]  # 色を順番に選択
            @rectangles << { x: x, y: 420, width: width, height: 150 , color: color}
          end
          x += width + gap  # 次の長方形の位置を計算
        end
      end

      def random_remove
        # 1 から 4 つまでのランダムな数の長方形を削除
        rand(1..4).times do
          @rectangles.delete_at(rand(@rectangles.size))
        end
      end
    end    
  end
end