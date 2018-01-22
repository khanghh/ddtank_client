package worldBossHelper
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import invite.InviteManager;
   import worldBossHelper.data.WorldBossHelperTypeData;
   import worldBossHelper.event.WorldBossHelperEvent;
   import worldBossHelper.view.WorldBossHelperFrame;
   
   public class WorldBossHelperController extends EventDispatcher
   {
      
      private static var _instance:WorldBossHelperController;
       
      
      public var data:WorldBossHelperTypeData;
      
      public var monkeyType:int;
      
      private var _honor:int;
      
      private var _money:int;
      
      private var _medal:int;
      
      private var _frame:WorldBossHelperFrame;
      
      private var _manager:WorldBossHelperManager;
      
      public function WorldBossHelperController(){super();}
      
      public static function get Instance() : WorldBossHelperController{return null;}
      
      public function setup() : void{}
      
      protected function __onOpenView(param1:CEvent) : void{}
      
      public function show() : void{}
      
      protected function __onBossOpen(param1:WorldBossHelperEvent) : void{}
      
      protected function __playerInfoHandler(param1:PkgEvent) : void{}
      
      protected function __assistantHandler(param1:PkgEvent) : void{}
      
      protected function _loadingCloseHandler(param1:Event) : void{}
      
      private function closeLoading() : void{}
      
      protected function _loaderCompleteHandler(param1:UIModuleEvent) : void{}
      
      public function dispose() : void{}
      
      protected function _loaderProgressHandler(param1:UIModuleEvent) : void{}
   }
}
