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
      
      public function DrgnBoatBuildManager()
      {
         super();
      }
      
      public static function get instance() : DrgnBoatBuildManager
      {
         if(!_instance)
         {
            _instance = new DrgnBoatBuildManager();
         }
         return _instance;
      }
      
      public function setup(view:HallPlayerView, btn:BaseButton) : void
      {
         _playerView = view;
         _btn = btn;
         _btn.visible = false;
      }
      
      public function addToHall() : void
      {
         var staticLayr:* = null;
         _btn.visible = true;
         var currentScene:HallScene = StarlingMain.instance.currentScene as HallScene;
         if(currentScene)
         {
            staticLayr = currentScene.playerView.staticLayer;
            staticLayr.createNpc("drgnBoatBuilding");
            staticLayr.changeBuildNpcBtnAni("drgnBoatBuilding","stand" + 6.toString());
         }
      }
      
      public function removeFromHall() : void
      {
         var staticLayr:* = null;
         _btn.visible = false;
         var currentScene:HallScene = StarlingMain.instance.currentScene as HallScene;
         if(currentScene)
         {
            staticLayr = currentScene.playerView.staticLayer;
            staticLayr.removeBuildNpcBtn("drgnBoatBuilding");
         }
      }
      
      public function initBuildingStatus(pkg:PackageIn) : void
      {
         var staticLayr:* = null;
         buildingStage = pkg.readInt();
         progress = pkg.readInt();
         var currentScene:HallScene = StarlingMain.instance.currentScene as HallScene;
         if(currentScene)
         {
            staticLayr = currentScene.playerView.staticLayer;
            staticLayr.changeBuildNpcBtnAni("drgnBoatBuilding","stand" + 6.toString());
         }
      }
      
      public function updateBuildInfo(pkg:PackageIn) : void
      {
         var currentScene:* = null;
         var staticLayr:* = null;
         var info:DrgnBoatBuildCellInfo = new DrgnBoatBuildCellInfo();
         info.id = pkg.readInt();
         info.stage = pkg.readInt();
         info.progress = pkg.readInt();
         if(info.id == PlayerManager.Instance.Self.ID)
         {
            buildingStage = info.stage;
            progress = info.progress;
            currentScene = StarlingMain.instance.currentScene as HallScene;
            if(currentScene)
            {
               staticLayr = currentScene.playerView.staticLayer;
               staticLayr.changeBuildNpcBtnAni("drgnBoatBuilding","stand" + 6.toString());
            }
         }
         var event:DrgnBoatBuildEvent = new DrgnBoatBuildEvent("updateView");
         event.info = info;
         dispatchEvent(event);
      }
      
      public function receiveCommitResult(pkg:PackageIn) : void
      {
         isMcPlay = pkg.readBoolean();
         if(isMcPlay)
         {
            SocketManager.Instance.out.updateDrgnBoatBuildInfo();
         }
      }
      
      public function receiveHelpToBuild(pkg:PackageIn) : void
      {
         var result:Boolean = pkg.readBoolean();
         var id:int = pkg.readInt();
         if(result)
         {
            SocketManager.Instance.out.updateDrgnBoatBuildInfo(id);
         }
      }
      
      public function updateDrgnBoatFriendList() : void
      {
         var args:URLVariables = new URLVariables();
         args["selfid"] = PlayerManager.Instance.Self.ID;
         args["key"] = MD5.hash(PlayerManager.Instance.Account.Password);
         args["rnd"] = Math.random();
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("DragonBoatFriendInfos.ashx"),6,args);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingDrgnBoatFriendListFailure");
         loader.analyzer = new DrgnBoatFriendsAnalyzer(setupFriendList);
         LoadResourceManager.Instance.startLoad(loader);
      }
      
      public function setupFriendList(analyzer:DrgnBoatFriendsAnalyzer) : void
      {
         friendStateList = analyzer.list;
         dispatchEvent(new DrgnBoatBuildEvent("updateFriendList"));
      }
      
      override protected function start() : void
      {
         dispatchEvent(new DrgnBoatBuildEvent("drgnBoatOpenView"));
      }
   }
}
