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
      
      public function KingDivisionManager(param1:PrivateClass){super();}
      
      public static function get Instance() : KingDivisionManager{return null;}
      
      public function setup() : void{}
      
      private function __activityOpen(param1:PkgEvent) : void{}
      
      public function updateConsotionMessage() : void{}
      
      public function loaderConsortionMessage() : void{}
      
      public function loaderAreaNameMessage() : void{}
      
      private function loadAreaNameDataComplete(param1:AreaNameMessageAnalyze) : void{}
      
      private function __onLoadError(param1:LoaderEvent) : void{}
      
      private function __onAlertResponse(param1:FrameEvent) : void{}
      
      private function __searchResult(param1:KingDivisionConsortionMessageAnalyze) : void{}
      
      private function __consortiaMatchInfo(param1:PkgEvent) : void{}
      
      private function __consortiaMatchScore(param1:PkgEvent) : void{}
      
      private function __consortiaMatchRank(param1:PkgEvent) : void{}
      
      private function __consortiaMatchAreaRank(param1:PkgEvent) : void{}
      
      private function __consortiaMatchAreaRankInfo(param1:PkgEvent) : void{}
      
      public function templateDataSetup(param1:Array) : void{}
      
      public function get model() : KingDivisionModel{return null;}
      
      public function kingDivisionIcon(param1:Boolean) : void{}
      
      public function onClickIcon() : void{}
      
      private function doOpenKingDivisionFrame() : void{}
      
      public function returnComponent(param1:Bitmap, param2:String) : Component{return null;}
      
      public function checkCanStartGame() : Boolean{return false;}
      
      public function checkGameTimeIsOpen() : Boolean{return false;}
      
      public function get isOpen() : Boolean{return false;}
      
      public function set zoneIndex(param1:int) : void{}
      
      public function get zoneIndex() : int{return 0;}
      
      public function get dateArr() : Array{return null;}
      
      public function set dateArr(param1:Array) : void{}
      
      public function get allDateArr() : Array{return null;}
      
      public function set allDateArr(param1:Array) : void{}
      
      public function get thisZoneNickName() : String{return null;}
      
      public function set thisZoneNickName(param1:String) : void{}
      
      public function get allZoneNickName() : String{return null;}
      
      public function set allZoneNickName(param1:String) : void{}
      
      public function get points() : int{return 0;}
      
      public function set points(param1:int) : void{}
      
      public function get gameNum() : int{return 0;}
      
      public function set gameNum(param1:int) : void{}
      
      public function get states() : int{return 0;}
      
      public function set states(param1:int) : void{}
      
      public function get level() : int{return 0;}
      
      public function set level(param1:int) : void{}
   }
}

class PrivateClass
{
    
   
   function PrivateClass(){super();}
}
