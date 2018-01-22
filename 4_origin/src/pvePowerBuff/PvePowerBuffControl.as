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
      
      public function PvePowerBuffControl(param1:pvppowerbuffinstance)
      {
         super();
      }
      
      public static function get instance() : PvePowerBuffControl
      {
         if(_instance == null)
         {
            _instance = new PvePowerBuffControl(new pvppowerbuffinstance());
         }
         return _instance;
      }
      
      public function setup() : void
      {
         PvePowerBuffManager.instance.addEventListener("pvePowerBuffOpenView",__openView);
         PvePowerBuffManager.instance.addEventListener("pvePowerBuffDispose",__disposeView);
      }
      
      private function __openView(param1:PvePowerBuffEvent) : void
      {
         _uiLoader = new HelperUIModuleLoad();
         _uiLoader.loadUIModule(["pvePowerBuff"],__openPvePowerBuffView);
      }
      
      private function __openPvePowerBuffView() : void
      {
         _uiLoader = null;
         mainView = ComponentFactory.Instance.creatCustomObject("pvePowerBuffMainView");
         var _loc1_:PvePowerBuffEvent = new PvePowerBuffEvent("pvePowerBuffLoadComplete");
         _loc1_.info = mainView;
         PvePowerBuffManager.instance.dispatchEvent(_loc1_);
      }
      
      private function __disposeView(param1:PvePowerBuffEvent) : void
      {
         mainView = null;
      }
   }
}

class pvppowerbuffinstance
{
    
   
   function pvppowerbuffinstance()
   {
      super();
   }
}
