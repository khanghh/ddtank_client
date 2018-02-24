package rescue.components
{
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.CellFactory;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import rescue.RescueControl;
   import rescue.data.RescueRewardInfo;
   
   public class RescuePrizeItem extends Sprite implements Disposeable
   {
       
      
      private var _sp:Sprite;
      
      private var _bg:Bitmap;
      
      private var _prizeImg:Bitmap;
      
      private var _bagCell:BagCell;
      
      private var _alreadyGet:Bitmap;
      
      private var _index:int;
      
      private var _downFlag:Boolean;
      
      public function RescuePrizeItem(param1:int){super();}
      
      private function initView() : void{}
      
      private function addEvents() : void{}
      
      protected function __mouseOut(param1:MouseEvent) : void{}
      
      protected function __mouseOver(param1:MouseEvent) : void{}
      
      protected function __mouseUp(param1:MouseEvent) : void{}
      
      protected function __mouseDown(param1:MouseEvent) : void{}
      
      public function setData(param1:RescueRewardInfo) : void{}
      
      public function setStatus(param1:int) : void{}
      
      private function removeEvents() : void{}
      
      public function dispose() : void{}
   }
}
