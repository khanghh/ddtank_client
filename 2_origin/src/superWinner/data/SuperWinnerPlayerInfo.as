package superWinner.data
{
   import ddt.data.player.PlayerInfo;
   
   public class SuperWinnerPlayerInfo extends PlayerInfo
   {
       
      
      private var _isOnline:Boolean;
      
      public function SuperWinnerPlayerInfo()
      {
         super();
      }
      
      public function set IsOnline(val:Boolean) : void
      {
         _isOnline = val;
      }
      
      public function get IsOnline() : Boolean
      {
         return _isOnline;
      }
   }
}
