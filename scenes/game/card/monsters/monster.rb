module Scenes
    module Game
      module Card
        module Monsters
            class Monster < Base
                attr_accessor :atk
                def initialize(name,atk,describe)
                    super(name,describe)
                    @atk = atk
                end
            end
        end
      end
    end
end