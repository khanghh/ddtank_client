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
      
      public function DragonBoatControl(target:IEventDispatcher = null)
      {
         super(target);
         KingStatueHighBuildView;
         KingStatueNormalBuildView;
         DragonBoatSelfRankItem;
         DragonBoatOtherRankItem;
         DragonBoatConsumeView;
      }
      
      public static function get instance() : DragonBoatControl
      {
         if(_instance == null)
         {
            _instance = new DragonBoatControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         DragonBoatManager.instance.addEventListener("dragonOpenView",__onOpenView);
      }
      
      protected function __onOpenView(event:DragonBoatEvent) : void
      {
         var loader:* = null;
         if(PlayerManager.Instance.Self.Grade < 20)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("laurel.gradeLimit",20));
            return;
         }
         if(!_frame)
         {
            loader = LoadResourceManager.Instance.createLoader(PathManager.getUIPath() + "/swf/dragonboatboatres.swf",4);
            loader.addEventListener("complete",onLoadComplete);
            LoadResourceManager.Instance.startLoad(loader);
         }
         else
         {
            _frame = ComponentFactory.Instance.creatComponentByStylename("DragonBoatFrame");
            _frame.init2(DragonBoatManager.instance.activeInfo.ActiveID);
            LayerManager.Instance.addToLayer(_frame,3,true,1);
         }
      }
      
      private function onLoadComplete(event:LoaderEvent) : void
      {
         event.loader.removeEventListener("complete",onLoadComplete);
         UIModuleSmallLoading.Instance.progress = 0;
         UIModuleSmallLoading.Instance.show();
         UIModuleSmallLoading.Instance.addEventListener("close",onSmallLoadingClose);
         UIModuleLoader.Instance.addEventListener("uiModuleComplete",createLaurelFrame);
         UIModuleLoader.Instance.addEventListener("uiMoudleProgress",onUIProgress);
         UIModuleLoader.Instance.addUIModuleImp("dragonboat");
      }
      
      protected function onSmallLoadingClose(event:Event) : void
      {
         UIModuleSmallLoading.Instance.hide();
         UIModuleSmallLoading.Instance.removeEventListener("close",onSmallLoadingClose);
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",createLaurelFrame);
         UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",onUIProgress);
      }
      
      protected function onUIProgress(event:UIModuleEvent) : void
      {
         if(event.module == "dragonboat")
         {
            UIModuleSmallLoading.Instance.progress = event.loader.progress * 100;
         }
      }
      
      protected function createLaurelFrame(event:UIModuleEvent) : void
      {
         if(event.module != "dragonboat")
         {
            return;
         }
         UIModuleSmallLoading.Instance.hide();
         UIModuleSmallLoading.Instance.removeEventListener("close",onSmallLoadingClose);
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",createLaurelFrame);
         UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",onUIProgress);
         _frame = ComponentFactory.Instance.creatComponentByStylename("DragonBoatFrame");
         _frame.init2(DragonBoatManager.instance.activeInfo.ActiveID);
         LayerManager.Instance.addToLayer(_frame,3,true,1);
      }
   }
}
