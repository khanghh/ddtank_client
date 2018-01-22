package dragonBoat
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.view.UIModuleSmallLoading;
   import dragonBoat.event.DragonBoatEvent;
   import dragonBoat.view.DragonBoatConsumeView;
   import dragonBoat.view.DragonBoatFrame;
   import dragonBoat.view.DragonBoatOtherRankItem;
   import dragonBoat.view.DragonBoatSelfRankItem;
   import dragonBoat.view.DragonBoatShopFrame;
   import dragonBoat.view.KingStatueHighBuildView;
   import dragonBoat.view.KingStatueNormalBuildView;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class DragonBoatControl extends EventDispatcher
   {
      
      private static var _instance:DragonBoatControl;
       
      
      private var _frame:DragonBoatFrame;
      
      public function DragonBoatControl(param1:IEventDispatcher = null){super(null);}
      
      public static function get instance() : DragonBoatControl{return null;}
      
      public function setup() : void{}
      
      protected function __onOpenView(param1:DragonBoatEvent) : void{}
      
      private function onLoadComplete(param1:LoaderEvent) : void{}
      
      protected function onSmallLoadingClose(param1:Event) : void{}
      
      protected function onUIProgress(param1:UIModuleEvent) : void{}
      
      protected function createLaurelFrame(param1:UIModuleEvent) : void{}
   }
}
