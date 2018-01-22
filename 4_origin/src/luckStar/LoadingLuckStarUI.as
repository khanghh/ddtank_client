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
      
      private function __onLoadComplete(param1:UIModuleEvent) : void
      {
         if(param1.module == "luckstar")
         {
            UIModuleSmallLoading.Instance.hide();
            UIModuleSmallLoading.Instance.removeEventListener("close",_onLoadingCloseHandle);
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onLoadComplete);
            UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__onProgress);
            loadingLuckStarAction();
            LuckStarManager.Instance.openLuckyStarFrame();
         }
      }
      
      private function __onProgress(param1:UIModuleEvent) : void
      {
         if(param1.module == "luckstar")
         {
            UIModuleSmallLoading.Instance.progress = param1.loader.progress * 100;
         }
      }
      
      private function loadingLuckStarAction() : void
      {
         if(!ModuleLoader.hasDefinition("luckyStar.view.maxAwardAction"))
         {
            LoaderManager.Instance.creatAndStartLoad(PathManager.getUIPath() + "/swf/luckstaraction.swf",4);
         }
      }
      
      private function _onLoadingCloseHandle(param1:Event) : void
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
         var _loc2_:URLVariables = RequestVairableCreater.creatWidthKey(true);
         var _loc1_:BaseLoader = LoaderManager.Instance.creatLoader(PathManager.solveRequestPath("LuckStarActivityRank.ashx"),6,_loc2_);
         _loc1_.loadErrorMessage = "请求幸运星模版失败!";
         _loc1_.analyzer = new LuckStarRankAnalyzer(LuckStarController.Instance.updateLuckyStarRank);
         _loc1_.addEventListener("loadError",__onLoadError);
         return _loc1_;
      }
      
      private function __onLoadError(param1:LoaderEvent) : void
      {
         var _loc3_:String = param1.loader.loadErrorMessage;
         if(param1.loader.analyzer)
         {
            if(param1.loader.analyzer.message != null)
            {
               _loc3_ = param1.loader.loadErrorMessage + "\n" + param1.loader.analyzer.message;
            }
         }
         var _loc2_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("alert"),_loc3_,"确定");
         _loc2_.addEventListener("response",__onAlertResponse);
      }
      
      private function __onAlertResponse(param1:FrameEvent) : void
      {
         param1.currentTarget.removeEventListener("response",__onAlertResponse);
         ObjectUtils.disposeObject(param1.currentTarget);
      }
   }
}
