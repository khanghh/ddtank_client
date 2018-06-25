package petsBag.view{   import bagAndInfo.cell.BagCell;   import bagAndInfo.info.PersonalInfoDragInArea;   import bagAndInfo.info.PlayerInfoViewControl;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.container.VBox;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.InventoryItemInfo;   import ddt.events.CellEvent;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.SocketManager;   import ddt.utils.PositionUtils;   import flash.display.BitmapData;   import flash.display.Sprite;   import flash.events.Event;   import pet.data.PetInfo;   import pet.sprite.PetSpriteManager;   import petsBag.PetsBagManager;   import petsBag.view.item.PetBigItem;   import petsBag.view.item.PetEquipItem;   import petsBag.view.item.PetWashBoneGrade;   import petsBag.view.item.StarBar;      public class ShowPet extends Sprite implements Disposeable   {            public static var isPetEquip:Boolean;                   private var _starBar:StarBar;            private var _petGrade:PetWashBoneGrade;            private var _petBigItem:PetBigItem;            private var _equipLockBitmapData:BitmapData;            private var _vbox:VBox;            private var _equipList:Array;            private var _currentPetIndex:int;            private var _dragDropArea:PersonalInfoDragInArea;            public function ShowPet() { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            private function __showPetTip(e:Event) : void { }
            public function addDragInfoArea() : void { }
            public function removeDragInfoArea() : void { }
            private function onClickHander(e:CellEvent) : void { }
            private function doubleClickHander(e:CellEvent) : void { }
            public function addPetEquip(date:InventoryItemInfo) : void { }
            public function getBagCell(type:int) : PetEquipItem { return null; }
            public function delPetEquip(id:int) : void { }
            public function update() : void { }
            public function update2(currentPet2:PetInfo) : void { }
            private function removeEvent() : void { }
            private function clearCell() : void { }
            public function dispose() : void { }
   }}