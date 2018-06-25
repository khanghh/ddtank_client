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
      
      override public function set tipData(data:Object) : void
      {
         var imgPath:* = null;
         clearLoader();
         ObjectUtils.disposeAllChildren(this);
         var info:ManualPageItemInfo = data as ManualPageItemInfo;
         if(info)
         {
            imgPath = "/explorerManual/" + (info.DebrisCount + 1) + "/" + info.ID + "/" + 0;
            _loaderPic = LoadResourceManager.Instance.createLoader(PathManager.ManualDebrisPNGIconPath(imgPath),0);
            _loaderPic.addEventListener("complete",__picComplete);
            LoadResourceManager.Instance.startLoad(_loaderPic);
         }
      }
      
      private function __picComplete(evt:LoaderEvent) : void
      {
         if(evt.loader.isSuccess)
         {
            addChild(evt.loader.content as Bitmap);
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
