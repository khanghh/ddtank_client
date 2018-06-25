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
      
      public var tmpStartTime:Date;
      
      public var tmpEndTime:Date;
      
      public var type:int;
      
      private var isShowed:Boolean;
      
      public function DragonBoatManager(target:IEventDispatcher = null)
      {
         _boatExpList = [];
         _awardsListSelf = [];
         _awardsListOther = [];
         _awardsInfoSelf = {};
         _awardsInfoOther = {};
         super(target);
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
         var tmp:int = _boatCompleteExp * 100 / _boatExpList[_boatExpList.length - 1];
         return tmp > 100?100:tmp;
      }
      
      public function get boatInWhatStatus() : int
      {
         var i:int = 0;
         var tmpLen:int = _boatExpList.length;
         var tmpIndex:int = 1;
         for(i = tmpLen - 1; i >= 0; )
         {
            if(_boatCompleteExp >= _boatExpList[i])
            {
               tmpIndex = i + 1;
               break;
            }
            i--;
         }
         return tmpIndex;
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
      
      public function templateDataSetup(analyzer:DragonBoatActiveDataAnalyzer) : void
      {
         _activeInfo = analyzer.data;
         _boatExpList = analyzer.dataList;
         _awardsListSelf = analyzer.dataListSelf;
         _awardsListOther = analyzer.dataListOther;
      }
      
      public function getAwardInfoByRank(type:int, rank:int) : Array
      {
         var itemInfoArr:Array = [];
         var itemInfo:InventoryItemInfo = new InventoryItemInfo();
         if(type == 1)
         {
            if(_awardsInfoSelf[rank])
            {
               return _awardsInfoSelf[rank] as Array;
            }
            var _loc8_:int = 0;
            var _loc7_:* = _awardsListSelf;
            for each(var _awardsInfo in _awardsListSelf)
            {
               if(_awardsInfo.RandID == rank)
               {
                  itemInfoArr.push(createInventoryItemInfo(_awardsInfo));
               }
            }
            _awardsInfoSelf[rank] = itemInfoArr;
         }
         else
         {
            if(_awardsInfoOther[rank])
            {
               return _awardsInfoOther[rank] as Array;
            }
            var _loc10_:int = 0;
            var _loc9_:* = _awardsListOther;
            for each(var _awardsInfo2 in _awardsListOther)
            {
               if(_awardsInfo2.RandID == rank)
               {
                  itemInfoArr.push(createInventoryItemInfo(_awardsInfo2));
               }
            }
            _awardsInfoOther[rank] = itemInfoArr;
         }
         itemInfoArr.sortOn("TemplateID",16);
         return itemInfoArr;
      }
      
      private function createInventoryItemInfo(tmpData:DragonBoatAwardInfo) : InventoryItemInfo
      {
         var itemInfo:InventoryItemInfo = new InventoryItemInfo();
         itemInfo.TemplateID = tmpData.TemplateID;
         ItemManager.fill(itemInfo);
         itemInfo.StrengthenLevel = tmpData.StrengthenLevel;
         itemInfo.AttackCompose = tmpData.AttackCompose;
         itemInfo.DefendCompose = tmpData.DefendCompose;
         itemInfo.LuckCompose = tmpData.LuckCompose;
         itemInfo.AgilityCompose = tmpData.AgilityCompose;
         itemInfo.IsBinds = tmpData.IsBind;
         itemInfo.ValidDate = tmpData.ValidDate;
         itemInfo.Count = tmpData.Count;
         return itemInfo;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(100),pkgHandler);
      }
      
      public function setPlayerView(view:HallPlayerView, btn:BaseButton) : void
      {
         _playerView = view;
         _btn = btn;
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
         var staticLayr:* = null;
         var currentScene:HallScene = StarlingMain.instance.currentScene as HallScene;
         if(currentScene)
         {
            staticLayr = currentScene.playerView.staticLayer;
            staticLayr.changeBuildNpcBtnAni("laurel","stand6");
         }
      }
      
      public function addToHall() : void
      {
         var staticLayr:* = null;
         if(!_playerView || !_btn || type == 7)
         {
            return;
         }
         _btn.visible = true;
         var currentScene:HallScene = StarlingMain.instance.currentScene as HallScene;
         if(currentScene)
         {
            staticLayr = currentScene.playerView.staticLayer;
            staticLayr.createNpc("laurel");
            staticLayr.changeBuildNpcBtnAni("laurel","stand6");
         }
      }
      
      public function removeFromHall() : void
      {
         var staticLayr:* = null;
         if(_btn)
         {
            _btn.visible = false;
         }
         var currentScene:HallScene = StarlingMain.instance.currentScene as HallScene;
         if(currentScene)
         {
            staticLayr = currentScene.playerView.staticLayer;
            staticLayr.removeBuildNpcBtn("laurel");
         }
      }
      
      private function pkgHandler(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var cmd:int = pkg.readByte();
         var _loc4_:* = cmd;
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
                           StartupResourceLoader.Instance.reloadGodSyah(pkg);
                           trace("重新加载赛亚之神 临时属性");
                        }
                     }
                     else
                     {
                        updateOtherRank(pkg);
                     }
                  }
                  else
                  {
                     updateSelfRank(pkg);
                  }
               }
               else
               {
                  refreshBoatStatus(pkg);
               }
            }
            else
            {
               buildOrDecorate(pkg);
            }
         }
         else
         {
            openOrClose(pkg);
         }
      }
      
      private function updateSelfRank(pkg:PackageIn) : void
      {
         var i:int = 0;
         var obj:* = null;
         var count:int = pkg.readInt();
         var dataList:Array = [];
         for(i = 0; i < count; )
         {
            obj = {};
            obj.rank = pkg.readInt();
            obj.score = pkg.readInt();
            obj.name = pkg.readUTF();
            obj.itemInfoArr = getAwardInfoByRank(1,obj.rank);
            dataList.push(obj);
            i++;
         }
         var myRank:int = pkg.readInt();
         var lessScore:int = pkg.readInt();
         var newEvent:DragonBoatEvent = new DragonBoatEvent("DragBoatUpdateRankInfo");
         newEvent.tag = 1;
         newEvent.data = {
            "dataList":dataList,
            "myRank":myRank,
            "lessScore":lessScore
         };
         dispatchEvent(newEvent);
      }
      
      private function updateOtherRank(pkg:PackageIn) : void
      {
         var i:int = 0;
         var obj:* = null;
         var count:int = pkg.readInt();
         var dataList:Array = [];
         for(i = 0; i < count; )
         {
            obj = {};
            obj.rank = pkg.readInt();
            obj.score = pkg.readInt();
            obj.name = pkg.readUTF();
            obj.zone = pkg.readUTF();
            obj.itemInfoArr = getAwardInfoByRank(2,obj.rank);
            dataList.push(obj);
            i++;
         }
         var myRank:int = pkg.readInt();
         var lessScore:int = pkg.readInt();
         var newEvent:DragonBoatEvent = new DragonBoatEvent("DragBoatUpdateRankInfo");
         newEvent.tag = 2;
         newEvent.data = {
            "dataList":dataList,
            "myRank":myRank,
            "lessScore":lessScore
         };
         dispatchEvent(newEvent);
      }
      
      private function openOrClose(pkg:PackageIn) : void
      {
         type = pkg.readInt();
         _periodType = pkg.readInt();
         if(isStart)
         {
            _boatCompleteExp = pkg.readInt();
            tmpStartTime = pkg.readDate();
            tmpEndTime = pkg.readDate();
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
      
      private function buildOrDecorate(pkg:PackageIn) : void
      {
         _useableScore = pkg.readInt();
         _totalScore = pkg.readInt();
         dispatchEvent(new Event("DragonBoatBuildOrDecorateUpdate"));
         updateNPCStatus();
      }
      
      private function refreshBoatStatus(pkg:PackageIn) : void
      {
         _boatCompleteExp = pkg.readInt();
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
