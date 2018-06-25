package texpSystem.controller{   import ddt.data.BuffInfo;   import ddt.data.analyze.TexpExpAnalyze;   import ddt.data.player.SelfInfo;   import ddt.events.CEvent;   import ddt.events.PlayerPropertyEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.utils.AssetModuleLoader;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.utils.Dictionary;   import road7th.data.DictionaryData;   import texpSystem.TexpEvent;   import texpSystem.data.TexpExp;   import texpSystem.data.TexpInfo;      public class TexpManager extends EventDispatcher   {            private static const MAX_LV:int = 75;            private static var _instance:TexpManager;            public static const TEXP_VIEW:String = "texpView";            public static const INFO_VIEW:String = "infoView";            public static const CHAGNE_INFO:String = "changeinfo";            public static const CHAGNE_VISIBLE:String = "changevisible";            public static const SHINE:String = "shine";            public static const CLEAN_INFO:String = "cleaninfo";                   private var _texpExp:Dictionary;            private var cevent:CEvent;            private var _isShow:Dictionary;            public var texpType:int = 20;            private var _changeProperties:Array;            private var _texpType:Array;            public function TexpManager(enforcer:TexpManagerEnforcer) { super(); }
            public static function get Instance() : TexpManager { return null; }
            public function setup(analyzer:TexpExpAnalyze) : void { }
            public function showTexpView($type:String, $parent:Sprite) : void { }
            private function loadComplete() : void { }
            public function closeTexpView($type:String) : void { }
            public function changeInfo($type:String, data:*) : void { }
            public function changeVisible($type:String, value:Boolean) : void { }
            public function shine(value:Boolean) : void { }
            public function cleanInfo() : void { }
            public function isShow(type:String) : Boolean { return false; }
            public function getLv(exp:int) : int { return 0; }
            public function getInfo(type:int, exp:int) : TexpInfo { return null; }
            public function getName(type:int) : String { return null; }
            public function getExp(type:int) : int { return 0; }
            public function isXiuLianDaShi(buffInfoData:DictionaryData) : Boolean { return false; }
            private function getEffect(type:int, exp:TexpExp) : int { return 0; }
            private function isUp(type:int, oldExp:int) : Boolean { return false; }
            private function __onChange(evt:PlayerPropertyEvent) : void { }
   }}class TexpManagerEnforcer{          function TexpManagerEnforcer() { super(); }
}