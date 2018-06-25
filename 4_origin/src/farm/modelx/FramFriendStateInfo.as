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
         var i:int = 0;
         for(i = 0; i < landStateVec.length; )
         {
            if(landStateVec[i].hasPlantGrown)
            {
               return true;
            }
            i++;
         }
         return false;
      }
      
      public function get isStolen() : Boolean
      {
         var i:int = 0;
         if(hasGrownLand)
         {
            for(i = 0; i < landStateVec.length; )
            {
               if(landStateVec[i].isStolen)
               {
                  return true;
               }
               i++;
            }
         }
         return false;
      }
      
      public function set isFeed(value:Boolean) : void
      {
         _isFeed = value;
      }
      
      public function get isFeed() : Boolean
      {
         return _isFeed;
      }
      
      public function set setLandStateVec(value:Vector.<SimpleLandStateInfo>) : void
      {
         landStateVec = value;
      }
   }
}
