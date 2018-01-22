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
      
      public function set IsOnline(param1:Boolean) : void
      {
         _isOnline = param1;
      }
      
      public function get IsOnline() : Boolean
      {
         return _isOnline;
      }
   }
}
