package store.view.storeBag
{
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import com.greensock.TweenMax;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.DragManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import store.StrengthDataManager;
   import store.equipGhost.EquipGhostManager;
   import store.events.StoreDargEvent;
   
   public class StoreBagCell extends BagCell
   {
       
      
      private var _light:Boolean;
      
      private var _lockDisplayObject:DisplayObject;
      
      private var _cellLocked:Boolean = false;
      
      public var showLock:Boolean = false;
      
      public function StoreBagCell(param1:int, param2:ItemTemplateInfo = null, param3:Boolean = true, param4:Sprite = null){super(null,null,null,null);}
      
      public function get lockDisplayObject() : DisplayObject{return null;}
      
      public function set lockDisplayObject(param1:DisplayObject) : void{}
      
      public function get cellLocked() : Boolean{return false;}
      
      public function set cellLocked(param1:Boolean) : void{}
      
      override public function dragDrop(param1:DragEffect) : void{}
      
      override public function dragStart() : void{}
      
      override public function dragStop(param1:DragEffect) : void{}
      
      private function getPlace(param1:InventoryItemInfo) : int{return 0;}
      
      private function checkBagType(param1:InventoryItemInfo) : Boolean{return false;}
      
      public function set light(param1:Boolean) : void{}
      
      private function showEffect() : void{}
      
      private function hideEffect() : void{}
      
      override public function dispose() : void{}
      
      override public function set info(param1:ItemTemplateInfo) : void{}
   }
}
