package explorerManual.view.page
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import explorerManual.data.model.ManualPageItemInfo;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class PreviewPageView extends Sprite implements Disposeable
   {
       
      
      private var _bor:Bitmap;
      
      private var _preViewTxt:Bitmap;
      
      private var _iconCell:ManualPreIconCell;
      
      public function PreviewPageView(){super();}
      
      private function initView() : void{}
      
      public function set tipData(param1:ManualPageItemInfo) : void{}
      
      public function dispose() : void{}
   }
}
