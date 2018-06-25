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
       
      
      public function LoadingLuckStarUI()
      {
         super();
      }
      
      public static function get Instance() : LoadingLuckStarUI
      {
         if(_instance == null)
         {
            _instance = new LoadingLuckStarUI();
         }
         return _instance;
      }
      
      public function startLoad() : void
      {
         UIModuleSmallLoading.Instance.progress = 0;
         UIModuleSmallLoading.Instance.show();
         UIModuleSmallLoading.Instance.addEventListener("close",_onLoadingCloseHandle);
         UIModuleLoader.Instance.addEventListener("uiModuleComplete",__onLoadComplete);
         UIModuleLoader.Instance.addEventListener("uiMoudleProgress",__onProgress);
         UIModuleLoader.Instance.addUIModuleImp("luckstar");
      }
      
      private function __onLoadComplete(e:UIModuleEvent) : void
      {
         if(e.module == "luckstar")
         {
            UIModuleSmallLoading.Instance.hide();
            UIModuleSmallLoading.Instance.removeEventListener("close",_onLoadingCloseHandle);
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onLoadComplete);
            UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__onProgress);
            loadingLuckStarAction();
            LuckStarManager.Instance.openLuckyStarFrame();
         }
      }
      
      private function __onProgress(e:UIModuleEvent) : void
      {
         if(e.module == "luckstar")
         {
            UIModuleSmallLoading.Instance.progress = e.loader.progress * 100;
         }
      }
      
      private function loadingLuckStarAction() : void
      {
         if(!ModuleLoader.hasDefinition("luckyStar.view.maxAwardAction"))
         {
            LoaderManager.Instance.creatAndStartLoad(PathManager.getUIPath() + "/swf/luckstaraction.swf",4);
         }
      }
      
      private function _onLoadingCloseHandle(e:Event) : void
      {
         UIModuleSmallLoading.Instance.removeEventListener("close",_onLoadingCloseHandle);
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onLoadComplete);
         UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__onProgress);
         UIModuleSmallLoading.Instance.hide();
      }
      
      public function RequestActivityRank() : void
      {
         LoaderManager.Instance.startLoad(createRequestLuckyStarActivityRank());
      }
      
      private function createRequestLuckyStarActivityRank() : BaseLoader
      {
         var args:URLVariables = RequestVairableCreater.creatWidthKey(true);
         var loader:BaseLoader = LoaderManager.Instance.creatLoader(PathManager.solveRequestPath("LuckStarActivityRank.ashx"),6,args);
         loader.loadErrorMessage = "请求幸运星模版失败!";
         loader.analyzer = new LuckStarRankAnalyzer(LuckStarController.Instance.updateLuckyStarRank);
         loader.addEventListener("loadError",__onLoadError);
         return loader;
      }
      
      private function __onLoadError(e:LoaderEvent) : void
      {
         var msg:String = e.loader.loadErrorMessage;
         if(e.loader.analyzer)
         {
            if(e.loader.analyzer.message != null)
            {
               msg = e.loader.loadErrorMessage + "\n" + e.loader.analyzer.message;
            }
         }
         var alert:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("alert"),msg,"确定");
         alert.addEventListener("response",__onAlertResponse);
      }
      
      private function __onAlertResponse(e:FrameEvent) : void
      {
         e.currentTarget.removeEventListener("response",__onAlertResponse);
         ObjectUtils.disposeObject(e.currentTarget);
      }
   }
}
