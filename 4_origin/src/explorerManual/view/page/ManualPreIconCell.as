package explorerManual.view.page
{
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.PathManager;
   import explorerManual.data.model.ManualPageItemInfo;
   import flash.display.Bitmap;
   
   public class ManualPreIconCell extends Component
   {
       
      
      private var _loaderPic:DisplayLoader;
      
      private var _info:ManualPageItemInfo;
      
      public function ManualPreIconCell()
      {
         super();
      }
      
      public function set pageInfo(info:ManualPageItemInfo) : void
      {
         _info = info;
         tipData = info;
         clearLoader();
         loadIcon();
      }
      
      private function loadIcon() : void
      {
         var imgPath:String = "/explorerManual/preview/" + _info.ID;
         _loaderPic = LoadResourceManager.Instance.createLoader(PathManager.ManualDebrisIconPath(imgPath),0);
         _loaderPic.addEventListener("complete",__picComplete);
         LoadResourceManager.Instance.startLoad(_loaderPic);
      }
      
      private function __picComplete(evt:LoaderEvent) : void
      {
         ObjectUtils.disposeAllChildren(this);
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
            _loaderPic = null;
         }
      }
      
      override public function dispose() : void
      {
         _info = null;
         ObjectUtils.disposeAllChildren(this);
         clearLoader();
         super.dispose();
      }
   }
}
