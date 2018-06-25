package ddt.view.caddyII.card{   import bagAndInfo.cell.BaseCell;   import cardSystem.data.CardInfo;   import com.greensock.TweenLite;   import com.greensock.easing.Elastic;   import com.greensock.easing.Sine;   import com.pickgliss.effect.EffectManager;   import com.pickgliss.effect.IEffect;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.image.Image;   import com.pickgliss.ui.image.MovieImage;   import com.pickgliss.ui.image.Scale9CornerImage;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.events.BagEvent;   import ddt.events.PkgEvent;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SharedManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.view.caddyII.CaddyModel;   import ddt.view.caddyII.RightView;   import ddt.view.caddyII.bead.BeadItem;   import ddt.view.caddyII.reader.AwardsInfo;   import flash.display.Bitmap;   import flash.display.Shape;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.geom.Point;   import flash.utils.clearTimeout;   import flash.utils.setTimeout;   import road7th.comm.PackageIn;   import road7th.data.DictionaryData;   import road7th.data.DictionaryEvent;      public class CardViewII extends RightView   {            public static var _instance:CardViewII;            public static const CARD_TURNSPRITE:int = 5;            public static const SCALE_NUMBER:Number = 0.1;            public static const SELECT_SCALE_NUMBER:Number = 0.05;                   private var _bg:ScaleBitmapImage;            private var _bg1:Image;            private var _gridBGI:MovieImage;            private var _gridBGII:MovieImage;            private var _openBtn:BaseButton;            private var _turnBG:Bitmap;            private var _goodsNameTxt:FilterFrameText;            private var _turnSprite:Sprite;            private var _movie:MovieImage;            private var _effect:IEffect;            private var _selectCell:BaseCell;            private var _selectSprite:Sprite;            private var _cardItem:BeadItem;            private var _smeltBeadCell:BeadItem;            private var _cardNumberTxt:FilterFrameText;            private var _endFrame:int;            private var _startY:int;            private var _cardID:int;            private var _cardPlace:int;            private var _haveCardNumber:int;            private var _cardInfo:ItemTemplateInfo;            private var _selectGoodsInfo:ItemTemplateInfo;            private var _inputTxt:FilterFrameText;            private var _localAutoOpen:Boolean;            private var info:CardInfo;            private var mAwardSoul:AwardsInfo;            private var winTime:int;            private var mSprite:Sprite;            private var mSpriteX:int;            public function CardViewII() { super(); }
            public static function get instance() : CardViewII { return null; }
            private function initView() : void { }
            private function initEvents() : void { }
            private function removeEvents() : void { }
            private function _update(e:BagEvent) : void { }
            private function _upPropdate(event:BagEvent) : void { }
            private function _updateCaddyBag(e:DictionaryEvent) : void { }
            private function __getSoul(event:PkgEvent) : void { }
            private function __setGoodName(event:Event) : void { }
            private function _openClick(e:MouseEvent) : void { }
            private function __selectedChanged(e:Event) : void { }
            public function setCard(val:int, place:int) : void { }
            private function haveCardNumber(id:int) : int { return 0; }
            private function createSelectCell() : void { }
            private function creatEffect() : void { }
            private function creatTweenMagnify() : void { }
            private function creatTweenSelectMagnify() : void { }
            private function _moveOk() : void { }
            private function _toMove() : void { }
            private function openImp() : void { }
            private function getCardBagType(place:int) : int { return 0; }
            private function getCardPlace(place:int) : int { return 0; }
            private function getRandomCardPlace(place:int) : int { return 0; }
            override public function again() : void { }
            private function moviePlay() : void { }
            private function __frameHandler(e:Event) : void { }
            private function createTweenSoulNum() : void { }
            private function _showOk() : void { }
            private function SetSoulNumBmp(pSoulNum:int) : void { }
            public function get closeEnble() : Boolean { return false; }
            override public function get openBtnEnable() : Boolean { return false; }
            override public function dispose() : void { }
   }}