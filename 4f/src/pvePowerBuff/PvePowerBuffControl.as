package pvePowerBuff
{
   import com.pickgliss.ui.ComponentFactory;
   import ddt.utils.HelperUIModuleLoad;
   import flash.events.EventDispatcher;
   
   public class PvePowerBuffControl extends EventDispatcher
   {
      
      public static const SELECT_PLAYER:String = "select_player";
      
      private static var _instance:PvePowerBuffControl;
       
      
      private var _uiLoader:HelperUIModuleLoad;
      
      public var mainView:PvePowerBuffMainView;
      
      public function PvePowerBuffControl(param1:pvppowerbuffinstance){super();}
      
      public static function get instance() : PvePowerBuffControl{return null;}
      
      public function setup() : void{}
      
      private function __openView(param1:PvePowerBuffEvent) : void{}
      
      private function __openPvePowerBuffView() : void{}
      
      private function __disposeView(param1:PvePowerBuffEvent) : void{}
   }
}

class pvppowerbuffinstance
{
    
   
   function pvppowerbuffinstance(){super();}
}
