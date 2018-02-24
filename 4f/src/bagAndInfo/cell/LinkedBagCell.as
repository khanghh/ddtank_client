package bagAndInfo.cell
{
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.utils.DoubleClickManager;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.CellEvent;
   import ddt.interfaces.IDragable;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class LinkedBagCell extends BagCell
   {
       
      
      protected var _bagCell:BagCell;
      
      public var DoubleClickEnabled:Boolean = true;
      
      public function LinkedBagCell(param1:Sprite){super(null,null,null,null);}
      
      override protected function init() : void{}
      
      private function __clickHandler(param1:InteractiveEvent) : void{}
      
      public function get bagCell() : BagCell{return null;}
      
      public function set bagCell(param1:BagCell) : void{}
      
      override public function get place() : int{return 0;}
      
      protected function __doubleClickHandler(param1:InteractiveEvent) : void{}
      
      override public function dragStop(param1:DragEffect) : void{}
      
      private function __changed(param1:Event) : void{}
      
      override public function getSource() : IDragable{return null;}
      
      public function clearLinkCell() : void{}
      
      override public function set locked(param1:Boolean) : void{}
      
      override public function dispose() : void{}
   }
}
