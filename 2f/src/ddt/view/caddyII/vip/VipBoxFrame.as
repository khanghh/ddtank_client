package ddt.view.caddyII.vip{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.events.BagEvent;   import ddt.events.PkgEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.view.caddyII.CaddyBagView;   import ddt.view.caddyII.CaddyEvent;   import ddt.view.caddyII.CaddyModel;   import ddt.view.caddyII.MoveSprite;   import flash.events.Event;      public class VipBoxFrame extends Frame   {            public static const VerticalOffset:int = -50;                   private var _bg:ScaleBitmapImage;            private var _view:VipViewII;            private var _bag:CaddyBagView;            private var _moveSprite:MoveSprite;            private var _closeAble:Boolean = true;            private var _itemInfo:ItemTemplateInfo;            private var _type:int;            private var _caddyAwardCount:int = 0;            private var _closed:Boolean = false;            private var _selectInfo:InventoryItemInfo;            public function VipBoxFrame(type:int, itemInfo:ItemTemplateInfo = null) { super(); }
            public function setCaddyType(id:int) : void { }
            public function setBeadType(id:int) : void { }
            public function setOfferType(id:int) : void { }
            public function setCardType(id:int, place:int) : void { }
            private function initView(type:int) : void { }
            private function initEvents() : void { }
            private function __lotteryOpen(event:PkgEvent) : void { }
            private function removeEvents() : void { }
            private function _response(evt:FrameEvent) : void { }
            private function _responseII(e:FrameEvent) : void { }
            private function _responseI(e:FrameEvent) : void { }
            private function _showCloseAlert() : void { }
            private function _questCellPoint(e:Event) : void { }
            private function _turnComplete(e:Event) : void { }
            private function _moveComplete(e:Event) : void { }
            private function _startTurn(e:CaddyEvent) : void { }
            public function turnComplete(e:Event) : void { }
            private function _startMove(e:Event) : void { }
            private function _getCellPoint(e:CaddyEvent) : void { }
            private function _getGoodsInfo(e:CaddyEvent) : void { }
            public function show() : void { }
            public function set closeAble(value:Boolean) : void { }
            public function get closeAble() : Boolean { return false; }
            override public function dispose() : void { }
   }}