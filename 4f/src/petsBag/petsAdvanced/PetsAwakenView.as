package petsBag.petsAdvanced{   import baglocked.BaglockedManager;   import com.pickgliss.events.InteractiveEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.DoubleClickManager;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.BagInfo;   import ddt.data.goods.AwakenEquipInfo;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.events.BagEvent;   import ddt.events.CellEvent;   import ddt.events.PkgEvent;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.geom.Point;   import pet.data.PetInfo;   import petsBag.PetsBagManager;   import road7th.comm.PackageIn;      public class PetsAwakenView extends Sprite implements Disposeable   {                   private var _bg:Bitmap;            private var _petsBasicInfoView:PetsBasicInfoView;            private var _prbabilityTxt:FilterFrameText;            private var _awakenBtn:BaseButton;            private var _stoneCell:PetsAwakenEquipCell;            private var _equipCell:PetsAwakenEquipCell;            private var _equipInfoCell:PetsAwakenInfoCell;            private var _equipCellList:PetsAwakenEquipList;            private var _clickDate:Number = 0;            public function PetsAwakenView() { super(); }
            protected function initView() : void { }
            private function updateCount() : void { }
            private function checkAwakenBtnEnable() : void { }
            private function getItemCount(temId:int) : int { return 0; }
            protected function initEvent() : void { }
            protected function removeEvent() : void { }
            private function __removeEquipHandler(evt:InteractiveEvent) : void { }
            private function __equipClickDragHandler(evt:InteractiveEvent) : void { }
            private function __equipDataChangeHandler(evt:Event) : void { }
            private function _updateEquipHandler(evt:BagEvent) : void { }
            private function updateAwakenSuccessItemInfo() : void { }
            private function __petAwakenResultHandler(evt:PkgEvent) : void { }
            private function updateAwakenEquipList(info:AwakenEquipInfo) : void { }
            private function __sendPetsAwakentHandler(evt:MouseEvent) : void { }
            protected function __cellClickHandler(evt:CellEvent) : void { }
            protected function __cellDoubleClickHandler(evt:CellEvent) : void { }
            protected function __allComplete(event:Event) : void { }
            protected function updateData() : void { }
            protected function updateEquipList() : void { }
            private function createTempleteInfo(temID:int) : InventoryItemInfo { return null; }
            private function clearHideBagItem() : void { }
            public function dispose() : void { }
   }}