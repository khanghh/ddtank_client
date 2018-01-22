package petsBag.view
{
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.info.PersonalInfoDragInArea;
   import bagAndInfo.info.PlayerInfoViewControl;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.CellEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import pet.data.PetInfo;
   import pet.sprite.PetSpriteManager;
   import petsBag.PetsBagManager;
   import petsBag.view.item.PetBigItem;
   import petsBag.view.item.PetEquipItem;
   import petsBag.view.item.StarBar;
   
   public class ShowPet extends Sprite implements Disposeable
   {
      
      public static var isPetEquip:Boolean;
       
      
      private var _starBar:StarBar;
      
      private var _petBigItem:PetBigItem;
      
      private var _equipLockBitmapData:BitmapData;
      
      private var _vbox:VBox;
      
      private var _equipList:Array;
      
      private var _currentPetIndex:int;
      
      private var _dragDropArea:PersonalInfoDragInArea;
      
      public function ShowPet(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function __showPetTip(param1:Event) : void{}
      
      public function addDragInfoArea() : void{}
      
      public function removeDragInfoArea() : void{}
      
      private function onClickHander(param1:CellEvent) : void{}
      
      private function doubleClickHander(param1:CellEvent) : void{}
      
      public function addPetEquip(param1:InventoryItemInfo) : void{}
      
      public function getBagCell(param1:int) : PetEquipItem{return null;}
      
      public function delPetEquip(param1:int) : void{}
      
      public function update() : void{}
      
      public function update2(param1:PetInfo) : void{}
      
      private function removeEvent() : void{}
      
      private function clearCell() : void{}
      
      public function dispose() : void{}
   }
}
