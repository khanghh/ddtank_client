package funnyGames.cubeGame.data
{
   public class CubeGameRankData
   {
       
      
      private var _rank:uint;
      
      private var _name:String;
      
      private var _score:uint;
      
      public function CubeGameRankData(rank:uint, name:String, score:uint)
      {
         super();
         _rank = rank;
         _name = name;
         _score = score;
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
