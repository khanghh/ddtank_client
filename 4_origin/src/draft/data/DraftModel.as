package draft.data
{
   import ddt.data.player.PlayerInfo;
   
   public class DraftModel
   {
      
      private static var _total:int = 1;
      
      public static var UploadNum:int;
       
      
      public var id:int;
      
      public var playerInfo:PlayerInfo;
      
      public var rank:int;
      
      public var ticketNum:int;
      
      public function DraftModel()
      {
         super();
         playerInfo = new PlayerInfo();
      }
      
      public static function get Total() : int
      {
         return _total;
      }
      
      public static function set Total(value:int) : void
      {
         if(value > 0)
         {
            _total = value / 5;
            if(value % 5 > 0)
            {
               _total = _total + 1;
            }
         }
      }
   }
}
