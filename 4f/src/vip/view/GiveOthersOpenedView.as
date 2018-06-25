package vip.view{   import baglocked.BaglockedManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.ScrollPanel;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.ui.controls.TextInput;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.controls.container.VBox;   import com.pickgliss.ui.controls.list.DropList;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.Image;   import com.pickgliss.ui.image.Scale9CornerImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import consortion.ConsortionModelManager;   import ddt.manager.LanguageMgr;   import ddt.manager.LeavePageManager;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import ddt.view.FriendDropListTarget;   import ddt.view.chat.ChatFriendListPanel;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.events.TextEvent;   import flash.geom.Point;   import road7th.utils.StringHelper;   import vip.VipController;      public class GiveOthersOpenedView extends GiveYourselfOpenView implements Disposeable   {                   public var isBand:Boolean;            private var _nametxt:FilterFrameText;            private var _repeatNametxt:FilterFrameText;            private var _friendName:FriendDropListTarget;            private var _amountOfMoneyTxt:FilterFrameText;            private var _amountOfMoney:FilterFrameText;            private var _moneyIcon:Image;            private var _dropList:DropList;            private var _repeatName:TextInput;            private var _friendListBtn:TextButton;            private var _friendList:ChatFriendListPanel;            private var _list:VBox;            private var _itemArray:Array;            private var _listBG:Scale9CornerImage;            private var _inputBG:Scale9CornerImage;            private var _listScrollPanel:ScrollPanel;            private var _confirmFrame:BaseAlerFrame;            private var _moneyConfirm:BaseAlerFrame;            public function GiveOthersOpenedView(bool:Boolean, $discountCode:int) { super(null); }
            private function init() : void { }
            private function addEvent() : void { }
            protected function __propertyChangedHandler(event:Event) : void { }
            private function removeEvent() : void { }
            private function __seletected(e:Event) : void { }
            private function __listAction(evt:MouseEvent) : void { }
            private function __textChange(evt:Event) : void { }
            private function filterSearch(list:Array, targetStr:String) : Array { return null; }
            private function filterRepeatInArray(filterArr:Array) : Array { return null; }
            private function __textInputHandler(evt:TextEvent) : void { }
            private function __repeattextInputHandler(evt:TextEvent) : void { }
            override protected function __openVip(evt:MouseEvent) : void { }
            private function __moneyConfirmHandler(evt:FrameEvent) : void { }
            private function __confirm(evt:FrameEvent) : void { }
            override protected function send() : void { }
            private function selectName(nick:String, id:int = 0) : void { }
            private function __friendListView(event:MouseEvent) : void { }
            override public function dispose() : void { }
   }}