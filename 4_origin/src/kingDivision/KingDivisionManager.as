package kingDivision
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.manager.TimeManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import hallIcon.HallIconManager;
   import kingDivision.analyze.AreaNameMessageAnalyze;
   import kingDivision.analyze.KingDivisionConsortionMessageAnalyze;
   import kingDivision.data.KingDivisionConsortionItemInfo;
   import kingDivision.loader.LoaderKingDivisionUIModule;
   import kingDivision.model.KingDivisionModel;
   import road7th.comm.PackageIn;
   
   public class KingDivisionManager extends EventDispatcher
   {
      
      private static var _instance:KingDivisionManager;
      
      public static const KINGDIVISION_OPENFRAME:String = "kingdivision_openframe";
      
      public static const MATCHAREARANKINFO:String = "matcharearankinfo";
      
      public static const SEARCHRESULT:String = "searchResult";
      
      public static const MATCHINFO:String = "matchinfo";
      
      public static const MATCHSCORE:String = "matchscore";
      
      public static const MATCHRANK:String = "matchrank";
      
      public static const MATCHAREARANK:String = "matcharearank";
       
      
      private var _model:KingDivisionModel;
      
      public var openFrame:Boolean;
      
      private var analyzerArr:Array;
      
      public var isThisZoneWin:Boolean;
      
      public var dataDic:Dictionary;
      
      public function KingDivisionManager(param1:PrivateClass)
      {
         super();
      }
      
      public static function get Instance() : KingDivisionManager
      {
         if(KingDivisionManager._instance == null)
         {
            KingDivisionManager._instance = new KingDivisionManager(new PrivateClass());
         }
         return KingDivisionManager._instance;
      }
      
      public function setup() : void
      {
         _model = new KingDivisionModel();
         SocketManager.Instance.addEventListener(PkgEvent.format(328,"activity_open"),__activityOpen);
         SocketManager.Instance.addEventListener(PkgEvent.format(328,"consortia_match_info"),__consortiaMatchInfo);
         SocketManager.Instance.addEventListener(PkgEvent.format(328,"consortiaMatchScore"),__consortiaMatchScore);
         SocketManager.Instance.addEventListener(PkgEvent.format(328,"consortiaMatchRank"),__consortiaMatchRank);
         SocketManager.Instance.addEventListener(PkgEvent.format(328,"consortiaMatchAreaRank"),__consortiaMatchAreaRank);
         SocketManager.Instance.addEventListener(PkgEvent.format(328,"consortiaMatchAreaRankInfo"),__consortiaMatchAreaRankInfo);
      }
      
      private function __activityOpen(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         _model.isOpen = _loc2_.readBoolean();
         _model.states = _loc2_.readByte();
         _model.level = _loc2_.readInt();
         _model.dateArr = ServerConfigManager.instance.localConsortiaMatchDays;
         _model.allDateArr = ServerConfigManager.instance.areaConsortiaMatchDays;
         _model.consortiaMatchStartTime = ServerConfigManager.instance.consortiaMatchStartTime;
         _model.consortiaMatchEndTime = ServerConfigManager.instance.consortiaMatchEndTime;
         updateConsotionMessage();
         kingDivisionIcon(_model.isOpen);
      }
      
      public function updateConsotionMessage() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         if(_model.states == 1)
         {
            _loc1_ = TimeManager.Instance.Now();
            if(_model.dateArr[0] == _loc1_.date)
            {
               GameInSocketOut.sendGetConsortionMessageThisZone();
            }
            else
            {
               GameInSocketOut.sendGetEliminateConsortionMessageThisZone();
            }
         }
         if(_model.states == 2)
         {
            loaderConsortionMessage();
            loaderAreaNameMessage();
            _loc2_ = TimeManager.Instance.Now();
            if(_model.allDateArr[0] == _loc2_.date)
            {
               GameInSocketOut.sendGetConsortionMessageAllZone();
            }
            else
            {
               GameInSocketOut.sendGetEliminateConsortionMessageAllZone();
            }
         }
      }
      
      public function loaderConsortionMessage() : void
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ConsortiaMatchHistory.ashx"),6);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("tank.auctionHouse.controller.AuctionHouseListError");
         _loc1_.analyzer = new KingDivisionConsortionMessageAnalyze(__searchResult);
         LoadResourceManager.Instance.startLoad(_loc1_);
      }
      
      public function loaderAreaNameMessage() : void
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.getAreaNameInfoPath(),2);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("tank.auctionHouse.controller.KingDivisionAreaNameError");
         _loc1_.analyzer = new AreaNameMessageAnalyze(loadAreaNameDataComplete);
         LoadResourceManager.Instance.startLoad(_loc1_);
      }
      
      private function loadAreaNameDataComplete(param1:AreaNameMessageAnalyze) : void
      {
         dataDic = param1.kingDivisionAreaNameDataDic;
      }
      
      private function __onLoadError(param1:LoaderEvent) : void
      {
         var _loc3_:String = param1.loader.loadErrorMessage;
         if(param1.loader.analyzer)
         {
            _loc3_ = param1.loader.loadErrorMessage + "\n" + param1.loader.analyzer.message;
         }
         var _loc2_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("alert"),param1.loader.loadErrorMessage,LanguageMgr.GetTranslation("tank.view.bagII.baglocked.sure"));
         _loc2_.addEventListener("response",__onAlertResponse);
      }
      
      private function __onAlertResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         param1.currentTarget.removeEventListener("response",__onAlertResponse);
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      private function __searchResult(param1:KingDivisionConsortionMessageAnalyze) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         isThisZoneWin = true;
         analyzerArr = param1._list;
         if(_model.eliminateInfo != null)
         {
            ObjectUtils.disposeObject(_model.eliminateInfo);
            _model.eliminateInfo = null;
         }
         _model.eliminateInfo = new Vector.<KingDivisionConsortionItemInfo>();
         if(analyzerArr == null || analyzerArr.length < 1)
         {
            return;
         }
         _loc3_ = 0;
         while(_loc3_ < analyzerArr.length)
         {
            _loc2_ = new KingDivisionConsortionItemInfo();
            _loc2_.conID = analyzerArr[_loc3_].ConsortiaID;
            _loc2_.conName = analyzerArr[_loc3_].ConsortiaName;
            _loc2_.score = analyzerArr[_loc3_].Score;
            _loc2_.conState = analyzerArr[_loc3_].State;
            _loc2_.conStyle = analyzerArr[_loc3_].Style;
            _loc2_.conSex = analyzerArr[_loc3_].Sex;
            _model.eliminateInfo.push(_loc2_);
            _loc3_++;
         }
         dispatchEvent(new Event("searchResult"));
      }
      
      private function __consortiaMatchInfo(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         _model.gameNum = _loc2_.readInt();
         _model.points = _loc2_.readInt();
         dispatchEvent(new Event("matchinfo"));
      }
      
      private function __consortiaMatchScore(param1:PkgEvent) : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = null;
         var _loc3_:PackageIn = param1.pkg;
         var _loc4_:int = _loc3_.readByte();
         var _loc2_:int = _loc3_.readByte();
         _model.conLen = _loc3_.readInt();
         if(_model.conItemInfo != null)
         {
            ObjectUtils.disposeObject(_model.conItemInfo);
            _model.eliminateInfo = null;
         }
         _model.conItemInfo = new Vector.<KingDivisionConsortionItemInfo>();
         if(_model.conLen < 1)
         {
            return;
         }
         _loc6_ = 0;
         while(_loc6_ < _model.conLen)
         {
            _loc5_ = new KingDivisionConsortionItemInfo();
            _loc5_.rang = _loc3_.readInt();
            _loc5_.consortionName = _loc3_.readUTF();
            _loc5_.consortionLevel = _loc3_.readInt();
            _loc5_.num = _loc3_.readInt();
            _loc5_.points = _loc3_.readInt();
            _model.conItemInfo.push(_loc5_);
            _loc6_++;
         }
         dispatchEvent(new Event("matchscore"));
      }
      
      private function __consortiaMatchRank(param1:PkgEvent) : void
      {
         var _loc7_:int = 0;
         var _loc6_:* = null;
         var _loc4_:PackageIn = param1.pkg;
         var _loc5_:int = _loc4_.readByte();
         var _loc2_:int = _loc4_.readByte();
         if(_model.eliminateInfo != null)
         {
            ObjectUtils.disposeObject(_model.eliminateInfo);
            _model.eliminateInfo = null;
         }
         _model.eliminateInfo = new Vector.<KingDivisionConsortionItemInfo>();
         var _loc3_:int = _loc4_.readInt();
         if(_loc3_ < 1)
         {
            return;
         }
         _loc7_ = 0;
         while(_loc7_ < _loc3_)
         {
            _loc6_ = new KingDivisionConsortionItemInfo();
            _loc6_.conID = _loc4_.readInt();
            _loc6_.conName = _loc4_.readUTF();
            _loc6_.name = _loc4_.readUTF();
            _loc6_.score = _loc4_.readInt();
            _loc6_.conState = _loc4_.readByte();
            _loc6_.isGame = _loc4_.readBoolean();
            _model.eliminateInfo.push(_loc6_);
            _loc7_++;
         }
         dispatchEvent(new Event("matchrank"));
      }
      
      private function __consortiaMatchAreaRank(param1:PkgEvent) : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = null;
         var _loc3_:PackageIn = param1.pkg;
         var _loc4_:int = _loc3_.readByte();
         var _loc2_:int = _loc3_.readByte();
         _model.conLen = _loc3_.readInt();
         if(_model.conItemInfo != null)
         {
            ObjectUtils.disposeObject(_model.conItemInfo);
            _model.conItemInfo = null;
         }
         _model.conItemInfo = new Vector.<KingDivisionConsortionItemInfo>();
         if(_model.conLen < 1)
         {
            return;
         }
         _loc6_ = 0;
         while(_loc6_ < _model.conLen)
         {
            _loc5_ = new KingDivisionConsortionItemInfo();
            _loc5_.consortionIDArea = _loc3_.readInt();
            _loc5_.areaID = _loc3_.readInt();
            _loc5_.consortionLevel = _loc3_.readInt();
            _loc5_.num = _loc3_.readInt();
            _loc5_.consortionName = _loc3_.readUTF();
            _loc5_.points = _loc3_.readInt();
            _model.conItemInfo.push(_loc5_);
            _loc6_++;
         }
         dispatchEvent(new Event("matcharearank"));
      }
      
      private function __consortiaMatchAreaRankInfo(param1:PkgEvent) : void
      {
         var _loc7_:int = 0;
         var _loc6_:* = null;
         var _loc4_:PackageIn = param1.pkg;
         var _loc5_:int = _loc4_.readByte();
         var _loc2_:int = _loc4_.readByte();
         if(_model.eliminateAllZoneInfo != null)
         {
            ObjectUtils.disposeObject(_model.eliminateAllZoneInfo);
            _model.eliminateAllZoneInfo = null;
         }
         _model.eliminateAllZoneInfo = new Vector.<KingDivisionConsortionItemInfo>();
         var _loc3_:int = _loc4_.readInt();
         if(_loc3_ < 1)
         {
            return;
         }
         _loc7_ = 0;
         while(_loc7_ < _loc3_)
         {
            _loc6_ = new KingDivisionConsortionItemInfo();
            _loc6_.consortionIDArea = _loc4_.readInt();
            _loc6_.areaID = _loc4_.readInt();
            _loc6_.consortionStyle = _loc4_.readUTF();
            _loc6_.consortionSex = _loc4_.readBoolean();
            _loc6_.consortionNameArea = _loc4_.readUTF();
            _loc6_.consortionState = _loc4_.readByte();
            _loc6_.consortionScoreArea = _loc4_.readInt();
            _loc6_.consortionIsGame = _loc4_.readBoolean();
            _model.eliminateAllZoneInfo.push(_loc6_);
            _loc7_++;
         }
         dispatchEvent(new Event("matcharearankinfo"));
      }
      
      public function templateDataSetup(param1:Array) : void
      {
         _model.goods = param1;
      }
      
      public function get model() : KingDivisionModel
      {
         return _model;
      }
      
      public function kingDivisionIcon(param1:Boolean) : void
      {
         HallIconManager.instance.updateSwitchHandler("kingDivision",param1);
      }
      
      public function onClickIcon() : void
      {
         if(StateManager.currentStateType == "main" && _model.isOpen)
         {
            LoaderKingDivisionUIModule.Instance.loadUIModule(doOpenKingDivisionFrame);
         }
      }
      
      private function doOpenKingDivisionFrame() : void
      {
         dispatchEvent(new Event("kingdivision_openframe"));
      }
      
      public function returnComponent(param1:Bitmap, param2:String) : Component
      {
         var _loc3_:Component = new Component();
         _loc3_.tipData = param2;
         _loc3_.tipDirctions = "0,1,2";
         _loc3_.tipStyle = "ddt.view.tips.OneLineTip";
         _loc3_.tipGapH = 20;
         _loc3_.width = param1.width;
         _loc3_.x = param1.x;
         _loc3_.y = param1.y;
         param1.x = 0;
         param1.y = 0;
         _loc3_.addChild(param1);
         return _loc3_;
      }
      
      public function checkCanStartGame() : Boolean
      {
         var _loc1_:Boolean = true;
         if(PlayerManager.Instance.Self.Bag.getItemAt(6) == null)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.room.RoomIIController.weapon"));
            _loc1_ = false;
         }
         return _loc1_;
      }
      
      public function checkGameTimeIsOpen() : Boolean
      {
         var _loc3_:Date = TimeManager.Instance.Now();
         var _loc2_:int = _loc3_.hours;
         var _loc1_:int = _loc3_.minutes;
         if(_loc2_ > int(_model.consortiaMatchEndTime[0]) || _loc2_ < int(_model.consortiaMatchStartTime[0]))
         {
            return false;
         }
         if(_loc2_ <= int(_model.consortiaMatchEndTime[0]) && _loc2_ >= int(_model.consortiaMatchStartTime[0]))
         {
            if(_loc2_ == int(_model.consortiaMatchEndTime[0]))
            {
               if(_loc1_ >= int(_model.consortiaMatchEndTime[1]))
               {
                  return false;
               }
               return true;
            }
            if(_loc2_ == int(_model.consortiaMatchStartTime[0]))
            {
               if(_loc1_ <= int(_model.consortiaMatchStartTime[1]))
               {
                  return false;
               }
               return true;
            }
            if(_loc2_ < int(_model.consortiaMatchEndTime[0]) && _loc2_ > int(_model.consortiaMatchStartTime[0]))
            {
               return true;
            }
         }
         return false;
      }
      
      public function get isOpen() : Boolean
      {
         return _model == null?false:Boolean(_model.isOpen);
      }
      
      public function set zoneIndex(param1:int) : void
      {
         _model.zoneIndex = param1;
      }
      
      public function get zoneIndex() : int
      {
         return _model.zoneIndex;
      }
      
      public function get dateArr() : Array
      {
         return _model.dateArr;
      }
      
      public function set dateArr(param1:Array) : void
      {
         _model.dateArr = param1;
      }
      
      public function get allDateArr() : Array
      {
         return _model.allDateArr;
      }
      
      public function set allDateArr(param1:Array) : void
      {
         _model.allDateArr = param1;
      }
      
      public function get thisZoneNickName() : String
      {
         return _model.thisZoneNickName;
      }
      
      public function set thisZoneNickName(param1:String) : void
      {
         _model.thisZoneNickName = param1;
      }
      
      public function get allZoneNickName() : String
      {
         return _model.allZoneNickName;
      }
      
      public function set allZoneNickName(param1:String) : void
      {
         _model.allZoneNickName = param1;
      }
      
      public function get points() : int
      {
         return _model.points;
      }
      
      public function set points(param1:int) : void
      {
         _model.points = param1;
      }
      
      public function get gameNum() : int
      {
         return _model.gameNum;
      }
      
      public function set gameNum(param1:int) : void
      {
         _model.gameNum = param1;
      }
      
      public function get states() : int
      {
         return _model.states;
      }
      
      public function set states(param1:int) : void
      {
         _model.states = param1;
      }
      
      public function get level() : int
      {
         return _model.level;
      }
      
      public function set level(param1:int) : void
      {
         _model.level = param1;
      }
   }
}

class PrivateClass
{
    
   
   function PrivateClass()
   {
      super();
   }
}
