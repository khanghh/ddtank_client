package funnyGames.cubeGame.data
{
   public class CubeGameRankData
   {
       
      
      private var _rank:uint;
      
      private var _name:String;
      
      private var _score:uint;
      
      public function CubeGameRankData(param1:uint, param2:String, param3:uint)
      {
         super();
         _rank = param1;
         _name = param2;
         _score = param3;
      }
      
      public function get score() : uint
      {
         return _score;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get rank() : uint
      {
         return _rank;
      }
   }
}
