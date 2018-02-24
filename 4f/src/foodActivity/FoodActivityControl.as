package foodActivity
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import ddt.manager.LanguageMgr;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.Event;
   import foodActivity.event.FoodActivityEvent;
   import foodActivity.view.FoodActivityFrame;
   import foodActivity.view.FoodActivityTip;
   import road7th.comm.PackageIn;
   
   public class FoodActivityControl
   {
      
      private static var _instance:FoodActivityControl;
       
      
      private var _frame:FoodActivityFrame;
      
      public function FoodActivityControl(){super();}
      
      public static function get Instance() : FoodActivityControl{return null;}
      
      public function setup() : void{}
      
      protected function __onGetReward(param1:FoodActivityEvent) : void{}
      
      protected function __onCloseView(param1:FoodActivityEvent) : void{}
      
      private function __onUpdateView(param1:FoodActivityEvent) : void{}
      
      public function disposeFrame() : void{}
      
      protected function __onOpenView(param1:FoodActivityEvent) : void{}
      
      protected function _loaderCompleteHandle(param1:UIModuleEvent) : void{}
      
      protected function _loaderErrorHandle(param1:UIModuleEvent) : void{}
      
      protected function _loaderProgressHandle(param1:UIModuleEvent) : void{}
      
      protected function _loadingCloseHandle(param1:Event) : void{}
   }
}
