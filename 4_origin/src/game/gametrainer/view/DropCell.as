package game.gametrainer.view
{
   import bagAndInfo.cell.DragEffect;
   import bagAndInfo.cell.LinkedBagCell;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class DropCell extends LinkedBagCell
   {
       
      
      public function DropCell()
      {
         super(null);
         this.allowDrag = false;
         removeEventListener("interactive_click",__doubleClickHandler);
      }
      
      override public function dragDrop(param1:DragEffect) : void
      {
      }
      
      override protected function onMouseOver(param1:MouseEvent) : void
      {
         dispatchEvent(new Event("change"));
         super.onMouseOver(param1);
      }
      
      override protected function onMouseOut(param1:MouseEvent) : void
      {
         dispatchEvent(new Event("complete"));
         super.onMouseOut(param1);
      }
      
      override protected function onMouseClick(param1:MouseEvent) : void
      {
      }
      
      override protected function createContentComplete() : void
      {
         super.createContentComplete();
         _pic.width = 45;
         _pic.height = 46;
      }
   }
}
