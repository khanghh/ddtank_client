package changeColor.view
{
   import bagAndInfo.cell.LinkedBagCell;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class ColorEditCell extends LinkedBagCell
   {
       
      
      public function ColorEditCell(bg:Sprite)
      {
         super(bg);
         .super.DoubleClickEnabled = false;
      }
      
      override protected function onMouseClick(evt:MouseEvent) : void
      {
         if(this.itemInfo != null)
         {
            SoundManager.instance.play("008");
            if(_bagCell.itemInfo && _bagCell.itemInfo.lock)
            {
               if(_bagCell.itemInfo.BagType == 0)
               {
                  PlayerManager.Instance.Self.Bag.unlockItem(_bagCell.itemInfo);
               }
               else
               {
                  PlayerManager.Instance.Self.PropBag.unlockItem(_bagCell.itemInfo);
               }
            }
            bagCell.locked = false;
            bagCell = null;
         }
      }
      
      override protected function onMouseOver(evt:MouseEvent) : void
      {
      }
      
      override protected function onMouseOut(evt:MouseEvent) : void
      {
      }
      
      override public function dragStart() : void
      {
      }
   }
}
