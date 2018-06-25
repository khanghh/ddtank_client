package ddt.view.caddyII.offerPack{   import bagAndInfo.cell.BaseCell;   import com.greensock.TweenMax;   import com.greensock.easing.Elastic;   import com.pickgliss.effect.EffectManager;   import com.pickgliss.effect.IEffect;   import com.pickgliss.events.ListItemEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.ui.controls.container.HBox;   import com.pickgliss.ui.image.MovieImage;   import com.pickgliss.ui.image.Scale9CornerImage;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import consortion.ConsortionModelManager;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.data.goods.ShopItemInfo;   import ddt.events.BagEvent;   import ddt.events.PkgEvent;   import ddt.events.PlayerPropertyEvent;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SharedManager;   import ddt.manager.ShopManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.view.caddyII.CaddyEvent;   import ddt.view.caddyII.CaddyModel;   import ddt.view.caddyII.LookTrophy;   import ddt.view.caddyII.RightView;   import flash.display.Bitmap;   import flash.display.Shape;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.geom.Point;   import flash.utils.setTimeout;   import store.view.ConsortiaRateManager;      public class OfferPackViewII extends RightView   {            public static const OFFER_TURNSPRITE:int = 5;            public static const SCALE_NUMBER:Number = 0.1;            public static const SELECT_SCALE_NUMBER:Number = 0.05;                   private var _bg:ScaleBitmapImage;            private var _gridBGII:MovieImage;            private var _openBtn:BaseButton;            private var _lookTrophy:LookTrophy;            private var _goodsNameTxt:FilterFrameText;            private var _selectGoodsInfo:InventoryItemInfo;            private var _effect:IEffect;            private var _movie:MovieImage;            private var _turnSprite:Sprite;            private var _turnBG:ScaleFrameImage;            private var _selectSprite:Sprite;            private var _selectCell:BaseCell;            private var _offerNumber:int;            private var _packNumber:int;            private var _selectNumber:int = -1;            private var _endFrame:int;            private var _startY:int;            private var _consortiaManagerBtn:TextButton;            private var _itemTempLateID:Array;            private var _offerBack:ScaleBitmapImage;            private var _offerField:FilterFrameText;            private var _isItem:Boolean = true;            private var _packItems:Array;            private var _selectedPackItem:OfferPackItem;            private var _itemBox:HBox;            private var _localAutoOpen:Boolean;            private var _offerShopList:Vector.<ShopItemInfo>;            public function OfferPackViewII() { super(); }
            private function initView() : void { }
            public function setupSelectedPack(offerType:int) : void { }
            private function __packItemClick(evt:MouseEvent) : void { }
            private function initOfferShopList() : void { }
            override public function get openBtnEnable() : Boolean { return false; }
            private function createSelectCell() : void { }
            private function initEvents() : void { }
            private function __selectedChanged(event:Event) : void { }
            private function __changeConsortia(evt:Event) : void { }
            private function __consortiaMgrClick(evt:MouseEvent) : void { }
            private function __packComplete(evt:PkgEvent) : void { }
            private function removeEvents() : void { }
            private function openImp() : void { }
            private function _openClick(e:MouseEvent) : void { }
            private function _lookClick(e:MouseEvent) : void { }
            private function _quickBuy(e:MouseEvent) : void { }
            private function __changeProperty(evt:PlayerPropertyEvent) : void { }
            private function _bagUpdate(e:BagEvent) : void { }
            private function __frameHandler(e:Event) : void { }
            private function __buttonClick(event:MouseEvent) : void { }
            private function __itemClick(event:ListItemEvent) : void { }
            private function creatTweenMagnify() : void { }
            private function creatTweenSelectMagnify() : void { }
            private function creatEffect() : void { }
            private function _moveOk() : void { }
            private function _toMove() : void { }
            public function set offerNumber(value:int) : void { }
            public function get offerNumber() : int { return 0; }
            public function set packNumber(value:int) : void { }
            public function get packNumber() : int { return 0; }
            public function set selectNumber(value:int) : void { }
            public function get selectNumber() : int { return 0; }
            override public function again() : void { }
            override public function setSelectGoodsInfo(info:InventoryItemInfo) : void { }
            private function moviePlay(isItem:Boolean = false) : void { }
            private function movieComplete() : void { }
            private function _startTurn() : void { }
            public function get selectedItem() : OfferPackItem { return null; }
            public function set selectedItem(val:OfferPackItem) : void { }
            override public function dispose() : void { }
   }}