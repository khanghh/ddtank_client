package littleGame.model
{
   import ddt.data.player.PlayerInfo;
   import littleGame.events.LittleLivingEvent;
   
   public class LittlePlayer extends LittleLiving
   {
       
      
      private var _playerInfo:PlayerInfo;
      
      public function LittlePlayer(param1:PlayerInfo, param2:int, param3:int, param4:int, param5:int){super(null,null,null,null);}
      
      public function get playerInfo() : PlayerInfo{return null;}
      
      override public function get isPlayer() : Boolean{return false;}
      
      override public function toString() : String{return null;}
      
      public function set headType(param1:int) : void{}
   }
}
