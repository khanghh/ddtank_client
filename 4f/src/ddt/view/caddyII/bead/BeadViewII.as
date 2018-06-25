package ddt.view.caddyII.bead{   import bagAndInfo.cell.BaseCell;   import com.greensock.TweenMax;   import com.greensock.easing.Elastic;   import com.pickgliss.effect.EffectManager;   import com.pickgliss.effect.IEffect;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.SelectedButtonGroup;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.controls.container.HBox;   import com.pickgliss.ui.image.Image;   import com.pickgliss.ui.image.MovieImage;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.bagStore.BagStore;   import ddt.data.EquipType;   import ddt.data.goods.InventoryItemInfo;   import ddt.events.BagEvent;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SharedManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.view.caddyII.CaddyEvent;   import ddt.view.caddyII.CaddyModel;   import ddt.view.caddyII.LookTrophy;   import ddt.view.caddyII.RightView;   import flash.display.Bitmap;   import flash.display.Shape;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.geom.Point;   import flash.utils.setTimeout;      public class BeadViewII extends RightView   {            public static const BeadFromSmelt:int = -1;            public static const Bead:int = 1;            public static const OFFER_TURNSPRITE:int = 5;            public static const SCALE_NUMBER:Number = 0;            public static const SELECT_SCALE_NUMBER:Number = 0;                   private var _titleTipTxt:FilterFrameText;            private var _bg:ScaleBitmapImage;            private var _gridBGI:MovieImage;            private var _gridBGII:MovieImage;            private var _openBtn:BaseButton;            private var _itemContainer:HBox;            private var _itemGroup:SelectedButtonGroup;            private var _turnBG:ScaleFrameImage;            private var _movie:MovieImage;            private var _goodsNameTxt:FilterFrameText;            private var _selectCell:BaseCell;            private var _selectSprite:Sprite;            private var _lookTrophy:LookTrophy;            private var _selectGoodsInfo:InventoryItemInfo;            private var _selectItem:int = -1;            private var _turnSprite:Sprite;            private var _effect:IEffect;            private var _startY:Number;            private var _endFrame:int;            private var _clickNumber:int;            private var _turnItemShape:Shape;            private var _cellId:Array;            private var _smeltBeadCell:BeadItem;            private var _beadQuickBuyBtn:BaseButton;            private var _beadQuickBuyBtnText1:FilterFrameText;            private var _turnCell:BeadCell;            private var _hasCell:Boolean = false;            private var _localAutoOpen:Boolean;            private var _inputBg:Image;            private var _font:FilterFrameText;            private var _inputTxt:FilterFrameText;            private var _buyType:int = 0;            public function BeadViewII() { super(); }
            public function get openBtn() : BaseButton { return null; }
            private function updateTitleTip(val:int) : void { }
            override public function setType(val:int) : void { }
            private function createCell() : void { }
            private function updateCell() : void { }
            private function clearCell() : void { }
            private function createBead() : void { }
            private function updateBead() : void { }
            private function clearBead() : void { }
            private function updateItemShape() : void { }
            private function initView() : void { }
            private function initEvents() : void { }
            private function __selectedChanged(event:Event) : void { }
            private function __beadQuickBuy(event:MouseEvent) : void { }
            private function showQuickBuyBead() : void { }
            private function openShortcutBuyFrame(tmpSelectedIndex:int) : void { }
            private function __buyGoods(event:Event) : void { }
            private function removeEvents() : void { }
            private function createSelectCell() : void { }
            private function _update(e:BagEvent) : void { }
            private function _beadTypeChange(e:Event) : void { }
            private function openImp() : void { }
            private function _openClick(e:MouseEvent) : void { }
            private function _lookClick(e:MouseEvent) : void { }
            private function __frameHandler(e:Event) : void { }
            private function _itemClick(e:MouseEvent) : void { }
            private function _response(e:FrameEvent) : void { }
            private function _responseI(e:FrameEvent) : void { }
            private function creatEffect() : void { }
            private function creatTweenMagnify() : void { }
            private function creatTweenSelectMagnify() : void { }
            private function _moveOk() : void { }
            private function _toMove() : void { }
            public function set selectItem(value:int) : void { }
            public function get selectItem() : int { return 0; }
            override public function again() : void { }
            override public function setSelectGoodsInfo(info:InventoryItemInfo) : void { }
            private function _startTurn() : void { }
            override public function get openBtnEnable() : Boolean { return false; }
            override public function dispose() : void { }
   }}