require_relative 'card/monsters/base'
require_relative 'card/monsters/monster'

module Scenes
  module Game
    # ゲーム本編シーンの担当ディレクタークラス
    class Director < DirectorBase
      FPS = 30                          # 1秒間の表示フレーム数

      # コンストラクタ
      def initialize
        super

        # 各種インスタンス変数の初期化
        @cards = [] 
        @message_display_frame_count = 0                                           # 全てのカードを保持する配列
        @bg_img = Gosu::Image.new("images/bg_title.png", tileable: true)

        # カードの要素を配列に格納
        cards_data = [
          {name: "出雲大社",atk: 3000,describe: "出雲"}
        ]

        cards_data.each do |data|
            @cards << Card::Monsters::Monster.new(data[:name], data[:atk], data[:describe])
        end
      end

      # 1フレーム分の更新処理
      def update(opt = {})
        # BGMをスタートする（未スタート時のみ）
        @bgm.play if @bgm && !@bgm.playing?

        # マウスの現在座標を変数化しておく
        mx = opt.has_key?(:mx) ? opt[:mx] : 0
        my = opt.has_key?(:my) ? opt[:my] : 0

        # ゲームクリアフラグが立ち、且つ画面への判定結果表示が完了済みの場合、エンディングシーンへ切り替えを行う
        if @cleared && @message_display_frame_count == 0
          @bgm.stop if @bgm && @bgm.playing?
          transition(:ending)
        end

        # タイムリミットバーの長さを更新
        # NOTE: メッセージ表示中か否かによらず、毎フレーム一定の減衰を行うため、条件分岐の外に定義する
      #   @timelimit_scale -= @timelimit_decrease_unit if @timelimit_scale > 0
       end

      # 1フレーム分の描画処理
      def draw
        # 背景画像を表示
        @bg_img.draw(0, 0, 0)

        # 全カードを表示
        # NOTE: 重なり合わせを適正に表現するため、各カードの最新Z値でソートして表示する（マウスクリックでカードのZ値が変化するため）
        @cards.each do |card|
          card.draw
        end

      end

      private


      # マウスによる操作判定
      def check_mouse_operations(mx, my)
        if Gosu.button_down?(Gosu::MsLeft)
          # マウスの左ボタンがクリックされている場合
          unless @drag_start_pos
            # マウスドラッグが開始されていない場合、現在のマウス座標からドラッグを開始する
            start_drag(mx, my)
            @drag_start_pos = [mx, my]
          else
            # マウス左クリック＆ドラッグ開始済みであるため、ドラッグ中と判定し処理を実施する
            dragging(mx, my)
          end
        else
          # マウスの左ボタンが解放されている場合
          # ドラッグ中であれば、ドロップ処理を実施し、ドラッグ中フラグを下ろす
          dropped if @drag_start_pos
          @drag_start_pos = nil
        end
      end

      # 新規ドラッグ開始時の処理
      # マウスカーソル座標上に存在する最もZ値の高いカードをオープンし、掴んだ状態にする
      def start_drag(mx, my)
        # 判定対象となるカードを一時的にまとめるための配列を初期化
        clicked_cards = []

        # 全カードに対して、現在のマウス座標が自身の表示エリアに被っているか判定させ、被っているカードを配列に納めていく
        @cards.each do |card|
          clicked_cards << card if card.clicked?(mx, my)
        end

        # マウスカーソルの座標上に1枚以上カードが存在する場合
        if clicked_cards.size > 0
          # マウス座標と被っているカードが1個以上ある場合、そのZ座標（重なり具合）でソートし、最も上にあるカードのみをオープンする
          @opened_card = clicked_cards.sort_by{|c| c.z }.last
          @opened_card.open

          # クリックされたカードのZ値を、全てのカードに対して最大化する（一番上に重なるようにする）
          @opened_card.z = @cards.max_by{|c| c.z }.z + 1

          # マウス座標とクリックされたカードの左上座標の差分をドラッグ時のオフセット値として保存する。
          @offset_mx = mx - @opened_card.x
          @offset_my = my - @opened_card.y
        end
      end

      # ドラッグ中に発生する処理
      def dragging(mx, my)
        # 現在開いているカードが無い場合は何もしない（移動するべき対象物が無いため）
        return unless @opened_card

        # 現フレームにおけるマウス座標がドラッグ開始位置と同一の場合は何もしない
        return if @drag_start_pos == [mx, my]

        # 上記いずれにも該当しない場合、対象カードの座標を移動する
        # NOTE: その際、ドラッグ開始時点で保存したオフセット値を引くことで、マウス座標が不自然に移動することを防止する
        @opened_card.x = mx - @offset_mx
        @opened_card.y = my - @offset_my
      end

      # ドラッグに対するドロップ処理
      def dropped
        # オープン済みカードが無ければ何もしない
        return unless @opened_card

        # オープンされたカードが既にオープン済みでなければ、オープン済みカードリストに追加する
        @opened_cards << @opened_card unless @opened_cards.include?(@opened_card)
        @opened_card = nil
      end

      # 開いたカードの後始末を行う
      def cleaning_up
        # 判定結果に沿って開いたカードの状態を変化させる
        # * 一致した場合： 開いたカードを消去
        # * 一致しなかった場合： 開いたカードを閉じるのみ
        @opened_cards.each do |c|
          c.reverse
          @cards.delete(c) if @judgement_result
#require_relative 'turn/draw'

      # エンディングシーンの担当ディレクタークラス
#      class Director < DirectorBase
        # コンストラクタ
 #       def initialize
  #        super
  #        @bg_img = Gosu::Image.new("images/bg_game.png", tileable: true)
        #   @bgm = load_bgm("bgm3.mp3", 0.3)
   #     end
    
        # 1フレーム分の更新処理
    #    def update(opt = {})
     #     if key_push?(Gosu::KB_SPACE)
      #      transition(:ending)
            # @bgm.stop if @bgm && @bgm.playing?
       #   end
        #end
  

        # 開いたカードリストをクリア
        @opened_cards.clear
        end
      end
    end
  end
end
