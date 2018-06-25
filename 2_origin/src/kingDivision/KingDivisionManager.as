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
      
      public function KingDivisionManager(pct:PrivateClass)
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
      
      private function __activityOpen(evt:PkgEvent) : void
      {
         var pkg:PackageIn = evt.pkg;
         _model.isOpen = pkg.readBoolean();
         _model.states = pkg.readByte();
         _model.level = pkg.readInt();
         _model.dateArr = ServerConfigManager.instance.localConsortiaMatchDays;
         _model.allDateArr = ServerConfigManager.instance.areaConsortiaMatchDays;
         _model.consortiaMatchStartTime = ServerConfigManager.instance.consortiaMatchStartTime;
         _model.consortiaMatchEndTime = ServerConfigManager.instance.consortiaMatchEndTime;
         updateConsotionMessage();
         kingDivisionIcon(_model.isOpen);
      }
      
      public function updateConsotionMessage() : void
      {
         var dates:* = null;
         var datesArea:* = null;
         if(_model.states == 1)
         {
            dates = TimeManager.Instance.Now();
            if(_model.dateArr[0] == dates.date)
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
            datesArea = TimeManager.Instance.Now();
            if(_model.allDateArr[0] == datesArea.date)
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
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ConsortiaMatchHistory.ashx"),6);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("tank.auctionHouse.controller.AuctionHouseListError");
         loader.analyzer = new KingDivisionConsortionMessageAnalyze(__searchResult);
         LoadResourceManager.Instance.startLoad(loader);
      }
      
      public function loaderAreaNameMessage() : void
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.getAreaNameInfoPath(),2);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("tank.auctionHouse.controller.KingDivisionAreaNameError");
         loader.analyzer = new AreaNameMessageAnalyze(loadAreaNameDataComplete);
         LoadResourceManager.Instance.startLoad(loader);
      }
      
      private function loadAreaNameDataComplete(analyzer:AreaNameMessageAnalyze) : void
      {
         dataDic = analyzer.kingDivisionAreaNameDataDic;
      }
      
      private function __onLoadError(event:LoaderEvent) : void
      {
         var msg:String = event.loader.loadErrorMessage;
         if(event.loader.analyzer)
         {
            msg = event.loader.loadErrorMessage + "\n" + event.loader.analyzer.message;
         }
         var alert:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("alert"),event.loader.loadErrorMessage,LanguageMgr.GetTranslation("tank.view.bagII.baglocked.sure"));
         alert.addEventListener("response",__onAlertResponse);
      }
      
      private function __onAlertResponse(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         event.currentTarget.removeEventListener("response",__onAlertResponse);
         ObjectUtils.disposeObject(event.currentTarget);
      }
      
      private function __searchResult(analyzer:KingDivisionConsortionMessageAnalyze) : void
      {
         var i:int = 0;
         var conItem:* = null;
         isThisZoneWin = true;
         analyzerArr = analyzer._list;
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
         i = 0;
         while(i < analyzerArr.length)
         {
            conItem = new KingDivisionConsortionItemInfo();
            conItem.conID = analyzerArr[i].ConsortiaID;
            conItem.conName = analyzerArr[i].ConsortiaName;
            conItem.score = analyzerArr[i].Score;
            conItem.conState = analyzerArr[i].State;
            conItem.conStyle = analyzerArr[i].Style;
            conItem.conSex = analyzerArr[i].Sex;
            _model.eliminateInfo.push(conItem);
            i++;
         }
         dispatchEvent(new Event("searchResult"));
      }
      
      private function __consortiaMatchInfo(evt:PkgEvent) : void
      {
         var pkg:PackageIn = evt.pkg;
         _model.gameNum = pkg.readInt();
         _model.points = pkg.readInt();
         dispatchEvent(new Event("matchinfo"));
      }
      
      private function __consortiaMatchScore(evt:PkgEvent) : void
      {
         var i:int = 0;
         var conItem:* = null;
         var pkg:PackageIn = evt.pkg;
         var __stage:int = pkg.readByte();
         var rankStage:int = pkg.readByte();
         _model.conLen = pkg.readInt();
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
         i = 0;
         while(i < _model.conLen)
         {
            conItem = new KingDivisionConsortionItemInfo();
            conItem.rang = pkg.readInt();
            conItem.consortionName = pkg.readUTF();
            conItem.consortionLevel = pkg.readInt();
            conItem.num = pkg.readInt();
            conItem.points = pkg.readInt();
            _model.conItemInfo.push(conItem);
            i++;
         }
         dispatchEvent(new Event("matchscore"));
      }
      
      private function __consortiaMatchRank(evt:PkgEvent) : void
      {
         var i:int = 0;
         var conItem:* = null;
         var pkg:PackageIn = evt.pkg;
         var __stage:int = pkg.readByte();
         var rankStage:int = pkg.readByte();
         if(_model.eliminateInfo != null)
         {
            ObjectUtils.disposeObject(_model.eliminateInfo);
            _model.eliminateInfo = null;
         }
         _model.eliminateInfo = new Vector.<KingDivisionConsortionItemInfo>();
         var length:int = pkg.readInt();
         if(length < 1)
         {
            return;
         }
         i = 0;
         while(i < length)
         {
            conItem = new KingDivisionConsortionItemInfo();
            conItem.conID = pkg.readInt();
            conItem.conName = pkg.readUTF();
            conItem.name = pkg.readUTF();
            conItem.score = pkg.readInt();
            conItem.conState = pkg.readByte();
            conItem.isGame = pkg.readBoolean();
            _model.eliminateInfo.push(conItem);
            i++;
         }
         dispatchEvent(new Event("matchrank"));
      }
      
      private function __consortiaMatchAreaRank(evt:PkgEvent) : void
      {
         var i:int = 0;
         var conItem:* = null;
         var pkg:PackageIn = evt.pkg;
         var __stage:int = pkg.readByte();
         var rankStage:int = pkg.readByte();
         _model.conLen = pkg.readInt();
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
         i = 0;
         while(i < _model.conLen)
         {
            conItem = new KingDivisionConsortionItemInfo();
            conItem.consortionIDArea = pkg.readInt();
            conItem.areaID = pkg.readInt();
            conItem.consortionLevel = pkg.readInt();
            conItem.num = pkg.readInt();
            conItem.consortionName = pkg.readUTF();
            conItem.points = pkg.readInt();
            _model.conItemInfo.push(conItem);
            i++;
         }
         dispatchEvent(new Event("matcharearank"));
      }
      
      private function __consortiaMatchAreaRankInfo(evt:PkgEvent) : void
      {
         var i:int = 0;
         var conItem:* = null;
         var pkg:PackageIn = evt.pkg;
         var __stage:int = pkg.readByte();
         var rankStage:int = pkg.readByte();
         if(_model.eliminateAllZoneInfo != null)
         {
            ObjectUtils.disposeObject(_model.eliminateAllZoneInfo);
            _model.eliminateAllZoneInfo = null;
         }
         _model.eliminateAllZoneInfo = new Vector.<KingDivisionConsortionItemInfo>();
         var length:int = pkg.readInt();
         if(length < 1)
         {
            return;
         }
         i = 0;
         while(i < length)
         {
            conItem = new KingDivisionConsortionItemInfo();
            conItem.consortionIDArea = pkg.readInt();
            conItem.areaID = pkg.readInt();
            conItem.consortionStyle = pkg.readUTF();
            conItem.consortionSex = pkg.readBoolean();
            conItem.consortionNameArea = pkg.readUTF();
            conItem.consortionState = pkg.readByte();
            conItem.consortionScoreArea = pkg.readInt();
            conItem.consortionIsGame = pkg.readBoolean();
            _model.eliminateAllZoneInfo.push(conItem);
            i++;
         }
         dispatchEvent(new Event("matcharearankinfo"));
      }
      
      public function templateDataSetup(dataList:Array) : void
      {
         _model.goods = dataList;
      }
      
      public function get model() : KingDivisionModel
      {
         return _model;
      }
      
      public function kingDivisionIcon(flag:Boolean) : void
      {
         HallIconManager.instance.updateSwitchHandler("kingDivision",flag);
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
      
      public function returnComponent(cell:Bitmap, tipName:String) : Component
      {
         var compoent:Component = new Component();
         compoent.tipData = tipName;
         compoent.tipDirctions = "0,1,2";
         compoent.tipStyle = "ddt.view.tips.OneLineTip";
         compoent.tipGapH = 20;
         compoent.width = cell.width;
         compoent.x = cell.x;
         compoent.y = cell.y;
         cell.x = 0;
         cell.y = 0;
         compoent.addChild(cell);
         return compoent;
      }
      
      public function checkCanStartGame() : Boolean
      {
         var result:Boolean = true;
         if(PlayerManager.Instance.Self.Bag.getItemAt(6) == null)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.room.RoomIIController.weapon"));
            result = false;
         }
         return result;
      }
      
      public function checkGameTimeIsOpen() : Boolean
      {
         var date:Date = TimeManager.Instance.Now();
         var hour:int = date.hours;
         var minutes:int = date.minutes;
         if(hour > int(_model.consortiaMatchEndTime[0]) || hour < int(_model.consortiaMatchStartTime[0]))
         {
            return false;
         }
         if(hour <= int(_model.consortiaMatchEndTime[0]) && hour >= int(_model.consortiaMatchStartTime[0]))
         {
            if(hour == int(_model.consortiaMatchEndTime[0]))
            {
               if(minutes >= int(_model.consortiaMatchEndTime[1]))
               {
                  return false;
               }
               return true;
            }
            if(hour == int(_model.consortiaMatchStartTime[0]))
            {
               if(minutes <= int(_model.consortiaMatchStartTime[1]))
               {
                  return false;
               }
               return true;
            }
            if(hour < int(_model.consortiaMatchEndTime[0]) && hour > int(_model.consortiaMatchStartTime[0]))
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
      
      public function set zoneIndex(value:int) : void
      {
         _model.zoneIndex = value;
      }
      
      public function get zoneIndex() : int
      {
         return _model.zoneIndex;
      }
      
      public function get dateArr() : Array
      {
         return _model.dateArr;
      }
      
      public function set dateArr(value:Array) : void
      {
         _model.dateArr = value;
      }
      
      public function get allDateArr() : Array
      {
         return _model.allDateArr;
      }
      
      public function set allDateArr(value:Array) : void
      {
         _model.allDateArr = value;
      }
      
      public function get thisZoneNickName() : String
      {
         return _model.thisZoneNickName;
      }
      
      public function set thisZoneNickName(value:String) : void
      {
         _model.thisZoneNickName = value;
      }
      
      public function get allZoneNickName() : String
      {
         return _model.allZoneNickName;
      }
      
      public function set allZoneNickName(value:String) : void
      {
         _model.allZoneNickName = value;
      }
      
      public function get points() : int
      {
         return _model.points;
      }
      
      public function set points(value:int) : void
      {
         _model.points = value;
      }
      
      public function get gameNum() : int
      {
         return _model.gameNum;
      }
      
      public function set gameNum(value:int) : void
      {
         _model.gameNum = value;
      }
      
      public function get states() : int
      {
         return _model.states;
      }
      
      public function set states(value:int) : void
      {
         _model.states = value;
      }
      
      public function get level() : int
      {
         return _model.level;
      }
      
      public function set level(value:int) : void
      {
         _model.level = value;
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
