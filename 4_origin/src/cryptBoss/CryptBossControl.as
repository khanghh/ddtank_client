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
      
      protected function __onUpdateView(event:CryptBossEvent) : void
      {
         if(_cryptBossFrame)
         {
            _cryptBossFrame.updateView();
         }
      }
      
      protected function __onOpenView(event:CryptBossEvent) : void
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
      
      private function loadCompleteHandler(event:UIModuleEvent) : void
      {
         if(event.module == "cryptBoss")
         {
            UIModuleSmallLoading.Instance.hide();
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",loadCompleteHandler);
            UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",onUimoduleLoadProgress);
            loadComplete = true;
            show();
         }
      }
      
      private function onUimoduleLoadProgress(event:UIModuleEvent) : void
      {
         if(event.module == "horse")
         {
            UIModuleSmallLoading.Instance.progress = event.loader.progress * 100;
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
      
      public function getTemplateIdArr(mapId:int, star:int) : Array
      {
         var dungeon:DungeonInfo = MapManager.getDungeonInfo(mapId);
         switch(int(star) - 1)
         {
            case 0:
               return dungeon.SimpleTemplateIds.split(",");
            case 1:
               return dungeon.NormalTemplateIds.split(",");
            case 2:
               return dungeon.HardTemplateIds.split(",");
            case 3:
               return dungeon.TerrorTemplateIds.split(",");
            case 4:
               return dungeon.NightmareTemplateIds.split(",");
         }
      }
      
      private function frameDisposeHandler(event:ComponentEvent) : void
      {
         if(_cryptBossFrame)
         {
            _cryptBossFrame.removeEventListener("dispose",frameDisposeHandler);
         }
         _cryptBossFrame = null;
      }
   }
}
