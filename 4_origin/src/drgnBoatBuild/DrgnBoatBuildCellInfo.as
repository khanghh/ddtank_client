package drgnBoatBuild
{
   import ddt.data.player.FriendListPlayer;
   import ddt.manager.PlayerManager;
   
   public class DrgnBoatBuildCellInfo
   {
       
      
      public var id:int;
      
      public var stage:int;
      
      public var progress:int;
      
      public function DrgnBoatBuildCellInfo()
      {
         super();
      }
      
      public function get playerinfo() : FriendListPlayer
      {
         return PlayerManager.Instance.friendList[id];
      }
      
      public function get canBuild() : Boolean
      {
         switch(int(stage) - 1)
         {
            case 0:
               return progress >= 0 && progress < 330;
            case 1:
               return progress >= 330 && progress < 660;
            case 2:
               return progress >= 660 && progress < 990;
         }
      }
   }
}
