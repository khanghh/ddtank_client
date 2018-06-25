package consortion.view.selfConsortia{   import bagAndInfo.cell.BaseCell;   import baglocked.BaglockedManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.MutipleImage;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.bagStore.BagStore;   import ddt.command.QuickBuyFrame;   import ddt.data.goods.ItemPrice;   import ddt.data.goods.ShopItemInfo;   import ddt.events.ShortcutBuyEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.display.DisplayObject;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;      public class ConsortionShopItem extends Sprite implements Disposeable   {                   private var _info:ShopItemInfo;            private var _enable:Boolean;            private var _time:int;            private var _bg:ScaleBitmapImage;            private var _cellBG:DisplayObject;            private var _cell:BaseCell;            private var _limitCount:FilterFrameText;            private var _nameTxt:FilterFrameText;            private var _selfRichBg:MutipleImage;            private var _selfRichText:FilterFrameText;            private var _selfRichTxt:FilterFrameText;            private var _btnArr:Vector.<ConsortionShopItemBtn>;            private var _line:MutipleImage;            public function ConsortionShopItem($enable:Boolean) { super(); }
            override public function get height() : Number { return 0; }
            private function initView() : void { }
            private function removeEvent() : void { }
            private function __limitChange(event:Event) : void { }
            public function set setFilters(b:Boolean) : void { }
            public function set info($info:ShopItemInfo) : void { }
            public function set neededRich(num:int) : void { }
            private function upView() : void { }
            private function __clickHandler(event:MouseEvent) : void { }
            private function removeFromStageHandler(event:Event) : void { }
            private function __shortCutBuyHandler(evt:ShortcutBuyEvent) : void { }
            private function __onResponse(e:FrameEvent) : void { }
            private function sendConsortiaShop() : void { }
            private function checkMoney(type:int) : Boolean { return false; }
            private function __quickBuyResponse(evt:FrameEvent) : void { }
            public function dispose() : void { }
   }}