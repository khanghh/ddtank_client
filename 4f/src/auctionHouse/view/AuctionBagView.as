package auctionHouse.view
{
   import bagAndInfo.bag.BagView;
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.CellEvent;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import playerDress.PlayerDressControl;
   import playerDress.event.PlayerDressEvent;
   
   public class AuctionBagView extends BagView
   {
       
      
      public function AuctionBagView(){super();}
      
      override protected function initBackGround() : void{}
      
      override protected function initTabButtons() : void{}
      
      override protected function initBagList() : void{}
      
      override protected function set_breakBtn_enable() : void{}
      
      override protected function showDressBagView(param1:PlayerDressEvent) : void{}
      
      override protected function adjustEvent() : void{}
      
      override protected function __cellOpen(param1:Event) : void{}
      
      override protected function __cellClick(param1:CellEvent) : void{}
      
      override protected function __cellDoubleClick(param1:CellEvent) : void{}
      
      override public function setBagType(param1:int) : void{}
      
      override public function dispose() : void{}
   }
}
