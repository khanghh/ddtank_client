package dragonBoat
{
   import com.pickgliss.ui.controls.BaseButton;
   import ddt.CoreManager;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.PkgEvent;
   import ddt.loader.StartupResourceLoader;
   import ddt.manager.ChatManager;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import dragonBoat.analyzer.DragonBoatActiveDataAnalyzer;
   import dragonBoat.data.DragonBoatActiveInfo;
   import dragonBoat.data.DragonBoatAwardInfo;
   import dragonBoat.event.DragonBoatEvent;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import hall.player.HallPlayerView;
   import road7th.StarlingMain;
   import road7th.comm.PackageIn;
   import starling.scene.hall.HallScene;
   import starling.scene.hall.StaticLayer;
   
   public class DragonBoatManager extends CoreManager
   {
      
      public static const END_UPDATE:String = "DragonBoatEndUpdate";
      
      public static const BOAT_RES_LOAD_COMPLETE:String = "DragonBoatBoatResLoadComplete";
      
      public static const BUILD_OR_DECORATE_UPDATE:String = "DragonBoatBuildOrDecorateUpdate";
      
      public static const REFRESH_BOAT_STATUS:String = "DragonBoatRefreshBoatStatus";
      
      public static const UPDATE_RANK_INFO:String = "DragBoatUpdateRankInfo";
      
      public static const DRAGONBOAT_CHIP:int = 11690;
      
      public static const KINGSTATUE_CHIP:int = 11771;
      
      public static const LINSHI_CHIP:int = 201309;
      
      private static var _instance:DragonBoatManager;
       
      
      private var _activeInfo:DragonBoatActiveInfo;
      
      private var _boatExpList:Array;
      
      private var _awardsListSelf:Array;
      
      private var _awardsListOther:Array;
      
      private var _awardsInfoSelf:Object;
      
      private var _awardsInfoOther:Object;
      
      private var _boatCompleteExp:int;
      
      private var _useableScore:int;
      
      private var _totalScore:int;
      
      private var _periodType:int = 0;
      
      private var _isLoadBoatResComplete:Boolean;
      
      private var _isHadOpenedFrame:Boolean;
      
      private var _playerView:HallPlayerView;
      
      private var _btn:BaseButton;
      
      public var type:int;
      
      private var isShowed:Boolean;
      
      public function DragonBoatManager(param1:IEventDispatcher = null)
      {
         _boatExpList = [];
         _awardsListSelf = [];
         _awardsListOther = [];
         _awardsInfoSelf = {};
         _awardsInfoOther = {};
         super(param1);
      }
      
      public static function get instance() : DragonBoatManager
      {
         if(_instance == null)
         {
            _instance = new DragonBoatManager();
         }
         return _instance;
      }
      
      public function get activeInfo() : DragonBoatActiveInfo
      {
         return _activeInfo;
      }
      
      public function get boatCompleteStatus() : int
      {
         var _loc1_:int = _boatCompleteExp * 100 / _boatExpList[_boatExpList.length - 1];
         return _loc1_ > 100?100:_loc1_;
      }
      
      public function get boatInWhatStatus() : int
      {
         var _loc3_:int = 0;
         var _loc1_:int = _boatExpList.length;
         var _loc2_:int = 1;
         _loc3_ = _loc1_ - 1;
         while(_loc3_ >= 0)
         {
            if(_boatCompleteExp >= _boatExpList[_loc3_])
            {
               _loc2_ = _loc3_ + 1;
               break;
            }
            _loc3_--;
         }
         return _loc2_;
      }
      
      public function get useableScore() : int
      {
         return _useableScore;
      }
      
      public function get totalScore() : int
      {
         return _totalScore;
      }
      
      public function get isStart() : Boolean
      {
         return _periodType == 1 || _periodType == 2;
      }
      
      public function get isCanBuildOrDecorate() : Boolean
      {
         return _periodType == 1;
      }
      
      public function get isLoadBoatResComplete() : Boolean
      {
         return _isLoadBoatResComplete;
      }
      
      public function templateDataSetup(param1:DragonBoatActiveDataAnalyzer) : void
      {
         _activeInfo = param1.data;
         _boatExpList = param1.dataList;
         _awardsListSelf = param1.dataListSelf;
         _awardsListOther = param1.dataListOther;
      }
      
      public function getAwardInfoByRank(param1:int, param2:int) : Array
      {
         var _loc5_:Array = [];
         var _loc4_:InventoryItemInfo = new InventoryItemInfo();
         if(param1 == 1)
         {
            if(_awardsInfoSelf[param2])
            {
               return _awardsInfoSelf[param2] as Array;
            }
            var _loc8_:int = 0;
            var _loc7_:* = _awardsListSelf;
            for each(var _loc3_ in _awardsListSelf)
            {
               if(_loc3_.RandID == param2)
               {
                  _loc5_.push(createInventoryItemInfo(_loc3_));
               }
            }
            _awardsInfoSelf[param2] = _loc5_;
         }
         else
         {
            if(_awardsInfoOther[param2])
            {
               return _awardsInfoOther[param2] as Array;
            }
            var _loc10_:int = 0;
            var _loc9_:* = _awardsListOther;
            for each(var _loc6_ in _awardsListOther)
            {
               if(_loc6_.RandID == param2)
               {
                  _loc5_.push(createInventoryItemInfo(_loc6_));
               }
            }
            _awardsInfoOther[param2] = _loc5_;
         }
         _loc5_.sortOn("TemplateID",16);
         return _loc5_;
      }
      
      private function createInventoryItemInfo(param1:DragonBoatAwardInfo) : InventoryItemInfo
      {
         var _loc2_:InventoryItemInfo = new InventoryItemInfo();
         _loc2_.TemplateID = param1.TemplateID;
         ItemManager.fill(_loc2_);
         _loc2_.StrengthenLevel = param1.StrengthenLevel;
         _loc2_.AttackCompose = param1.AttackCompose;
         _loc2_.DefendCompose = param1.DefendCompose;
         _loc2_.LuckCompose = param1.LuckCompose;
         _loc2_.AgilityCompose = param1.AgilityCompose;
         _loc2_.IsBinds = param1.IsBind;
         _loc2_.ValidDate = param1.ValidDate;
         _loc2_.Count = param1.Count;
         return _loc2_;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(100),pkgHandler);
      }
      
      public function setPlayerView(param1:HallPlayerView, param2:BaseButton) : void
      {
         _playerView = param1;
         _btn = param2;
         _btn.visible = false;
         if(isStart)
         {
            addToHall();
            showChat();
         }
         else
         {
            removeFromHall();
         }
      }
      
      public function updateNPCStatus() : void
      {
         var _loc1_:* = null;
         var _loc2_:HallScene = StarlingMain.instance.currentScene as HallScene;
         if(_loc2_)
         {
            _loc1_ = _loc2_.playerView.staticLayer;
            _loc1_.changeBuildNpcBtnAni("laurel","stand6");
         }
      }
      
      public function addToHall() : void
      {
         var _loc1_:* = null;
         if(!_playerView || !_btn || type == 7)
         {
            return;
         }
         _btn.visible = true;
         var _loc2_:HallScene = StarlingMain.instance.currentScene as HallScene;
         if(_loc2_)
         {
            _loc1_ = _loc2_.playerView.staticLayer;
            _loc1_.createNpc("laurel");
            _loc1_.changeBuildNpcBtnAni("laurel","stand6");
         }
      }
      
      public function removeFromHall() : void
      {
         var _loc1_:* = null;
         if(_btn)
         {
            _btn.visible = false;
         }
         var _loc2_:HallScene = StarlingMain.instance.currentScene as HallScene;
         if(_loc2_)
         {
            _loc1_ = _loc2_.playerView.staticLayer;
            _loc1_.removeBuildNpcBtn("laurel");
         }
      }
      
      private function pkgHandler(param1:PkgEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:int = _loc3_.readByte();
         var _loc4_:* = _loc2_;
         if(1 !== _loc4_)
         {
            if(2 !== _loc4_)
            {
               if(3 !== _loc4_)
               {
                  if(16 !== _loc4_)
                  {
                     if(17 !== _loc4_)
                     {
                        if(127 === _loc4_)
                        {
                           StartupResourceLoader.Instance.reloadGodSyah(_loc3_);
                           trace("重新加载赛亚之神 临时属性");
                        }
                     }
                     else
                     {
                        updateOtherRank(_loc3_);
                     }
                  }
                  else
                  {
                     updateSelfRank(_loc3_);
                  }
               }
               else
               {
                  refreshBoatStatus(_loc3_);
               }
            }
            else
            {
               buildOrDecorate(_loc3_);
            }
         }
         else
         {
            openOrClose(_loc3_);
         }
      }
      
      private function updateSelfRank(param1:PackageIn) : void
      {
         var _loc8_:int = 0;
         var _loc6_:* = null;
         var _loc4_:int = param1.readInt();
         var _loc3_:Array = [];
         _loc8_ = 0;
         while(_loc8_ < _loc4_)
         {
            _loc6_ = {};
            _loc6_.rank = param1.readInt();
            _loc6_.score = param1.readInt();
            _loc6_.name = param1.readUTF();
            _loc6_.itemInfoArr = getAwardInfoByRank(1,_loc6_.rank);
            _loc3_.push(_loc6_);
            _loc8_++;
         }
         var _loc5_:int = param1.readInt();
         var _loc2_:int = param1.readInt();
         var _loc7_:DragonBoatEvent = new DragonBoatEvent("DragBoatUpdateRankInfo");
         _loc7_.tag = 1;
         _loc7_.data = {
            "dataList":_loc3_,
            "myRank":_loc5_,
            "lessScore":_loc2_
         };
         dispatchEvent(_loc7_);
      }
      
      private function updateOtherRank(param1:PackageIn) : void
      {
         var _loc8_:int = 0;
         var _loc6_:* = null;
         var _loc4_:int = param1.readInt();
         var _loc3_:Array = [];
         _loc8_ = 0;
         while(_loc8_ < _loc4_)
         {
            _loc6_ = {};
            _loc6_.rank = param1.readInt();
            _loc6_.score = param1.readInt();
            _loc6_.name = param1.readUTF();
            _loc6_.zone = param1.readUTF();
            _loc6_.itemInfoArr = getAwardInfoByRank(2,_loc6_.rank);
            _loc3_.push(_loc6_);
            _loc8_++;
         }
         var _loc5_:int = param1.readInt();
         var _loc2_:int = param1.readInt();
         var _loc7_:DragonBoatEvent = new DragonBoatEvent("DragBoatUpdateRankInfo");
         _loc7_.tag = 2;
         _loc7_.data = {
            "dataList":_loc3_,
            "myRank":_loc5_,
            "lessScore":_loc2_
         };
         dispatchEvent(_loc7_);
      }
      
      private function openOrClose(param1:PackageIn) : void
      {
         type = param1.readInt();
         _periodType = param1.readInt();
         if(isStart)
         {
            _boatCompleteExp = param1.readInt();
            addToHall();
            showChat();
         }
         else
         {
            removeFromHall();
         }
      }
      
      private function showChat() : void
      {
         if(isShowed)
         {
            return;
         }
         isShowed = true;
         if(type == 7)
         {
            if(_periodType == 1)
            {
               ChatManager.Instance.sysChatAmaranth(LanguageMgr.GetTranslation("floatParade.open"));
            }
            return;
         }
         if(type == 4)
         {
            ChatManager.Instance.sysChatAmaranth(LanguageMgr.GetTranslation("kingStatue.open"));
         }
         else if(type == 8)
         {
            ChatManager.Instance.sysChatAmaranth(LanguageMgr.GetTranslation("ddtking.open"));
         }
         else
         {
            ChatManager.Instance.sysChatAmaranth(LanguageMgr.GetTranslation("laurel.open"));
         }
      }
      
      public function setOpenFrameParam() : void
      {
         _isHadOpenedFrame = true;
         if(!SharedManager.Instance.isDragonBoatOpenFrame)
         {
            SharedManager.Instance.isDragonBoatOpenFrame = true;
            SharedManager.Instance.save();
         }
      }
      
      private function buildOrDecorate(param1:PackageIn) : void
      {
         _useableScore = param1.readInt();
         _totalScore = param1.readInt();
         dispatchEvent(new Event("DragonBoatBuildOrDecorateUpdate"));
         updateNPCStatus();
      }
      
      private function refreshBoatStatus(param1:PackageIn) : void
      {
         _boatCompleteExp = param1.readInt();
         dispatchEvent(new Event("DragonBoatRefreshBoatStatus"));
         updateNPCStatus();
      }
      
      public function get isBuildEnd() : Boolean
      {
         if(_boatCompleteExp > 0 && periodType == 2)
         {
            return true;
         }
         return false;
      }
      
      public function get periodType() : int
      {
         return _periodType;
      }
      
      override protected function start() : void
      {
         dispatchEvent(new DragonBoatEvent("dragonOpenView"));
      }
   }
}
