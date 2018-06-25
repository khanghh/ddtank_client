package ddt.view.caddyII.vip
{
   import bagAndInfo.cell.BaseCell;
   import cardSystem.data.CardInfo;
   import com.greensock.TweenLite;
   import com.greensock.TweenMax;
   import com.greensock.easing.Elastic;
   import com.pickgliss.effect.EffectManager;
   import com.pickgliss.effect.IEffect;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.BagEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.view.caddyII.CaddyEvent;
   import ddt.view.caddyII.CaddyModel;
   import ddt.view.caddyII.RightView;
   import ddt.view.caddyII.bead.BeadItem;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import road7th.data.DictionaryData;
   import road7th.data.DictionaryEvent;
   
   public class VipViewII extends RightView
   {
      
      public static var _instance:VipViewII;
      
      public static const CARD_TURNSPRITE:int = 5;
      
      public static const SCALE_NUMBER:Number = 0.1;
      
      public static const SELECT_SCALE_NUMBER:Number = 0;
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _bg1:Image;
      
      private var _gridBGI:MovieImage;
      
      private var _gridBGII:MovieImage;
      
      private var _openBtn:BaseButton;
      
      private var _turnBG:Bitmap;
      
      private var _goodsNameTxt:FilterFrameText;
      
      private var _turnSprite:Sprite;
      
      private var _movie:MovieImage;
      
      private var _effect:IEffect;
      
      private var _selectCell:BaseCell;
      
      private var _selectSprite:Sprite;
      
      private var _vipItem:BeadItem;
      
      private var _endFrame:int;
      
      private var _startY:int;
      
      private var _vipID:int;
      
      private var _vipPlace:int;
      
      private var _vipInfo:ItemTemplateInfo;
      
      private var _selectGoodsInfo:InventoryItemInfo;
      
      private var _inputTxt:FilterFrameText;
      
      private var _localAutoOpen:Boolean;
      
      private var winTime:int;
      
      public function VipViewII()
      {
         super();
         initView();
         initEvents();
      }
      
      public static function get instance() : VipViewII
      {
         if(_instance == null)
         {
            _instance = new VipViewII();
         }
         return _instance;
      }
      
      private function initView() : void
      {
         var i:int = 0;
         _bg = ComponentFactory.Instance.creatComponentByStylename("caddy.rightBG");
         _bg1 = ComponentFactory.Instance.creatComponentByStylename("bead.numInput.bg2");
         _gridBGI = ComponentFactory.Instance.creatComponentByStylename("bead.rightGridBGI");
         _gridBGII = ComponentFactory.Instance.creatComponentByStylename("bead.rightGridBGII");
         _openBtn = ComponentFactory.Instance.creatComponentByStylename("caddy.OpenBtn");
         var _goldBorder:ScaleBitmapImage = ComponentFactory.Instance.creatComponentByStylename("bead.rightGrid.goldBorder");
         var openBG:Bitmap = ComponentFactory.Instance.creatBitmap("asset.bead.openBG");
         var font:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("bead.fontII");
         font.text = LanguageMgr.GetTranslation("tank.view.award.bagHaving");
         var getFontBG:Scale9CornerImage = ComponentFactory.Instance.creatComponentByStylename("asset.card.getFontBG");
         var getFont:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("asset.card.getFont");
         getFont.text = LanguageMgr.GetTranslation("tank.view.award.getVip");
         var goodsNameBG:Bitmap = ComponentFactory.Instance.creatBitmap("asset.bead.goodsNameBGII");
         _vipItem = ComponentFactory.Instance.creatCustomObject("card.cardCell");
         _vipItem.hideBg();
         _inputTxt = ComponentFactory.Instance.creatComponentByStylename("bead.numberTxt2");
         _goodsNameTxt = ComponentFactory.Instance.creatComponentByStylename("bead.goodsNameTxt");
         _turnSprite = ComponentFactory.Instance.creatCustomObject("bead.turnSprite");
         _turnBG = ComponentFactory.Instance.creatBitmap("asset.vip.turnBG");
         _movie = ComponentFactory.Instance.creatComponentByStylename("bead.movieAsset");
         for(i = 0; i < _movie.movie.currentLabels.length; )
         {
            if(_movie.movie.currentLabels[i].name == "endFrame")
            {
               _endFrame = _movie.movie.currentLabels[i].frame;
            }
            i++;
         }
         addChild(_bg);
         addChild(_bg1);
         addChild(_gridBGI);
         addChild(_gridBGII);
         addChild(_openBtn);
         addChild(openBG);
         addChild(font);
         addChild(getFont);
         addChild(goodsNameBG);
         addChild(_goodsNameTxt);
         addChild(_goldBorder);
         addChild(_inputTxt);
         addChild(_vipItem);
         addChild(_turnSprite);
         _turnBG.x = _turnBG.width / -2;
         _turnBG.y = _turnBG.height * -1 + 5;
         _turnSprite.addChild(_turnBG);
         _startY = _turnSprite.y;
         addChild(_movie);
         _movie.movie.stop();
         _movie.visible = false;
         _autoCheck = ComponentFactory.Instance.creatComponentByStylename("AutoOpenButton");
         var _loc8_:* = SharedManager.Instance.autoVip;
         _autoCheck.selected = _loc8_;
         _localAutoOpen = _loc8_;
         _autoCheck.text = LanguageMgr.GetTranslation("tank.view.award.auto");
         addChild(_autoCheck);
         creatEffect();
         createSelectCell();
      }
      
      private function initEvents() : void
      {
         PlayerManager.Instance.Self.cardBagDic.addEventListener("add",_updateCaddyBag);
         PlayerManager.Instance.Self.cardBagDic.addEventListener("update",_updateCaddyBag);
         PlayerManager.Instance.Self.PropBag.addEventListener("update",_update);
         _movie.movie.addEventListener("enterFrame",__frameHandler);
         _openBtn.addEventListener("click",_openClick);
         _autoCheck.addEventListener("select",__selectedChanged);
      }
      
      private function removeEvents() : void
      {
         PlayerManager.Instance.Self.cardBagDic.removeEventListener("add",_updateCaddyBag);
         PlayerManager.Instance.Self.cardBagDic.removeEventListener("update",_updateCaddyBag);
         PlayerManager.Instance.Self.PropBag.removeEventListener("update",_update);
         _movie.movie.removeEventListener("enterFrame",__frameHandler);
         _openBtn.removeEventListener("click",_openClick);
         _autoCheck.removeEventListener("select",__selectedChanged);
      }
      
      private function _update(e:BagEvent) : void
      {
         _vipItem.count = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(_vipID);
         _inputTxt.text = String(_vipItem.count);
      }
      
      private function _updateCaddyBag(e:DictionaryEvent) : void
      {
         moviePlay();
      }
      
      override public function setSelectGoodsInfo(info:InventoryItemInfo) : void
      {
         SoundManager.instance.play("139");
         _selectGoodsInfo = info;
         _turnSprite.visible = false;
         _movie.visible = true;
         _movie.movie.play();
         _selectCell.info = _selectGoodsInfo;
         _startTurn();
      }
      
      private function _startTurn() : void
      {
         var evt:CaddyEvent = new CaddyEvent("caddy_start_turn");
         evt.info = _selectGoodsInfo;
         dispatchEvent(evt);
      }
      
      private function _openClick(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         openImp();
      }
      
      private function __selectedChanged(e:Event) : void
      {
         _localAutoOpen = _autoCheck.selected;
         SharedManager.Instance.autoVip = _autoCheck.selected;
      }
      
      public function setCard(val:int, place:int) : void
      {
         _vipID = val;
         _vipPlace = place;
         _vipInfo = ItemManager.Instance.getTemplateById(_vipID);
         _vipItem.info = _vipInfo;
         _vipItem.count = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(_vipID);
         _inputTxt.text = String(_vipItem.count);
         creatTweenMagnify();
         _goodsNameTxt.text = _vipInfo.Name;
      }
      
      private function haveCardNumber(id:int) : int
      {
         var number:int = 0;
         var dic:DictionaryData = PlayerManager.Instance.Self.cardBagDic;
         var _loc6_:int = 0;
         var _loc5_:* = dic;
         for each(var info in dic)
         {
            if(info.TemplateID == id)
            {
               number = number + info.Count;
            }
         }
         return number;
      }
      
      private function createSelectCell() : void
      {
         var size:Point = ComponentFactory.Instance.creatCustomObject("bead.selectCellSize");
         var shape:Shape = new Shape();
         shape.graphics.beginFill(0,1);
         shape.graphics.drawRoundRect(0,0,size.x,size.y,12);
         shape.graphics.endFill();
         _selectCell = new BaseCell(shape);
         _selectSprite = ComponentFactory.Instance.creatCustomObject("bead.SelectSprite");
         _selectCell.x = _selectCell.width / -2;
         _selectCell.y = _selectCell.height / -2;
         _selectSprite.addChild(_selectCell);
         addChildAt(_selectSprite,getChildIndex(_movie));
         _selectSprite.visible = false;
      }
      
      private function creatEffect() : void
      {
         _effect = EffectManager.Instance.creatEffect(3,_turnBG,{
            "color":"gold",
            "speed":0.4,
            "blurWidth":10,
            "intensity":40,
            "strength":0.6
         });
         _effect.play();
      }
      
      private function creatTweenMagnify() : void
      {
         TweenLite.killTweensOf(_turnSprite);
         var _loc1_:int = 1;
         _turnSprite.scaleY = _loc1_;
         _turnSprite.scaleX = _loc1_;
         _turnSprite.y = _startY;
         TweenLite.from(_turnSprite,0.5,{
            "scaleX":0.1,
            "scaleY":0.1
         });
         TweenLite.to(_turnSprite,0.4,{
            "delay":0.5,
            "y":_startY + 4,
            "repeat":-1,
            "yoyo":true
         });
      }
      
      private function creatTweenSelectMagnify() : void
      {
         TweenMax.from(_selectSprite,0.7,{
            "scaleX":0,
            "scaleY":0,
            "y":320,
            "alpha":20,
            "onComplete":_moveOk,
            "ease":Elastic.easeOut
         });
      }
      
      private function _moveOk() : void
      {
      }
      
      private function _toMove() : void
      {
         dispatchEvent(new Event("start_move_after_turn"));
         if(_selectCell)
         {
            _selectCell.info = null;
         }
         if(_selectSprite)
         {
            _selectSprite.visible = false;
         }
         if(_goodsNameTxt)
         {
            _goodsNameTxt.text = _vipInfo.Name;
         }
      }
      
      private function openImp() : void
      {
         if(_vipItem)
         {
            if(_vipItem.count > 0 && _vipInfo.TemplateID == 112109)
            {
               if(CaddyModel.instance.bagInfo.itemNumber >= 25)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.caddy.FullBag"));
               }
               else
               {
                  _openBtn.enable = false;
                  _localAutoOpen = SharedManager.Instance.autoVip;
                  SocketManager.Instance.out.sendRouletteBox(5,-2,_vipInfo.TemplateID);
               }
            }
            else
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.caddy.noVip"));
            }
         }
      }
      
      private function getCardPlace(place:int) : int
      {
         var arr:Array = PlayerManager.Instance.Self.Bag.findCellsByTempleteID(_vipID);
         var _loc5_:int = 0;
         var _loc4_:* = arr;
         for each(var info in arr)
         {
            if(info.Place == place)
            {
               return place;
            }
         }
         return arr[0].Place;
      }
      
      private function getRandomCardPlace(place:int) : int
      {
         var arr:Array = PlayerManager.Instance.Self.PropBag.findCellsByTempleteID(_vipID);
         var _loc5_:int = 0;
         var _loc4_:* = arr;
         for each(var info in arr)
         {
            if(info.Place == place)
            {
               return place;
            }
         }
         return arr[0].Place;
      }
      
      override public function again() : void
      {
         if(!_turnSprite || !_movie || !_selectSprite || !_openBtn)
         {
            return;
         }
         _turnSprite.visible = true;
         _movie.visible = false;
         _movie.movie.gotoAndStop(1);
         _selectSprite.visible = false;
         _openBtn.enable = true;
         if(_localAutoOpen)
         {
            openImp();
         }
         else
         {
            _openBtn.enable = true;
         }
      }
      
      private function moviePlay() : void
      {
         SoundManager.instance.play("139");
         _openBtn.enable = false;
         _turnSprite.visible = false;
         _movie.visible = true;
         _movie.movie.play();
      }
      
      private function __frameHandler(e:Event) : void
      {
         if(_movie.movie.currentFrame == _endFrame)
         {
            _selectSprite.visible = true;
            _goodsNameTxt.text = _selectGoodsInfo.Name;
            if(_selectCell)
            {
               _selectCell.info = _selectGoodsInfo;
            }
            creatTweenSelectMagnify();
         }
      }
      
      public function get closeEnble() : Boolean
      {
         return _openBtn.enable;
      }
      
      override public function get openBtnEnable() : Boolean
      {
         return _openBtn.enable;
      }
      
      override public function dispose() : void
      {
         removeEvents();
         clearTimeout(winTime);
         TweenLite.killTweensOf(_turnSprite);
         TweenLite.killTweensOf(_selectSprite);
         _vipInfo = null;
         _selectGoodsInfo = null;
         if(_inputTxt)
         {
            ObjectUtils.disposeObject(_inputTxt);
         }
         _inputTxt = null;
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_bg1)
         {
            ObjectUtils.disposeObject(_bg1);
         }
         _bg1 = null;
         if(_gridBGI)
         {
            ObjectUtils.disposeObject(_gridBGI);
         }
         _gridBGI = null;
         if(_gridBGII)
         {
            ObjectUtils.disposeObject(_gridBGII);
         }
         _gridBGII = null;
         if(_openBtn)
         {
            ObjectUtils.disposeObject(_openBtn);
         }
         _openBtn = null;
         if(_turnBG)
         {
            ObjectUtils.disposeObject(_turnBG);
         }
         _turnBG = null;
         if(_goodsNameTxt)
         {
            ObjectUtils.disposeObject(_goodsNameTxt);
         }
         _goodsNameTxt = null;
         if(_turnSprite)
         {
            ObjectUtils.disposeObject(_turnSprite);
         }
         _turnSprite = null;
         if(_movie)
         {
            _movie.movie.stop();
            ObjectUtils.disposeObject(_movie);
            _movie = null;
         }
         if(_effect)
         {
            ObjectUtils.disposeObject(_effect);
         }
         _effect = null;
         if(_selectCell)
         {
            ObjectUtils.disposeObject(_selectCell);
         }
         _selectCell = null;
         if(_selectSprite)
         {
            ObjectUtils.disposeObject(_selectSprite);
         }
         _selectSprite = null;
         if(_vipItem)
         {
            ObjectUtils.disposeObject(_vipItem);
         }
         _vipItem = null;
         if(_autoCheck)
         {
            ObjectUtils.disposeObject(_autoCheck);
         }
         _autoCheck = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
