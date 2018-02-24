package luckStar
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.loader.LoaderManager;
   import com.pickgliss.loader.ModuleLoader;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.utils.RequestVairableCreater;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.Event;
   import flash.net.URLVariables;
   import luckStar.manager.LuckStarManager;
   import luckStar.model.LuckStarRankAnalyzer;
   
   public class LoadingLuckStarUI
   {
      
      private static var _instance:LoadingLuckStarUI;
       
      
      public function LoadingLuckStarUI(){super();}
      
      public static function get Instance() : LoadingLuckStarUI{return null;}
      
      public function startLoad() : void{}
      
      private function __onLoadComplete(param1:UIModuleEvent) : void{}
      
      private function __onProgress(param1:UIModuleEvent) : void{}
      
      private function loadingLuckStarAction() : void{}
      
      private function _onLoadingCloseHandle(param1:Event) : void{}
      
      public function RequestActivityRank() : void{}
      
      private function createRequestLuckyStarActivityRank() : BaseLoader{return null;}
      
      private function __onLoadError(param1:LoaderEvent) : void{}
      
      private function __onAlertResponse(param1:FrameEvent) : void{}
   }
}
