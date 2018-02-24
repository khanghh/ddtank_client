package mainbutton
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import mainbutton.data.MainButtonManager;
   
   public class MainButtnController extends EventDispatcher
   {
      
      private static var _instance:MainButtnController;
      
      public static var useFirst:Boolean = true;
      
      public static var loadComplete:Boolean = false;
      
      public static var ACTIVITIES:String = "1";
      
      public static var ROULETTE:String = "2";
      
      public static var VIP:String = "3";
      
      public static var SIGN:String = "5";
      
      public static var AWARD:String = "6";
      
      public static var ANGELBLESS:String = "7";
      
      public static var FIRSTRECHARGE:String = "8";
      
      public static var DDT_ACTIVITY:String = "ddtactivity";
      
      public static var DDT_AWARD:String = "ddtaward";
      
      public static var ICONCLOSE:String = "iconClose";
      
      public static var CLOSESIGN:String = "closeSign";
      
      public static var ICONOPEN:String = "iconOpen";
       
      
      public var btnList:Vector.<MainButton>;
      
      private var _currntType:String;
      
      private var _awardFrame:AwardFrame;
      
      private var _dailAwardState:Boolean;
      
      private var _vipAwardState:Boolean;
      
      public function MainButtnController(){super();}
      
      public static function get instance() : MainButtnController{return null;}
      
      public function show(param1:String) : void{}
      
      private function showFrame(param1:String) : void{}
      
      private function __onClose(param1:Event) : void{}
      
      private function __progressShow(param1:UIModuleEvent) : void{}
      
      private function __complainShow(param1:UIModuleEvent) : void{}
      
      public function set DailyAwardState(param1:Boolean) : void{}
      
      public function get DailyAwardState() : Boolean{return false;}
      
      public function set VipAwardState(param1:Boolean) : void{}
      
      public function get VipAwardState() : Boolean{return false;}
      
      public function test() : Vector.<MainButton>{return null;}
   }
}
