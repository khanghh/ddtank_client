package store.view.fusion
{
   import bagAndInfo.cell.DragEffect;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Sprite;
   import flash.geom.Point;
   import store.StoreCell;
   import store.view.StoneCellFrame;
   
   public class FusionItemCellII extends StoreCell
   {
      
      public static const CONTENTSIZE:int = 77;
      
      public static const PICPOS:int = 25;
       
      
      private var _cellBg:StoneCellFrame;
      
      public function FusionItemCellII($index:int)
      {
         var bg:Sprite = new Sprite();
         _cellBg = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreIIFusionBG.EquipmentCell");
         _cellBg.label = LanguageMgr.GetTranslation("store.Fusion.FusionCellText");
         bg.addChild(_cellBg);
         super(bg,$index);
         setContentSize(77,77);
         PicPos = new Point(25,25);
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         if(_tbxCount)
         {
            ObjectUtils.disposeObject(_tbxCount);
         }
         _tbxCount = ComponentFactory.Instance.creat("ddtstore.StoreIIFusionBG.FunsionstoneCountTextI");
         _tbxCount.mouseEnabled = false;
         addChild(_tbxCount);
      }
      
      override public function dragDrop(effect:DragEffect) : void
      {
      }
      
      override protected function updateSize(sp:Sprite) : void
      {
         if(sp)
         {
            sp.width = _contentWidth - 18;
            sp.height = _contentHeight - 18;
            if(_picPos != null)
            {
               sp.x = _picPos.x;
            }
            else
            {
               sp.x = Math.abs(sp.width - _contentWidth) / 2;
            }
            if(_picPos != null)
            {
               sp.y = _picPos.y;
            }
            else
            {
               sp.y = Math.abs(sp.height - _contentHeight) / 2;
            }
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_cellBg)
         {
            ObjectUtils.disposeObject(_cellBg);
         }
         _cellBg = null;
      }
   }
}
