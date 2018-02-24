package texpSystem.controller
{
   import ddt.data.BuffInfo;
   import ddt.data.analyze.TexpExpAnalyze;
   import ddt.data.player.SelfInfo;
   import ddt.events.CEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.utils.AssetModuleLoader;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import road7th.data.DictionaryData;
   import texpSystem.TexpEvent;
   import texpSystem.data.TexpExp;
   import texpSystem.data.TexpInfo;
   
   public class TexpManager extends EventDispatcher
   {
      
      private static const MAX_LV:int = 75;
      
      private static var _instance:TexpManager;
      
      public static const TEXP_VIEW:String = "texpView";
      
      public static const INFO_VIEW:String = "infoView";
      
      public static const CHAGNE_INFO:String = "changeinfo";
      
      public static const CHAGNE_VISIBLE:String = "changevisible";
      
      public static const SHINE:String = "shine";
      
      public static const CLEAN_INFO:String = "cleaninfo";
       
      
      private var _texpExp:Dictionary;
      
      private var cevent:CEvent;
      
      private var _isShow:Dictionary;
      
      public var texpType:int = 20;
      
      public function TexpManager(param1:TexpManagerEnforcer){super();}
      
      public static function get Instance() : TexpManager{return null;}
      
      public function setup(param1:TexpExpAnalyze) : void{}
      
      public function showTexpView(param1:String, param2:Sprite) : void{}
      
      private function loadComplete() : void{}
      
      public function closeTexpView(param1:String) : void{}
      
      public function changeInfo(param1:String, param2:*) : void{}
      
      public function changeVisible(param1:String, param2:Boolean) : void{}
      
      public function shine(param1:Boolean) : void{}
      
      public function cleanInfo() : void{}
      
      public function isShow(param1:String) : Boolean{return false;}
      
      public function getLv(param1:int) : int{return 0;}
      
      public function getInfo(param1:int, param2:int) : TexpInfo{return null;}
      
      public function getName(param1:int) : String{return null;}
      
      public function getExp(param1:int) : int{return 0;}
      
      public function isXiuLianDaShi(param1:DictionaryData) : Boolean{return false;}
      
      private function getEffect(param1:int, param2:TexpExp) : int{return 0;}
      
      private function isUp(param1:int, param2:int) : Boolean{return false;}
      
      private function __onChange(param1:PlayerPropertyEvent) : void{}
   }
}

class TexpManagerEnforcer
{
    
   
   function TexpManagerEnforcer(){super();}
}
