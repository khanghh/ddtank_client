package gemstone
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.data.player.PlayerInfo;
   import ddt.data.player.SelfInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.EventDispatcher;
   import gemstone.info.GemstListInfo;
   import gemstone.info.GemstonInitInfo;
   import gemstone.info.GemstoneAnalyze;
   import gemstone.info.GemstoneInfo;
   import gemstone.info.GemstoneStaticInfo;
   import gemstone.info.GemstoneUpGradeInfo;
   import gemstone.items.ExpBar;
   import gemstone.items.GemstoneContent;
   import gemstone.items.Item;
   
   public class GemstoneManager extends EventDispatcher
   {
      
      public static const GOLDEN_LEVEL:int = 6;
      
      private static var _instance:GemstoneManager;
      
      public static const SuitPLACE:int = 11;
      
      public static const GlassPPLACE:int = 5;
      
      public static const HariPPLACE:int = 2;
      
      public static const FacePLACE:int = 3;
      
      public static const DecorationPLACE:int = 13;
      
      public static const ID1:int = 100001;
      
      public static const ID2:int = 100002;
      
      public static const ID3:int = 100003;
      
      public static const ID4:int = 100004;
      
      public static const ID5:int = 100005;
       
      
      private var _gemstoneFrame:GemstoneFrame;
      
      private var _stoneInfoList:Vector.<GemstoneInfo>;
      
      private var _stoneItemList:Vector.<Item>;
      
      private var _stoneContentGroupList:Array;
      
      private var _stoneContentList:Array;
      
      private var _func:Function;
      
      private var _funcParams:Array;
      
      private var _loader:BaseLoader;
      
      private var _redUrl:String;
      
      private var _bulUrl:String;
      
      private var _greUrl:String;
      
      private var _yelUrl:String;
      
      private var _purpleUrl:String;
      
      private var _upGradeList:Vector.<GemstoneUpGradeInfo>;
      
      public var redInfoList:Vector.<GemstoneStaticInfo>;
      
      public var bluInfoList:Vector.<GemstoneStaticInfo>;
      
      public var greInfoList:Vector.<GemstoneStaticInfo>;
      
      public var yelInfoList:Vector.<GemstoneStaticInfo>;
      
      public var purpleInfoList:Vector.<GemstoneStaticInfo>;
      
      public var curstatiDataList:Vector.<GemstoneStaticInfo>;
      
      public var curItem:GemstoneContent;
      
      public var curGemstoneUpInfo:GemstoneUpGradeInfo;
      
      private var _gInfoList:Object;
      
      public var curUpInfoList:Vector.<GemstListInfo>;
      
      public var suitList:Vector.<GemstListInfo>;
      
      public var glassList:Vector.<GemstListInfo>;
      
      public var hariList:Vector.<GemstListInfo>;
      
      public var faceList:Vector.<GemstListInfo>;
      
      public var decorationList:Vector.<GemstListInfo>;
      
      public var curMaxLevel:uint;
      
      public function GemstoneManager(){super();}
      
      public static function get Instance() : GemstoneManager{return null;}
      
      public function loaderData() : void{}
      
      private function compeleteHander(param1:GemstoneAnalyze) : void{}
      
      private function loaderComplete(param1:LoaderEvent) : void{}
      
      public function initView() : GemstoneFrame{return null;}
      
      public function initFrame(param1:GemstoneFrame) : void{}
      
      public function clearFrame() : void{}
      
      public function upDataFitCount() : void{}
      
      public function get gemstoneFrame() : GemstoneFrame{return null;}
      
      public function initEvent() : void{}
      
      private function playerFigSpiritinit(param1:CrazyTankSocketEvent) : void{}
      
      private function rezArr(param1:String) : Array{return null;}
      
      protected function playerFigSpiritUp(param1:CrazyTankSocketEvent) : void{}
      
      public function loadGemstoneModule(param1:Function = null, param2:Array = null) : void{}
      
      public function get expBar() : ExpBar{return null;}
      
      public function getRedUrl() : String{return null;}
      
      public function getYelUrl() : String{return null;}
      
      public function getPurpleUrl() : String{return null;}
      
      public function getBulUrl() : String{return null;}
      
      public function getGreUrl() : String{return null;}
      
      public function setRedUrl(param1:String) : void{}
      
      public function setYelUrl(param1:String) : void{}
      
      public function setBulUrl(param1:String) : void{}
      
      public function setGreUrl(param1:String) : void{}
      
      public function setPurpleUrl(param1:String) : void{}
      
      private function onUimoduleLoadProgress(param1:UIModuleEvent) : void{}
      
      public function getSelfList(param1:int) : Vector.<GemstListInfo>{return null;}
      
      public function getByPlayerInfoList(param1:int, param2:int) : Vector.<GemstListInfo>{return null;}
      
      public function setGemstoneListInfo(param1:GemstoneUpGradeInfo) : void{}
      
      public function getPlaceByGemstonInitInfo(param1:int, param2:Vector.<GemstonInitInfo>) : GemstonInitInfo{return null;}
   }
}
