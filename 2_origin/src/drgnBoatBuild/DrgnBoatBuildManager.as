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
      
      public function setup(param1:HallPlayerView, param2:BaseButton) : void
      {
         _playerView = param1;
         _btn = param2;
         _btn.visible = false;
      }
      
      public function addToHall() : void
      {
         var _loc1_:* = null;
         _btn.visible = true;
         var _loc2_:HallScene = StarlingMain.instance.currentScene as HallScene;
         if(_loc2_)
         {
            _loc1_ = _loc2_.playerView.staticLayer;
            _loc1_.createNpc("drgnBoatBuilding");
            _loc1_.changeBuildNpcBtnAni("drgnBoatBuilding","stand" + 6.toString());
         }
      }
      
      public function removeFromHall() : void
      {
         var _loc1_:* = null;
         _btn.visible = false;
         var _loc2_:HallScene = StarlingMain.instance.currentScene as HallScene;
         if(_loc2_)
         {
            _loc1_ = _loc2_.playerView.staticLayer;
            _loc1_.removeBuildNpcBtn("drgnBoatBuilding");
         }
      }
      
      public function initBuildingStatus(param1:PackageIn) : void
      {
         var _loc2_:* = null;
         buildingStage = param1.readInt();
         progress = param1.readInt();
         var _loc3_:HallScene = StarlingMain.instance.currentScene as HallScene;
         if(_loc3_)
         {
            _loc2_ = _loc3_.playerView.staticLayer;
            _loc2_.changeBuildNpcBtnAni("drgnBoatBuilding","stand" + 6.toString());
         }
      }
      
      public function updateBuildInfo(param1:PackageIn) : void
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc5_:DrgnBoatBuildCellInfo = new DrgnBoatBuildCellInfo();
         _loc5_.id = param1.readInt();
         _loc5_.stage = param1.readInt();
         _loc5_.progress = param1.readInt();
         if(_loc5_.id == PlayerManager.Instance.Self.ID)
         {
            buildingStage = _loc5_.stage;
            progress = _loc5_.progress;
            _loc4_ = StarlingMain.instance.currentScene as HallScene;
            if(_loc4_)
            {
               _loc3_ = _loc4_.playerView.staticLayer;
               _loc3_.changeBuildNpcBtnAni("drgnBoatBuilding","stand" + 6.toString());
            }
         }
         var _loc2_:DrgnBoatBuildEvent = new DrgnBoatBuildEvent("updateView");
         _loc2_.info = _loc5_;
         dispatchEvent(_loc2_);
      }
      
      public function receiveCommitResult(param1:PackageIn) : void
      {
         isMcPlay = param1.readBoolean();
         if(isMcPlay)
         {
            SocketManager.Instance.out.updateDrgnBoatBuildInfo();
         }
      }
      
      public function receiveHelpToBuild(param1:PackageIn) : void
      {
         var _loc3_:Boolean = param1.readBoolean();
         var _loc2_:int = param1.readInt();
         if(_loc3_)
         {
            SocketManager.Instance.out.updateDrgnBoatBuildInfo(_loc2_);
         }
      }
      
      public function updateDrgnBoatFriendList() : void
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_["selfid"] = PlayerManager.Instance.Self.ID;
         _loc2_["key"] = MD5.hash(PlayerManager.Instance.Account.Password);
         _loc2_["rnd"] = Math.random();
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("DragonBoatFriendInfos.ashx"),6,_loc2_);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingDrgnBoatFriendListFailure");
         _loc1_.analyzer = new DrgnBoatFriendsAnalyzer(setupFriendList);
         LoadResourceManager.Instance.startLoad(_loc1_);
      }
      
      public function setupFriendList(param1:DrgnBoatFriendsAnalyzer) : void
      {
         friendStateList = param1.list;
         dispatchEvent(new DrgnBoatBuildEvent("updateFriendList"));
      }
      
      override protected function start() : void
      {
         dispatchEvent(new DrgnBoatBuildEvent("drgnBoatOpenView"));
      }
   }
}
