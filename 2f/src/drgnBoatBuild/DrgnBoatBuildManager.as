package drgnBoatBuild
{
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.utils.MD5;
   import ddt.CoreManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import drgnBoatBuild.event.DrgnBoatBuildEvent;
   import flash.net.URLVariables;
   import hall.player.HallPlayerView;
   import road7th.StarlingMain;
   import road7th.comm.PackageIn;
   import starling.scene.hall.HallScene;
   import starling.scene.hall.StaticLayer;
   
   public class DrgnBoatBuildManager extends CoreManager
   {
      
      private static var _instance:DrgnBoatBuildManager;
       
      
      private var _playerView:HallPlayerView;
      
      private var _btn:BaseButton;
      
      private var buildingStage:int;
      
      private var progress:int;
      
      public var friendStateList:Array;
      
      public var isMcPlay:Boolean;
      
      public var selectedId:int;
      
      public function DrgnBoatBuildManager(){super();}
      
      public static function get instance() : DrgnBoatBuildManager{return null;}
      
      public function setup(param1:HallPlayerView, param2:BaseButton) : void{}
      
      public function addToHall() : void{}
      
      public function removeFromHall() : void{}
      
      public function initBuildingStatus(param1:PackageIn) : void{}
      
      public function updateBuildInfo(param1:PackageIn) : void{}
      
      public function receiveCommitResult(param1:PackageIn) : void{}
      
      public function receiveHelpToBuild(param1:PackageIn) : void{}
      
      public function updateDrgnBoatFriendList() : void{}
      
      public function setupFriendList(param1:DrgnBoatFriendsAnalyzer) : void{}
      
      override protected function start() : void{}
   }
}
