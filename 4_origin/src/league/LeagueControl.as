package league
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import ddt.manager.SocketManager;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import league.view.LeagueShopFrame;
   import league.view.LeagueStartNoticeView;
   
   public class LeagueControl extends EventDispatcher
   {
      
      private static var _instance:LeagueControl;
       
      
      public var militaryRank:int = -1;
      
      private var _func:Function;
      
      private var _funcParams:Array;
      
      private var _lsnView:LeagueStartNoticeView;
      
      public function LeagueControl(target:IEventDispatcher = null)
      {
         super(target);
      }
      
      public static function get instance() : LeagueControl
      {
         if(_instance == null)
         {
            _instance = new LeagueControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         LeagueManager.instance.addEventListener("leagueOpenView",__onOpenView);
      }
      
      protected function __onOpenView(event:Event) : void
      {
         loadLeagueModule(doShowLeagueShopFrame);
      }
      
      private function doShowLeagueShopFrame() : void
      {
         var leagueFrame:LeagueShopFrame = ComponentFactory.Instance.creatComponentByStylename("league.LeagueShopFrame");
         LayerManager.Instance.addToLayer(leagueFrame,3,true,1);
         SocketManager.Instance.out.sendPersonalLimitShop(93);
      }
      
      private function loadLeagueModule(complete:Function = null, completeParams:Array = null) : void
      {
         _func = complete;
         _funcParams = completeParams;
         UIModuleSmallLoading.Instance.progress = 0;
         UIModuleSmallLoading.Instance.show();
         UIModuleLoader.Instance.addEventListener("uiModuleComplete",loadCompleteHandler);
         UIModuleLoader.Instance.addEventListener("uiMoudleProgress",onUimoduleLoadProgress);
         UIModuleLoader.Instance.addUIModuleImp("league");
      }
      
      private function onUimoduleLoadProgress(event:UIModuleEvent) : void
      {
         if(event.module == "league")
         {
            UIModuleSmallLoading.Instance.progress = event.loader.progress * 100;
         }
      }
      
      private function loadCompleteHandler(event:UIModuleEvent) : void
      {
         if(event.module == "league")
         {
            UIModuleSmallLoading.Instance.hide();
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",loadCompleteHandler);
            UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",onUimoduleLoadProgress);
            if(null != _func)
            {
               _func.apply(null,_funcParams);
            }
            _func = null;
            _funcParams = null;
         }
      }
   }
}
