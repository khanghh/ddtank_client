package farm.modelx
{
   import ddt.data.player.FriendListPlayer;
   import ddt.manager.PlayerManager;
   
   public class FramFriendStateInfo
   {
       
      
      public var id:int;
      
      public var landStateVec:Vector.<SimpleLandStateInfo>;
      
      private var _isFeed:Boolean;
      
      public function FramFriendStateInfo(){super();}
      
      public function get playerinfo() : FriendListPlayer{return null;}
      
      public function get hasGrownLand() : Boolean{return false;}
      
      public function get isStolen() : Boolean{return false;}
      
      public function set isFeed(param1:Boolean) : void{}
      
      public function get isFeed() : Boolean{return false;}
      
      public function set setLandStateVec(param1:Vector.<SimpleLandStateInfo>) : void{}
   }
}
