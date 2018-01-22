package playerDress.components
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.utils.DoubleClickManager;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.CellEvent;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class DressCell extends BagCell
   {
       
      
      public function DressCell(param1:int = 0, param2:ItemTemplateInfo = null, param3:Boolean = true){super(null,null,null);}
      
      private function initEvents() : void{}
      
      private function removeEvents() : void{}
      
      override protected function onMouseOver(param1:MouseEvent) : void{}
      
      override protected function onMouseClick(param1:MouseEvent) : void{}
      
      protected function onClick(param1:InteractiveEvent) : void{}
      
      protected function onDoubleClick(param1:InteractiveEvent) : void{}
      
      override protected function createLoading() : void{}
      
      override public function dispose() : void{}
   }
}
