package vipCoupons.view{   import bagAndInfo.cell.BagCell;   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.controls.list.DropList;   import com.pickgliss.ui.image.MutipleImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import consortion.ConsortionModelManager;   import ddt.data.goods.InventoryItemInfo;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import flash.events.Event;      public class VIPCouponsFrame extends Frame   {                   private var _contenBg:MutipleImage;            private var _sendBtn:SimpleBitmapButton;            private var _nameInput:VIPCouponsNameInput;            private var _dropList:DropList;            private var _sendToOtherTxt:FilterFrameText;            private var _vipCell:BagCell;            private var _bagType:int;            private var _place:int;            public function VIPCouponsFrame() { super(); }
            public function setVipPlace(bagType:int, place:int) : void { }
            public function get getSendButton() : SimpleBitmapButton { return null; }
            public function get getnameInput() : VIPCouponsNameInput { return null; }
            public function get content() : FilterFrameText { return null; }
            private function initView() : void { }
            private function getItemCount(temId:int) : int { return 0; }
            private function createBagCell(templeteId:int) : BagCell { return null; }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            protected function __hideDropList(event:Event) : void { }
            protected function __onReceiverChange(event:Event) : void { }
            private function filterRepeatInArray(filterArr:Array) : Array { return null; }
            private function filterSearch(list:Array, targetStr:String) : Array { return null; }
            override public function dispose() : void { }
   }}