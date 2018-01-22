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
      
      public function CryptBossControl(){super();}
      
      public static function get instance() : CryptBossControl{return null;}
      
      public function setup() : void{}
      
      protected function __onUpdateView(param1:CryptBossEvent) : void{}
      
      protected function __onOpenView(param1:CryptBossEvent) : void{}
      
      public function show() : void{}
      
      private function loadCompleteHandler(param1:UIModuleEvent) : void{}
      
      private function onUimoduleLoadProgress(param1:UIModuleEvent) : void{}
      
      private function showFrame() : void{}
      
      public function getTemplateIdArr(param1:int, param2:int) : Array{return null;}
      
      private function frameDisposeHandler(param1:ComponentEvent) : void{}
   }
}
