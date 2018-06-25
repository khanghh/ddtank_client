package worldboss.view{   import bagAndInfo.cell.CellFactory;   import baglocked.BaglockedManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.loader.BitmapLoader;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.loader.LoaderEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.SelectedCheckButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.Image;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.LeavePageManager;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.DisplayObject;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import shop.view.ShopPlayerCell;   import worldboss.WorldBossManager;   import worldboss.model.WorldBossBuffInfo;      public class BuffCartItem extends Sprite implements Disposeable   {                   private var _buffInfo:WorldBossBuffInfo;            private var _bg:DisplayObject;            private var _itemCellBg:DisplayObject;            private var _verticalLine:Image;            private var _itemName:FilterFrameText;            private var _description:FilterFrameText;            private var _cell:ShopPlayerCell;            private var _buffIconLoader:BitmapLoader;            private var _buffIcon:Bitmap;            private var _payPaneBuyBtn:BaseButton;            private var _itemPrice:FilterFrameText;            private var _moneyBitmap:Bitmap;            private var _isBuyText:FilterFrameText;            private var _autoBuySelectedBtn:SelectedCheckButton;            private var _isAlreadyBuy:Boolean = false;            private var _isAllSelected:Boolean = false;            public function BuffCartItem() { super(); }
            protected function drawBackground() : void { }
            protected function drawNameField() : void { }
            protected function drawCellField() : void { }
            private function init() : void { }
            private function updateStatus() : void { }
            private function _buffIconComplete(evt:LoaderEvent) : void { }
            private function addEvent() : void { }
            protected function __autoBuyBuff(event:Event) : void { }
            protected function __onResponse(event:FrameEvent) : void { }
            private function autoBuy() : void { }
            private function removeEvent() : void { }
            private function __selectedBuff(e:Event) : void { }
            public function selected(type:Boolean) : void { }
            private function __payBuyBuff(e:MouseEvent) : void { }
            private function _responseI(e:FrameEvent) : void { }
            public function set buffItemInfo(value:WorldBossBuffInfo) : void { }
            public function changeStatusBuy() : void { }
            public function get IsSelected() : Boolean { return false; }
            public function get price() : int { return 0; }
            public function get buffID() : int { return 0; }
            public function dispose() : void { }
   }}