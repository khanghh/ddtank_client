package giftSystem.view{   import baglocked.BaglockedManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.controls.list.DropList;   import com.pickgliss.ui.image.MutipleImage;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import consortion.ConsortionModelManager;   import ddt.data.goods.ShopItemInfo;   import ddt.events.PlayerPropertyEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.LeavePageManager;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import ddt.view.NameInputDropListTarget;   import ddt.view.chat.ChatFriendListPanel;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.geom.Point;   import giftSystem.GiftController;   import giftSystem.GiftEvent;   import giftSystem.GiftManager;   import giftSystem.element.GiftCartItem;      public class ClearingInterface extends Frame   {                   private var _bg:ScaleBitmapImage;            private var _bg3:MutipleImage;            private var _bg4:MutipleImage;            private var _chooseFriendBtn:TextButton;            private var _nameInput:NameInputDropListTarget;            private var _dropList:DropList;            private var _friendList:ChatFriendListPanel;            private var _buyMoneyBtn:BaseButton;            private var _presentBtn:BaseButton;            private var _totalMoney:FilterFrameText;            private var _poorMoney:FilterFrameText;            private var _giftNum:FilterFrameText;            private var _giftCartItem:GiftCartItem;            private var _moneyIsEnough:ScaleFrameImage;            private var _NeedPay:FilterFrameText;            private var _HavePay:FilterFrameText;            private var _moneyTxt:FilterFrameText;            private var _moneyTxt1:FilterFrameText;            private var _comboBoxLabel:FilterFrameText;            private var _buyTxt:FilterFrameText;            private var _info:ShopItemInfo;            public function ClearingInterface() { super(); }
            private function initView() : void { }
            private function selectName(nick:String, id:int = 0) : void { }
            public function setName(value:String) : void { }
            public function set info(value:ShopItemInfo) : void { }
            private function updateMoneyType() : void { }
            private function initEvent() : void { }
            protected function __sendRetrunHandler(event:GiftEvent) : void { }
            private function __numberChange(event:Event) : void { }
            private function __present(event:MouseEvent) : void { }
            private function __buyMoney(event:MouseEvent) : void { }
            private function __showFramePanel(event:MouseEvent) : void { }
            private function __responseHandler(event:FrameEvent) : void { }
            private function removeEvent() : void { }
            override public function dispose() : void { }
            protected function __hideDropList(event:Event) : void { }
            protected function __onReceiverChange(event:Event) : void { }
            private function filterRepeatInArray(filterArr:Array) : Array { return null; }
            private function filterSearch(list:Array, targetStr:String) : Array { return null; }
            protected function __moneyChange(event:PlayerPropertyEvent) : void { }
            protected function __confirmResponse(event:FrameEvent) : void { }
   }}