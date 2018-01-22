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
      
      public function FusionItemCellII(param1:int)
      {
         var _loc2_:Sprite = new Sprite();
         _cellBg = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreIIFusionBG.EquipmentCell");
         _cellBg.label = LanguageMgr.GetTranslation("store.Fusion.FusionCellText");
         _loc2_.addChild(_cellBg);
         super(_loc2_,param1);
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
      
      override public function dragDrop(param1:DragEffect) : void
      {
      }
      
      override protected function updateSize(param1:Sprite) : void
      {
         if(param1)
         {
            param1.width = _contentWidth - 18;
            param1.height = _contentHeight - 18;
            if(_picPos != null)
            {
               param1.x = _picPos.x;
            }
            else
            {
               param1.x = Math.abs(param1.width - _contentWidth) / 2;
            }
            if(_picPos != null)
            {
               param1.y = _picPos.y;
            }
            else
            {
               param1.y = Math.abs(param1.height - _contentHeight) / 2;
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
