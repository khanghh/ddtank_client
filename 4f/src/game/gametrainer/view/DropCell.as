package game.gametrainer.view
{
   import bagAndInfo.cell.DragEffect;
   import bagAndInfo.cell.LinkedBagCell;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class DropCell extends LinkedBagCell
   {
       
      
      public function DropCell(){super(null);}
      
      override public function dragDrop(param1:DragEffect) : void{}
      
      override protected function onMouseOver(param1:MouseEvent) : void{}
      
      override protected function onMouseOut(param1:MouseEvent) : void{}
      
      override protected function onMouseClick(param1:MouseEvent) : void{}
      
      override protected function createContentComplete() : void{}
   }
}
