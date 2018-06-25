package dreamlandChallenge.data
{
   public class DCSpeedMatchRankMode
   {
       
      
      private var _selfRanking:int;
      
      private var _rankItems:Array;
      
      private var _totalPage:int;
      
      public function DCSpeedMatchRankMode()
      {
         super();
         _rankItems = [];
      }
      
      public function get totalPage() : int
      {
         return _totalPage;
      }
      
      public function set totalPage(value:int) : void
      {
         _totalPage = value;
      }
      
      public function get selfRanking() : int
      {
         return _selfRanking;
      }
      
      public function set selfRanking(value:int) : void
      {
         _selfRanking = value;
      }
      
      public function get rankItems() : Array
      {
         return _rankItems;
      }
      
      public function addItem(item:DCSpeedMatchRankVo) : void
      {
         _rankItems.push(item);
      }
      
      public function clear() : void
      {
         _rankItems.length = 0;
      }
   }
}
