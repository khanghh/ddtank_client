package giftSystem.view.giftAndRecord{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.ScrollPanel;   import com.pickgliss.ui.controls.container.VBox;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.RecordInfo;   import ddt.data.player.PlayerInfo;   import ddt.manager.PlayerManager;   import flash.display.Bitmap;   import flash.display.Sprite;   import giftSystem.GiftEvent;   import giftSystem.GiftManager;   import giftSystem.element.RecordItem;      public class GiftRecord extends Sprite implements Disposeable   {                   private var _playerInfo:PlayerInfo;            private var _canClick:Boolean = false;            private var _noGift:Bitmap;            private var _container:VBox;            private var _panel:ScrollPanel;            private var _itemArr:Vector.<RecordItem>;            public function GiftRecord() { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            public function set playerInfo(value:PlayerInfo) : void { }
            private function __setRecordList(event:GiftEvent) : void { }
            private function setList(info:RecordInfo) : void { }
            private function setReceived(info:RecordInfo) : void { }
            private function clear() : void { }
            public function dispose() : void { }
   }}