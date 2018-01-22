package invite.data
{
   import ddt.data.player.PlayerInfo;
   
   public class InvitePlayerInfo extends PlayerInfo
   {
       
      
      public var invited:Boolean = false;
      
      public var type:int = 1;
      
      public var titleText:String = "";
      
      public var titleNumText:String = "";
      
      public var titleType:int;
      
      public var titleIsSelected:Boolean;
      
      public function InvitePlayerInfo()
      {
         super();
      }
   }
}
