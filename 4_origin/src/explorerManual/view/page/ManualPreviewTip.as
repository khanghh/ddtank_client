package explorerManual.view.page
{
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.PathManager;
   import explorerManual.data.model.ManualPageItemInfo;
   import flash.display.Bitmap;
   
   public class ManualPreviewTip extends BaseTip
   {
       
      
      private var _loaderPic:DisplayLoader;
      
      public function ManualPreviewTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
      }
      
      override public function set tipData(param1:Object) : void
      {
         var _loc2_:* = null;
         clearLoader();
         ObjectUtils.disposeAllChildren(this);
         var _loc3_:ManualPageItemInfo = param1 as ManualPageItemInfo;
         if(_loc3_)
         {
            _loc2_ = "/explorerManual/" + (_loc3_.DebrisCount + 1) + "/" + _loc3_.ID + "/" + 0;
            _loaderPic = LoadResourceManager.Instance.createLoader(PathManager.ManualDebrisPNGIconPath(_loc2_),0);
            _loaderPic.addEventListener("complete",__picComplete);
            LoadResourceManager.Instance.startLoad(_loaderPic);
         }
      }
      
      private function __picComplete(param1:LoaderEvent) : void
      {
         if(param1.loader.isSuccess)
         {
            addChild(param1.loader.content as Bitmap);
         }
         clearLoader();
      }
      
      private function clearLoader() : void
      {
         if(_loaderPic)
         {
            _loaderPic.removeEventListener("complete",__picComplete);
         }
         _loaderPic = null;
      }
      
      override public function dispose() : void
      {
         clearLoader();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}
