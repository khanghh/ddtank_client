package groupPurchase
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.EventDispatcher;
   import groupPurchase.view.GroupPurchaseQuickBuyFrame;
   import groupPurchase.view.GroupPurchaseRankFrame;
   
   public class GroupPurchaseControl extends EventDispatcher
   {
      
      private static var _instance:GroupPurchaseControl;
       
      
      private var _func:Function;
      
      private var _funcParams:Array;
      
      public function GroupPurchaseControl(){super();}
      
      public static function get instance() : GroupPurchaseControl{return null;}
      
      public function loadResModule(param1:Function = null, param2:Array = null) : void{}
      
      private function onUimoduleLoadProgress(param1:UIModuleEvent) : void{}
      
      private function loadCompleteHandler(param1:UIModuleEvent) : void{}
   }
}
