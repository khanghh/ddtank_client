package kingDivision{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.loader.BaseLoader;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.loader.LoaderEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.core.Component;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.PkgEvent;   import ddt.manager.GameInSocketOut;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PathManager;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.StateManager;   import ddt.manager.TimeManager;   import flash.display.Bitmap;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.utils.Dictionary;   import hallIcon.HallIconManager;   import kingDivision.analyze.AreaNameMessageAnalyze;   import kingDivision.analyze.KingDivisionConsortionMessageAnalyze;   import kingDivision.data.KingDivisionConsortionItemInfo;   import kingDivision.loader.LoaderKingDivisionUIModule;   import kingDivision.model.KingDivisionModel;   import road7th.comm.PackageIn;      public class KingDivisionManager extends EventDispatcher   {            private static var _instance:KingDivisionManager;            public static const KINGDIVISION_OPENFRAME:String = "kingdivision_openframe";            public static const MATCHAREARANKINFO:String = "matcharearankinfo";            public static const SEARCHRESULT:String = "searchResult";            public static const MATCHINFO:String = "matchinfo";            public static const MATCHSCORE:String = "matchscore";            public static const MATCHRANK:String = "matchrank";            public static const MATCHAREARANK:String = "matcharearank";                   private var _model:KingDivisionModel;            public var openFrame:Boolean;            private var analyzerArr:Array;            public var isThisZoneWin:Boolean;            public var dataDic:Dictionary;            public function KingDivisionManager(pct:PrivateClass) { super(); }
            public static function get Instance() : KingDivisionManager { return null; }
            public function setup() : void { }
            private function __activityOpen(evt:PkgEvent) : void { }
            public function updateConsotionMessage() : void { }
            public function loaderConsortionMessage() : void { }
            public function loaderAreaNameMessage() : void { }
            private function loadAreaNameDataComplete(analyzer:AreaNameMessageAnalyze) : void { }
            private function __onLoadError(event:LoaderEvent) : void { }
            private function __onAlertResponse(event:FrameEvent) : void { }
            private function __searchResult(analyzer:KingDivisionConsortionMessageAnalyze) : void { }
            private function __consortiaMatchInfo(evt:PkgEvent) : void { }
            private function __consortiaMatchScore(evt:PkgEvent) : void { }
            private function __consortiaMatchRank(evt:PkgEvent) : void { }
            private function __consortiaMatchAreaRank(evt:PkgEvent) : void { }
            private function __consortiaMatchAreaRankInfo(evt:PkgEvent) : void { }
            public function templateDataSetup(dataList:Array) : void { }
            public function get model() : KingDivisionModel { return null; }
            public function kingDivisionIcon(flag:Boolean) : void { }
            public function onClickIcon() : void { }
            private function doOpenKingDivisionFrame() : void { }
            public function returnComponent(cell:Bitmap, tipName:String) : Component { return null; }
            public function checkCanStartGame() : Boolean { return false; }
            public function checkGameTimeIsOpen() : Boolean { return false; }
            public function get isOpen() : Boolean { return false; }
            public function set zoneIndex(value:int) : void { }
            public function get zoneIndex() : int { return 0; }
            public function get dateArr() : Array { return null; }
            public function set dateArr(value:Array) : void { }
            public function get allDateArr() : Array { return null; }
            public function set allDateArr(value:Array) : void { }
            public function get thisZoneNickName() : String { return null; }
            public function set thisZoneNickName(value:String) : void { }
            public function get allZoneNickName() : String { return null; }
            public function set allZoneNickName(value:String) : void { }
            public function get points() : int { return 0; }
            public function set points(value:int) : void { }
            public function get gameNum() : int { return 0; }
            public function set gameNum(value:int) : void { }
            public function get states() : int { return 0; }
            public function set states(value:int) : void { }
            public function get level() : int { return 0; }
            public function set level(value:int) : void { }
   }}class PrivateClass{          function PrivateClass() { super(); }
}