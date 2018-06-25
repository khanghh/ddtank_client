package shop.view{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.ui.controls.list.DropList;   import com.pickgliss.ui.image.Image;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.text.TextArea;   import com.pickgliss.utils.ObjectUtils;   import consortion.ConsortionModelManager;   import ddt.manager.LanguageMgr;   import ddt.manager.LeavePageManager;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import ddt.view.NameInputDropListTarget;   import ddt.view.chat.ChatFriendListPanel;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.geom.Point;      public class ShopPresentClearingFrame extends Frame   {            public static const GIVETYPE:int = 0;            public static const FPAYTYPE_LIHUN:int = 1;            public static const FPAYTYPE_SHOP:int = 2;            public static const FPAYTYPE_PAIMAI:int = 3;                   protected var _titleTxt:FilterFrameText;            protected var _descriptTxt:FilterFrameText;            protected var _type:int;            protected var _BG:Image;            protected var _BG1:ScaleBitmapImage;            private var _textAreaBg:Image;            protected var _comboBoxLabel:FilterFrameText;            protected var _chooseFriendBtn:TextButton;            protected var _nameInput:NameInputDropListTarget;            protected var _dropList:DropList;            protected var _friendList:ChatFriendListPanel;            protected var _cancelBtn:TextButton;            protected var _okBtn:TextButton;            private var _textArea:TextArea;            private var _selectPlayerId:int = -1;            public function ShopPresentClearingFrame() { super(); }
            public function get titleTxt() : FilterFrameText { return null; }
            public function get nameInput() : NameInputDropListTarget { return null; }
            public function get presentBtn() : BaseButton { return null; }
            public function get textArea() : TextArea { return null; }
            public function get selectPlayerId() : int { return 0; }
            public function setType(type:int = 0) : void { }
            protected function initView() : void { }
            public function show() : void { }
            public function onlyFriendSelectView() : void { }
            protected function selectName(nick:String, id:int = 0) : void { }
            public function setName(value:String) : void { }
            public function get Name() : String { return null; }
            private function initEvent() : void { }
            private function __cancelPresent(event:MouseEvent) : void { }
            private function __buyMoney(event:MouseEvent) : void { }
            private function __showFramePanel(event:MouseEvent) : void { }
            private function __responseHandler(event:FrameEvent) : void { }
            private function removeEvent() : void { }
            protected function __hideDropList(event:Event) : void { }
            override public function dispose() : void { }
            protected function __onReceiverChange(event:Event) : void { }
            private function filterRepeatInArray(filterArr:Array) : Array { return null; }
            private function filterSearch(list:Array, targetStr:String) : Array { return null; }
   }}