package superWinner.data
{
   import ddt.data.player.PlayerInfo;
   
   public class SuperWinnerPlayerInfo extends PlayerInfo
   {
       
      
      private var _isOnline:Boolean;
      
      public function SuperWinnerPlayerInfo(){super();}
      
      public function set IsOnline(param1:Boolean) : void{}
      
      public function get IsOnline() : Boolean{return false;}
   }
}
