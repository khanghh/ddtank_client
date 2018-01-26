package drgnBoatBuild
{
   import ddt.data.player.FriendListPlayer;
   import ddt.manager.PlayerManager;
   
   public class DrgnBoatBuildCellInfo
   {
       
      
      public var id:int;
      
      public var stage:int;
      
      public var progress:int;
      
      public function DrgnBoatBuildCellInfo(){super();}
      
      public function get playerinfo() : FriendListPlayer{return null;}
      
      public function get canBuild() : Boolean{return false;}
   }
}
