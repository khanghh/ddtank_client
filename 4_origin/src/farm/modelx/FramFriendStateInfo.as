package farm.modelx
{
   import ddt.data.player.FriendListPlayer;
   import ddt.manager.PlayerManager;
   
   public class FramFriendStateInfo
   {
       
      
      public var id:int;
      
      public var landStateVec:Vector.<SimpleLandStateInfo>;
      
      private var _isFeed:Boolean;
      
      public function FramFriendStateInfo()
      {
         super();
         landStateVec = new Vector.<SimpleLandStateInfo>();
      }
      
      public function get playerinfo() : FriendListPlayer
      {
         return PlayerManager.Instance.friendList[id];
      }
      
      public function get hasGrownLand() : Boolean
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < landStateVec.length)
         {
            if(landStateVec[_loc1_].hasPlantGrown)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      public function get isStolen() : Boolean
      {
         var _loc1_:int = 0;
         if(hasGrownLand)
         {
            _loc1_ = 0;
            while(_loc1_ < landStateVec.length)
            {
               if(landStateVec[_loc1_].isStolen)
               {
                  return true;
               }
               _loc1_++;
            }
         }
         return false;
      }
      
      public function set isFeed(param1:Boolean) : void
      {
         _isFeed = param1;
      }
      
      public function get isFeed() : Boolean
      {
         return _isFeed;
      }
      
      public function set setLandStateVec(param1:Vector.<SimpleLandStateInfo>) : void
      {
         landStateVec = param1;
      }
   }
}
