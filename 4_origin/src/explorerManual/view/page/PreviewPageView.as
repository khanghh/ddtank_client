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
      
      public function PreviewPageView()
      {
         super();
         ManualPreviewTip;
         initView();
      }
      
      private function initView() : void
      {
         _iconCell = ComponentFactory.Instance.creatComponentByStylename("explorerManual.preview.Icon");
         addChild(_iconCell);
         _iconCell.mouseEnabled = true;
         _bor = ComponentFactory.Instance.creat("asset.explorerManual.chapterShowBorderIcon");
         addChild(_bor);
         _preViewTxt = ComponentFactory.Instance.creat("asset.explorerManual.pageRightView.previewTxtIcon");
         addChild(_preViewTxt);
      }
      
      public function set tipData(info:ManualPageItemInfo) : void
      {
         _iconCell.pageInfo = info;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_iconCell);
         _iconCell = null;
         ObjectUtils.disposeObject(_bor);
         _bor = null;
         ObjectUtils.disposeObject(_preViewTxt);
         _preViewTxt = null;
      }
   }
}
