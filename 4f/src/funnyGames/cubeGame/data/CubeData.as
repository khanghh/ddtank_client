package funnyGames.cubeGame.data
{
   public class CubeData
   {
      
      private static const ANT:uint = 1;
      
      private static const ANT_BOSS:uint = 2;
      
      private static const BOGU:uint = 3;
      
      private static const BOGU_BOSS:uint = 4;
      
      private static const GRAY:uint = 5;
      
      private static const GRAY_BOSS:uint = 6;
      
      private static const BEAN:uint = 7;
      
      private static const BEAN_BOSS:uint = 8;
      
      private static const CHOOK:uint = 9;
      
      private static const CHOOK_BOSS:uint = 10;
      
      private static const MONSTER:uint = 11;
      
      private static const MONSTER_BOSS:uint = 12;
      
      private static const ANT_LINK:uint = 0;
      
      private static const BOGU_LINK:uint = 1;
      
      private static const GRAY_LINK:uint = 2;
      
      private static const BEAN_LINK:uint = 3;
      
      private static const CHOOK_LINK:uint = 4;
      
      private static const MONSTER_LINK:uint = 5;
       
      
      private var _id:uint;
      
      private var _type:int;
      
      private var _linkType:int;
      
      public function CubeData(param1:int, param2:int){super();}
      
      public function get linkType() : int{return 0;}
      
      private function parseLink() : void{}
      
      public function get type() : int{return 0;}
      
      public function get id() : uint{return null;}
   }
}
