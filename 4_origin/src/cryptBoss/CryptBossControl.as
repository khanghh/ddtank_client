package cryptBoss
{
   import com.pickgliss.events.ComponentEvent;
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import cryptBoss.event.CryptBossEvent;
   import cryptBoss.view.CryptBossMainFrame;
   import ddt.data.map.DungeonInfo;
   import ddt.manager.MapManager;
   import ddt.view.UIModuleSmallLoading;
   
   public class CryptBossControl
   {
      
      private static var _instance:CryptBossControl;
      
      public static var loadComplete:Boolean = false;
       
      
      private var _cryptBossFrame:CryptBossMainFrame;
      
      public function CryptBossControl()
      {
         super();
      }
      
      public static function get instance() : CryptBossControl
      {
         if(!_instance)
         {
            _instance = new CryptBossControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         CryptBossManager.instance.addEventListener("cryptBossOpenView",__onOpenView);
         CryptBossManager.instance.addEventListener("cryptBossOpenView",__onUpdateView);
      }
      
      protected function __onUpdateView(param1:CryptBossEvent) : void
      {
         if(_cryptBossFrame)
         {
            _cryptBossFrame.updateView();
         }
      }
      
      protected function __onOpenView(param1:CryptBossEvent) : void
      {
         show();
      }
      
      public function show() : void
      {
         if(loadComplete)
         {
            showFrame();
         }
         else
         {
            UIModuleSmallLoading.Instance.progress = 0;
            UIModuleSmallLoading.Instance.show();
            UIModuleLoader.Instance.addEventListener("uiModuleComplete",loadCompleteHandler);
            UIModuleLoader.Instance.addEventListener("uiMoudleProgress",onUimoduleLoadProgress);
            UIModuleLoader.Instance.addUIModuleImp("cryptBoss");
         }
      }
      
      private function loadCompleteHandler(param1:UIModuleEvent) : void
      {
         if(param1.module == "cryptBoss")
         {
            UIModuleSmallLoading.Instance.hide();
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",loadCompleteHandler);
            UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",onUimoduleLoadProgress);
            loadComplete = true;
            show();
         }
      }
      
      private function onUimoduleLoadProgress(param1:UIModuleEvent) : void
      {
         if(param1.module == "horse")
         {
            UIModuleSmallLoading.Instance.progress = param1.loader.progress * 100;
         }
      }
      
      private function showFrame() : void
      {
         if(!_cryptBossFrame)
         {
            _cryptBossFrame = ComponentFactory.Instance.creatComponentByStylename("CryptBossMainFrame");
            _cryptBossFrame.addEventListener("dispose",frameDisposeHandler,false,0,true);
            LayerManager.Instance.addToLayer(_cryptBossFrame,3,true,1);
         }
      }
      
      public function getTemplateIdArr(param1:int, param2:int) : Array
      {
         var _loc3_:DungeonInfo = MapManager.getDungeonInfo(param1);
         switch(int(param2) - 1)
         {
            case 0:
               return _loc3_.SimpleTemplateIds.split(",");
            case 1:
               return _loc3_.NormalTemplateIds.split(",");
            case 2:
               return _loc3_.HardTemplateIds.split(",");
            case 3:
               return _loc3_.TerrorTemplateIds.split(",");
            case 4:
               return _loc3_.NightmareTemplateIds.split(",");
         }
      }
      
      private function frameDisposeHandler(param1:ComponentEvent) : void
      {
         if(_cryptBossFrame)
         {
            _cryptBossFrame.removeEventListener("dispose",frameDisposeHandler);
         }
         _cryptBossFrame = null;
      }
   }
}
