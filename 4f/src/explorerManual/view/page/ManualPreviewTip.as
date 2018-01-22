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
      
      public function ManualPreviewTip(){super();}
      
      override protected function init() : void{}
      
      override public function set tipData(param1:Object) : void{}
      
      private function __picComplete(param1:LoaderEvent) : void{}
      
      private function clearLoader() : void{}
      
      override public function dispose() : void{}
   }
}
