package godsRoads.manager{   import com.pickgliss.events.UIModuleEvent;   import com.pickgliss.loader.DataAnalyzer;   import com.pickgliss.loader.UIModuleLoader;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.events.CrazyTankSocketEvent;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.view.UIModuleSmallLoading;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.events.MouseEvent;   import godsRoads.analyze.GodsRoadsDataAnalyzer;   import godsRoads.data.GodsRoadsMissionVo;   import godsRoads.data.GodsRoadsStepVo;   import godsRoads.data.GodsRoadsVo;   import godsRoads.model.GodsRoadsModel;   import hallIcon.HallIconManager;   import road7th.comm.PackageIn;      public class GodsRoadsManager extends EventDispatcher   {            private static var _instance:GodsRoadsManager;            public static const GODSROADS_CHANGESTEPS:String = "godsroadschangesteps";            public static const GODSROADS_OPENFRAME:String = "godsroadsopenframe";            public static const GODSROADS_DISPOSE:String = "godsroadsdispose";                   public var _model:GodsRoadsModel;            private var _isOpen:Boolean = false;            private var _func:Function;            private var _xml:XML;            private var _funcParams:Array;            public var level:int;            public function GodsRoadsManager(privateClass:PrivateClass) { super(); }
            public static function get instance() : GodsRoadsManager { return null; }
            public function setup() : void { }
            public function loadGodsRoadsModule(complete:Function = null, completeParams:Array = null) : void { }
            private function loadCompleteHandler(event:UIModuleEvent) : void { }
            private function onUimoduleLoadProgress(event:UIModuleEvent) : void { }
            private function pkgHandler(e:CrazyTankSocketEvent) : void { }
            public function changeSteps(lv:int) : void { }
            public function templateDataSetup(analyzer:DataAnalyzer) : void { }
            public function showGodsRoads() : void { }
            private function hideGodsRoadsIcon() : void { }
            public function openGodsRoads(e:MouseEvent) : void { }
            private function sendEnter() : void { }
            private function doOpenGodsRoads(pkg:PackageIn) : void { }
            public function get isOpen() : Boolean { return false; }
            public function get XMLData() : XML { return null; }
            public function set XMLData(val:XML) : void { }
   }}class PrivateClass{          function PrivateClass() { super(); }
}