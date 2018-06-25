package store.view.fusion
{
   import bagAndInfo.cell.DragEffect;
   import bagAndInfo.cell.LinkedBagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class PreviewItemCell extends LinkedBagCell
   {
       
      
      public function PreviewItemCell()
      {
         var bg:Sprite = new Sprite();
         var bgBit:Bitmap = ComponentFactory.Instance.creatBitmap("asset.store.FusionCellBG");
         bg.addChild(bgBit);
         super(bg);
         if(_cellMouseOverBg)
         {
            ObjectUtils.disposeObject(_cellMouseOverBg);
         }
         _cellMouseOverBg = null;
      }
      
      override public function dragDrop(effect:DragEffect) : void
      {
      }
   }
}
