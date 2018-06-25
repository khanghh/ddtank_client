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
      
      public function FoodActivityControl()
      {
         super();
      }
      
      public static function get Instance() : FoodActivityControl
      {
         if(_instance == null)
         {
            _instance = new FoodActivityControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         FoodActivityManager.Instance.addEventListener(FoodActivityEvent.FOOD_OPENVIEW,__onOpenView);
         FoodActivityManager.Instance.addEventListener(FoodActivityEvent.FOOD_UPDATEVIEW,__onUpdateView);
         FoodActivityManager.Instance.addEventListener(FoodActivityEvent.FOOD_CLOSEVIEW,__onCloseView);
         FoodActivityManager.Instance.addEventListener(FoodActivityEvent.FOOD_REWARD,__onGetReward);
      }
      
      protected function __onGetReward(event:FoodActivityEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var isSuccess:Boolean = pkg.readBoolean();
         FoodActivityManager.Instance.ripeNum = pkg.readInt();
         if(isSuccess)
         {
            if(_frame)
            {
               _frame.updateBoxMc();
               if(FoodActivityManager.Instance.info.activityChildType == 0)
               {
                  if(FoodActivityManager.Instance.cookingCount == 0)
                  {
                     FoodActivityManager.Instance.startTime();
                  }
                  else
                  {
                     FoodActivityManager.Instance.endTime();
                  }
               }
            }
         }
         else if(_frame)
         {
            _frame.failRewardUpdate();
         }
      }
      
      protected function __onCloseView(event:FoodActivityEvent) : void
      {
         disposeFrame();
      }
      
      private function __onUpdateView(event:FoodActivityEvent) : void
      {
         if(_frame)
         {
            _frame.updateProgress();
         }
      }
      
      public function disposeFrame() : void
      {
         if(_frame)
         {
            _frame.dispose();
         }
         _frame = null;
      }
      
      protected function __onOpenView(event:FoodActivityEvent) : void
      {
         UIModuleSmallLoading.Instance.progress = 0;
         UIModuleSmallLoading.Instance.show();
         UIModuleSmallLoading.Instance.addEventListener("close",_loadingCloseHandle);
         UIModuleLoader.Instance.addEventListener("uiModuleComplete",_loaderCompleteHandle);
         UIModuleLoader.Instance.addEventListener("uiMoudleProgress",_loaderProgressHandle);
         UIModuleLoader.Instance.addEventListener("uiModuleError",_loaderErrorHandle);
         UIModuleLoader.Instance.addUIModuleImp("foodactivity");
      }
      
      protected function _loaderCompleteHandle(event:UIModuleEvent) : void
      {
         if(event.module == "foodactivity")
         {
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",_loaderCompleteHandle);
            UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",_loaderProgressHandle);
            UIModuleLoader.Instance.removeEventListener("uiModuleError",_loaderErrorHandle);
            UIModuleSmallLoading.Instance.removeEventListener("close",_loadingCloseHandle);
            UIModuleSmallLoading.Instance.hide();
            _frame = ComponentFactory.Instance.creatCustomObject("foodActivity.frame");
            _frame.titleText = LanguageMgr.GetTranslation("foodActivity.frame.title");
            LayerManager.Instance.addToLayer(_frame,3,true,1);
         }
      }
      
      protected function _loaderErrorHandle(event:UIModuleEvent) : void
      {
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",_loaderCompleteHandle);
         UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",_loaderProgressHandle);
         UIModuleLoader.Instance.removeEventListener("uiModuleError",_loaderErrorHandle);
         UIModuleSmallLoading.Instance.removeEventListener("close",_loadingCloseHandle);
         UIModuleSmallLoading.Instance.hide();
      }
      
      protected function _loaderProgressHandle(event:UIModuleEvent) : void
      {
         UIModuleSmallLoading.Instance.progress = event.loader.progress * 100;
      }
      
      protected function _loadingCloseHandle(event:Event) : void
      {
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",_loaderCompleteHandle);
         UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",_loaderProgressHandle);
         UIModuleLoader.Instance.removeEventListener("uiModuleError",_loaderErrorHandle);
         UIModuleSmallLoading.Instance.removeEventListener("close",_loadingCloseHandle);
         UIModuleSmallLoading.Instance.hide();
      }
   }
}
