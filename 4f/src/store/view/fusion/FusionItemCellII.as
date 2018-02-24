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
      
      public function FusionItemCellII(param1:int){super(null,null);}
      
      override protected function createChildren() : void{}
      
      override public function dragDrop(param1:DragEffect) : void{}
      
      override protected function updateSize(param1:Sprite) : void{}
      
      override public function dispose() : void{}
   }
}
