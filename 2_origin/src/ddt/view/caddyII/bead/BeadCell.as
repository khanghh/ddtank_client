package ddt.view.caddyII.bead
{
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class BeadCell extends BaseCell
   {
       
      
      public function BeadCell()
      {
         var size:Point = ComponentFactory.Instance.creatCustomObject("bead.beadCellSize");
         var shape:Shape = new Shape();
         shape.graphics.beginFill(0,1);
         shape.graphics.drawRoundRect(0,0,size.x,size.y,12);
         shape.graphics.endFill();
         super(shape,null,false,false);
      }
      
      override protected function updateSize(sp:Sprite) : void
      {
         if(sp)
         {
            sp.width = _contentWidth;
            sp.height = _contentHeight;
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
   }
}
