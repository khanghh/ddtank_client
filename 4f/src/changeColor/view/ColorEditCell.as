package changeColor.view
{
   import bagAndInfo.cell.LinkedBagCell;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class ColorEditCell extends LinkedBagCell
   {
       
      
      public function ColorEditCell(param1:Sprite){super(null);}
      
      override protected function onMouseClick(param1:MouseEvent) : void{}
      
      override protected function onMouseOver(param1:MouseEvent) : void{}
      
      override protected function onMouseOut(param1:MouseEvent) : void{}
      
      override public function dragStart() : void{}
   }
}
