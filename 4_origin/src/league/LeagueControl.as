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
      
      public function LeagueControl(param1:IEventDispatcher = null)
      {
         super(param1);
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
      
      protected function __onOpenView(param1:Event) : void
      {
         loadLeagueModule(doShowLeagueShopFrame);
      }
      
      private function doShowLeagueShopFrame() : void
      {
         var _loc1_:LeagueShopFrame = ComponentFactory.Instance.creatComponentByStylename("league.LeagueShopFrame");
         LayerManager.Instance.addToLayer(_loc1_,3,true,1);
         SocketManager.Instance.out.sendPersonalLimitShop(93);
      }
      
      private function loadLeagueModule(param1:Function = null, param2:Array = null) : void
      {
         _func = param1;
         _funcParams = param2;
         UIModuleSmallLoading.Instance.progress = 0;
         UIModuleSmallLoading.Instance.show();
         UIModuleLoader.Instance.addEventListener("uiModuleComplete",loadCompleteHandler);
         UIModuleLoader.Instance.addEventListener("uiMoudleProgress",onUimoduleLoadProgress);
         UIModuleLoader.Instance.addUIModuleImp("league");
      }
      
      private function onUimoduleLoadProgress(param1:UIModuleEvent) : void
      {
         if(param1.module == "league")
         {
            UIModuleSmallLoading.Instance.progress = param1.loader.progress * 100;
         }
      }
      
      private function loadCompleteHandler(param1:UIModuleEvent) : void
      {
         if(param1.module == "league")
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
