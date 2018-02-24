package wasteRecycle.view
{
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.DoubleClickManager;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.DragManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class WasteRecycleGoodsCell extends BagCell
   {
       
      
      public function WasteRecycleGoodsCell(param1:Sprite){super(null,null,null,null);}
      
      override public function dragDrop(param1:DragEffect) : void{}
      
      protected function __clickHandler(param1:InteractiveEvent) : void{}
      
      override public function dragStop(param1:DragEffect) : void{}
      
      protected function __doubleClickHandler(param1:InteractiveEvent) : void{}
      
      override public function dragStart() : void{}
      
      protected function __cellChanged(param1:Event) : void{}
      
      override public function dispose() : void{}
   }
}
