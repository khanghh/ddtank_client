package godsRoads.manager
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   import godsRoads.analyze.GodsRoadsDataAnalyzer;
   import godsRoads.data.GodsRoadsMissionVo;
   import godsRoads.data.GodsRoadsStepVo;
   import godsRoads.data.GodsRoadsVo;
   import godsRoads.model.GodsRoadsModel;
   import hallIcon.HallIconManager;
   import road7th.comm.PackageIn;
   
   public class GodsRoadsManager extends EventDispatcher
   {
      
      private static var _instance:GodsRoadsManager;
      
      public static const GODSROADS_CHANGESTEPS:String = "godsroadschangesteps";
      
      public static const GODSROADS_OPENFRAME:String = "godsroadsopenframe";
      
      public static const GODSROADS_DISPOSE:String = "godsroadsdispose";
       
      
      public var _model:GodsRoadsModel;
      
      private var _isOpen:Boolean = false;
      
      private var _func:Function;
      
      private var _xml:XML;
      
      private var _funcParams:Array;
      
      public var level:int;
      
      public function GodsRoadsManager(param1:PrivateClass){super();}
      
      public static function get instance() : GodsRoadsManager{return null;}
      
      public function setup() : void{}
      
      public function loadGodsRoadsModule(param1:Function = null, param2:Array = null) : void{}
      
      private function loadCompleteHandler(param1:UIModuleEvent) : void{}
      
      private function onUimoduleLoadProgress(param1:UIModuleEvent) : void{}
      
      private function pkgHandler(param1:CrazyTankSocketEvent) : void{}
      
      public function changeSteps(param1:int) : void{}
      
      public function templateDataSetup(param1:DataAnalyzer) : void{}
      
      public function showGodsRoads() : void{}
      
      private function hideGodsRoadsIcon() : void{}
      
      public function openGodsRoads(param1:MouseEvent) : void{}
      
      private function sendEnter() : void{}
      
      private function doOpenGodsRoads(param1:PackageIn) : void{}
      
      public function get isOpen() : Boolean{return false;}
      
      public function get XMLData() : XML{return null;}
      
      public function set XMLData(param1:XML) : void{}
   }
}

class PrivateClass
{
    
   
   function PrivateClass(){super();}
}
