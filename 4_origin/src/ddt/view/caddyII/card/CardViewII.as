package ddt.view.caddyII.card
{
   import bagAndInfo.cell.BaseCell;
   import cardSystem.data.CardInfo;
   import com.greensock.TweenLite;
   import com.greensock.easing.Elastic;
   import com.greensock.easing.Sine;
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
   import ddt.events.PkgEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.view.caddyII.CaddyModel;
   import ddt.view.caddyII.RightView;
   import ddt.view.caddyII.bead.BeadItem;
   import ddt.view.caddyII.reader.AwardsInfo;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   import road7th.data.DictionaryEvent;
   
   public class CardViewII extends RightView
   {
      
      public static var _instance:CardViewII;
      
      public static const CARD_TURNSPRITE:int = 5;
      
      public static const SCALE_NUMBER:Number = 0.1;
      
      public static const SELECT_SCALE_NUMBER:Number = 0.05;
       
      
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
      
      private var _cardItem:BeadItem;
      
      private var _smeltBeadCell:BeadItem;
      
      private var _cardNumberTxt:FilterFrameText;
      
      private var _endFrame:int;
      
      private var _startY:int;
      
      private var _cardID:int;
      
      private var _cardPlace:int;
      
      private var _haveCardNumber:int;
      
      private var _cardInfo:ItemTemplateInfo;
      
      private var _selectGoodsInfo:ItemTemplateInfo;
      
      private var _inputTxt:FilterFrameText;
      
      private var _localAutoOpen:Boolean;
      
      private var info:CardInfo;
      
      private var mAwardSoul:AwardsInfo;
      
      private var winTime:int;
      
      private var mSprite:Sprite;
      
      private var mSpriteX:int;
      
      public function CardViewII()
      {
         mSprite = new Sprite();
         super();
         initView();
         initEvents();
      }
      
      public static function get instance() : CardViewII
      {
         if(_instance == null)
         {
            _instance = new CardViewII();
         }
         return _instance;
      }
      
      private function initView() : void
      {
         var _loc7_:int = 0;
         _bg = ComponentFactory.Instance.creatComponentByStylename("caddy.rightBG");
         _bg1 = ComponentFactory.Instance.creatComponentByStylename("bead.numInput.bg2");
         _gridBGI = ComponentFactory.Instance.creatComponentByStylename("bead.rightGridBGI");
         _gridBGII = ComponentFactory.Instance.creatComponentByStylename("bead.rightGridBGII");
         _openBtn = ComponentFactory.Instance.creatComponentByStylename("caddy.OpenBtn");
         var _loc6_:ScaleBitmapImage = ComponentFactory.Instance.creatComponentByStylename("bead.rightGrid.goldBorder");
         var _loc3_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.bead.openBG");
         var _loc2_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("bead.fontII");
         _loc2_.text = LanguageMgr.GetTranslation("tank.view.award.bagHaving");
         var _loc4_:Scale9CornerImage = ComponentFactory.Instance.creatComponentByStylename("asset.card.getFontBG");
         var _loc1_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("asset.card.getFont");
         _loc1_.text = LanguageMgr.GetTranslation("tank.view.award.getCard");
         var _loc5_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.bead.goodsNameBGII");
         _cardItem = ComponentFactory.Instance.creatCustomObject("card.cardCell");
         _cardItem.hideBg();
         _smeltBeadCell = ComponentFactory.Instance.creatCustomObject("bead.SmeltBeadCell");
         addChild(_smeltBeadCell);
         _smeltBeadCell.hideBg();
         _inputTxt = ComponentFactory.Instance.creatComponentByStylename("bead.numberTxt2");
         _cardNumberTxt = ComponentFactory.Instance.creatComponentByStylename("caddy.card.cardNumber");
         _goodsNameTxt = ComponentFactory.Instance.creatComponentByStylename("bead.goodsNameTxt");
         _turnSprite = ComponentFactory.Instance.creatCustomObject("bead.turnSprite");
         _turnBG = ComponentFactory.Instance.creatBitmap("asset.card.turnBG");
         _movie = ComponentFactory.Instance.creatComponentByStylename("bead.movieAsset");
         _loc7_ = 0;
         while(_loc7_ < _movie.movie.currentLabels.length)
         {
            if(_movie.movie.currentLabels[_loc7_].name == "endFrame")
            {
               _endFrame = _movie.movie.currentLabels[_loc7_].frame;
            }
            _loc7_++;
         }
         addChild(_bg);
         addChild(_bg1);
         addChild(_gridBGI);
         addChild(_gridBGII);
         addChild(_openBtn);
         addChild(_loc3_);
         addChild(_loc2_);
         addChild(_loc1_);
         addChild(_loc5_);
         addChild(_goodsNameTxt);
         addChild(_loc6_);
         addChild(_inputTxt);
         addChild(_cardItem);
         addChild(_turnSprite);
         _turnBG.x = _turnBG.width / -2;
         _turnBG.y = _turnBG.height * -1 + 5;
         _turnSprite.addChild(_turnBG);
         _startY = _turnSprite.y;
         addChild(_movie);
         _movie.movie.stop();
         _movie.visible = false;
         _autoCheck = ComponentFactory.Instance.creatComponentByStylename("AutoOpenButton");
         var _loc8_:* = SharedManager.Instance.autoOfferPack;
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
         PlayerManager.Instance.Self.Bag.addEventListener("update",_update);
         PlayerManager.Instance.Self.PropBag.addEventListener("update",_upPropdate);
         _movie.movie.addEventListener("enterFrame",__frameHandler);
         _openBtn.addEventListener("click",_openClick);
         _autoCheck.addEventListener("select",__selectedChanged);
         SocketManager.Instance.addEventListener(PkgEvent.format(208),__getSoul);
         PlayerManager.Instance.addEventListener("cards_name",__setGoodName);
      }
      
      private function removeEvents() : void
      {
         PlayerManager.Instance.Self.cardBagDic.removeEventListener("add",_updateCaddyBag);
         PlayerManager.Instance.Self.cardBagDic.removeEventListener("update",_updateCaddyBag);
         PlayerManager.Instance.Self.Bag.removeEventListener("update",_update);
         PlayerManager.Instance.Self.PropBag.removeEventListener("update",_upPropdate);
         SocketManager.Instance.removeEventListener(PkgEvent.format(208),__getSoul);
         PlayerManager.Instance.removeEventListener("cards_name",__setGoodName);
         _movie.movie.removeEventListener("enterFrame",__frameHandler);
         _openBtn.removeEventListener("click",_openClick);
         _autoCheck.removeEventListener("select",__selectedChanged);
      }
      
      private function _update(param1:BagEvent) : void
      {
         _cardItem.count = PlayerManager.Instance.Self.Bag.getItemCountByTemplateId(_cardID);
         _inputTxt.text = String(_cardItem.count);
      }
      
      private function _upPropdate(param1:BagEvent) : void
      {
         _smeltBeadCell.count = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(_cardID);
         _inputTxt.text = String(_smeltBeadCell.count);
      }
      
      private function _updateCaddyBag(param1:DictionaryEvent) : void
      {
         var _loc2_:int = haveCardNumber(int(_cardInfo.Property5));
         if(_loc2_ == _haveCardNumber)
         {
            _cardNumberTxt.text = (int(_cardNumberTxt.text) + _loc2_ - _haveCardNumber).toString();
            _haveCardNumber = _loc2_;
            moviePlay();
         }
      }
      
      private function __getSoul(param1:PkgEvent) : void
      {
         var _loc3_:* = undefined;
         var _loc6_:* = null;
         var _loc5_:int = 0;
         var _loc4_:PackageIn = param1.pkg;
         var _loc2_:Boolean = _loc4_.readBoolean();
         if(_loc2_)
         {
            _loc3_ = new Vector.<AwardsInfo>();
            _loc6_ = new AwardsInfo();
            _loc6_.zoneID = _loc4_.readInt();
            _loc6_.name = "";
            _loc5_ = haveCardNumber(int(_cardInfo.Property5));
            PlayerManager.Instance.Self.CardSoul = PlayerManager.Instance.Self.CardSoul + _loc6_.zoneID;
            _cardNumberTxt.text = (int(_cardNumberTxt.text) + _loc5_ - _haveCardNumber).toString();
            _haveCardNumber = _loc5_;
            mAwardSoul = _loc6_;
            moviePlay();
            _loc3_.push(_loc6_);
            CaddyModel.instance.addAwardsInfoByArr(_loc3_);
         }
      }
      
      private function __setGoodName(param1:Event) : void
      {
         info = PlayerManager.Instance.Self.cardInfo;
         _goodsNameTxt.text = info.templateInfo.Name;
         var _loc2_:String = LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.card");
         if(info.CardType == 1)
         {
            _goodsNameTxt.text = _goodsNameTxt.text + (LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.jin") + _loc2_);
         }
         else if(info.CardType == 2)
         {
            _goodsNameTxt.text = _goodsNameTxt.text + (LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.yin") + _loc2_);
         }
         else
         {
            _goodsNameTxt.text = _goodsNameTxt.text + (LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.tong") + _loc2_);
         }
      }
      
      private function _openClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         openImp();
      }
      
      private function __selectedChanged(param1:Event) : void
      {
         _localAutoOpen = _autoCheck.selected;
         SharedManager.Instance.autoOfferPack = _autoCheck.selected;
      }
      
      public function setCard(param1:int, param2:int) : void
      {
         _cardID = param1;
         _cardPlace = param2;
         _cardInfo = ItemManager.Instance.getTemplateById(_cardID);
         _cardItem.info = _cardInfo;
         _smeltBeadCell.info = ItemManager.Instance.getTemplateById(_cardID);
         if(_cardID == 112108 || _cardID == 112150)
         {
            _smeltBeadCell.count = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(_cardID);
            _inputTxt.text = String(_smeltBeadCell.count);
         }
         else
         {
            _cardItem.count = PlayerManager.Instance.Self.Bag.getItemCountByTemplateId(_cardID);
            _inputTxt.text = String(_cardItem.count);
         }
         _selectGoodsInfo = ItemManager.Instance.getTemplateById(_cardID);
         _haveCardNumber = haveCardNumber(int(_cardInfo.Property5));
         creatTweenMagnify();
      }
      
      private function haveCardNumber(param1:int) : int
      {
         var _loc3_:int = 0;
         var _loc2_:DictionaryData = PlayerManager.Instance.Self.cardBagDic;
         var _loc6_:int = 0;
         var _loc5_:* = _loc2_;
         for each(var _loc4_ in _loc2_)
         {
            if(_loc4_.TemplateID == param1)
            {
               _loc3_ = _loc3_ + _loc4_.Count;
            }
         }
         return _loc3_;
      }
      
      private function createSelectCell() : void
      {
         var _loc2_:Point = ComponentFactory.Instance.creatCustomObject("bead.selectCellSize");
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.beginFill(16777215,0);
         _loc1_.graphics.drawRect(0,0,_loc2_.x,_loc2_.y);
         _loc1_.graphics.endFill();
         _selectCell = new BaseCell(_loc1_);
         _selectSprite = ComponentFactory.Instance.creatCustomObject("bead.SelectSprite");
         _selectCell.x = _selectCell.width / -2;
         _selectCell.y = _selectCell.height / -2;
         _selectSprite.addChild(_selectCell);
         addChildAt(_selectSprite,getChildIndex(_movie));
         addChildAt(mSprite,getChildIndex(_movie));
         _selectSprite.visible = false;
         mSprite.visible = false;
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
         _selectSprite.x = 164;
         _selectSprite.y = 125;
         var _loc1_:int = 1;
         _selectSprite.scaleY = _loc1_;
         _selectSprite.scaleX = _loc1_;
         TweenLite.from(_selectSprite,0.7,{
            "scaleX":0.05,
            "scaleY":0.05,
            "y":320,
            "alpha":20,
            "onComplete":_moveOk,
            "ease":Elastic.easeOut
         });
      }
      
      private function _moveOk() : void
      {
         TweenLite.to(_selectSprite,0.3,{
            "scaleX":1.5,
            "scaleY":1.5,
            "repeat":1,
            "yoyo":true
         });
         TweenLite.to(_selectSprite,0.3,{
            "delay":0.3,
            "scaleX":0.1,
            "scaleY":0.1,
            "x":550,
            "y":360
         });
         winTime = setTimeout(_toMove,800);
      }
      
      private function _toMove() : void
      {
         TweenLite.killTweensOf(_selectSprite);
         TweenLite.killTweensOf(mAwardSoul);
         if(_selectCell)
         {
            _selectCell.info = null;
         }
         if(_selectSprite)
         {
            _selectSprite.visible = false;
            _selectSprite.x = 164;
            _selectSprite.y = 125;
            var _loc1_:int = 1;
            _selectSprite.scaleY = _loc1_;
            _selectSprite.scaleX = _loc1_;
         }
         if(mSprite)
         {
            mSprite.visible = false;
            ObjectUtils.disposeAllChildren(mSprite);
            _loc1_ = 1;
            mSprite.scaleY = _loc1_;
            mSprite.scaleX = _loc1_;
         }
         if(_goodsNameTxt)
         {
            _goodsNameTxt.text = "";
         }
         again();
      }
      
      private function openImp() : void
      {
         if(_cardItem)
         {
            if(haveCardNumber(int(_cardInfo.Property5)) >= 997)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.card.moreCard"));
               _openBtn.enable = true;
               return;
            }
            if(PlayerManager.Instance.Self.Grade < 20)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.giftSystem.openCardBox.text"));
               _openBtn.enable = true;
               return;
            }
            if(_cardItem.count > 0 && _cardInfo.CategoryID == 18)
            {
               _openBtn.enable = false;
               _localAutoOpen = SharedManager.Instance.autoOfferPack;
               SocketManager.Instance.out.sendOpenCardBox(getCardPlace(_cardPlace),1,getCardBagType(_cardPlace));
            }
            else if(_cardItem.count > 0 && _cardInfo.CategoryID == 66)
            {
               _openBtn.enable = false;
               _localAutoOpen = SharedManager.Instance.autoOfferPack;
               SocketManager.Instance.out.sendOpenSpecialCardBox(getCardPlace(_cardPlace),1,getCardBagType(_cardPlace));
            }
            else if(_smeltBeadCell.count > 0 && (_cardInfo.TemplateID == 112108 || _cardInfo.TemplateID == 112150 || _cardInfo.TemplateID == 1120538 || _cardInfo.TemplateID == 1120539))
            {
               _openBtn.enable = false;
               _localAutoOpen = SharedManager.Instance.autoOfferPack;
               SocketManager.Instance.out.sendOpenRandomBox(getRandomCardPlace(_cardPlace),1);
            }
            else
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.card.noCard"));
            }
         }
      }
      
      private function getCardBagType(param1:int) : int
      {
         var _loc2_:Array = PlayerManager.Instance.Self.Bag.findCellsByTempleteID(_cardID);
         var _loc5_:int = 0;
         var _loc4_:* = _loc2_;
         for each(var _loc3_ in _loc2_)
         {
            if(_loc3_.Place == param1)
            {
               return _loc3_.BagType;
            }
         }
         return _loc2_[0].BagType;
      }
      
      private function getCardPlace(param1:int) : int
      {
         var _loc2_:Array = PlayerManager.Instance.Self.Bag.findCellsByTempleteID(_cardID);
         var _loc5_:int = 0;
         var _loc4_:* = _loc2_;
         for each(var _loc3_ in _loc2_)
         {
            if(_loc3_.Place == param1)
            {
               return param1;
            }
         }
         return _loc2_[0].Place;
      }
      
      private function getRandomCardPlace(param1:int) : int
      {
         var _loc2_:Array = PlayerManager.Instance.Self.PropBag.findCellsByTempleteID(_cardID);
         var _loc5_:int = 0;
         var _loc4_:* = _loc2_;
         for each(var _loc3_ in _loc2_)
         {
            if(_loc3_.Place == param1)
            {
               return param1;
            }
         }
         return _loc2_[0].Place;
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
      
      private function __frameHandler(param1:Event) : void
      {
         if(_movie.movie.currentFrame == _endFrame)
         {
            if(!mAwardSoul)
            {
               _selectSprite.visible = true;
               if(_selectCell)
               {
                  _selectCell.info = _selectGoodsInfo;
               }
               creatTweenSelectMagnify();
            }
            else
            {
               mSprite.visible = true;
               if(_selectCell)
               {
                  _selectCell.info = _selectGoodsInfo;
               }
               createTweenSoulNum();
            }
            mAwardSoul = null;
         }
      }
      
      private function createTweenSoulNum() : void
      {
         SetSoulNumBmp(mAwardSoul.zoneID);
         mSprite.x = mSpriteX;
         mSprite.y = 120;
         var _loc1_:int = 1;
         mSprite.scaleY = _loc1_;
         mSprite.scaleX = _loc1_;
         TweenLite.from(mSprite,1,{
            "scaleX":0.05,
            "scaleY":0.05,
            "y":180,
            "alpha":20,
            "onComplete":_showOk,
            "ease":Elastic.easeOut
         });
      }
      
      private function _showOk() : void
      {
         if(!mSprite)
         {
            return;
         }
         TweenLite.to(mSprite,0.3,{
            "scaleX":1.3,
            "scaleY":1.3,
            "repeat":1,
            "yoyo":true
         });
         TweenLite.to(mSprite,0.5,{
            "scaleX":0,
            "scaleY":0,
            "x":mSpriteX,
            "y":80,
            "ease":Sine.easeIn
         });
         return;
         §§push(setTimeout(_toMove,600));
      }
      
      private function SetSoulNumBmp(param1:int) : void
      {
         var _loc5_:int = 0;
         var _loc6_:* = null;
         var _loc2_:* = null;
         var _loc4_:int = param1.toString().length;
         var _loc3_:int = Math.pow(10,_loc4_ - 1);
         while(param1 != 0)
         {
            _loc5_ = Math.floor(param1 / _loc3_);
            _loc6_ = ComponentFactory.Instance.creatBitmap("asset.card.soulNum" + _loc5_);
            _loc6_.x = mSprite.width;
            mSprite.addChild(_loc6_);
            param1 = param1 - _loc5_ * _loc3_;
            if(_loc3_ == 10 && param1 == 0)
            {
               _loc2_ = ComponentFactory.Instance.creatBitmap("asset.card.soulNum0");
               _loc2_.x = mSprite.width;
               mSprite.addChild(_loc2_);
            }
            _loc3_ = _loc3_ / 10;
         }
         var _loc7_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.card.soulNum");
         _loc7_.x = mSprite.width + 2;
         _loc7_.y = -5;
         mSprite.addChild(_loc7_);
         mSpriteX = Math.floor((315 - mSprite.width) / 2);
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
         _cardInfo = null;
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
         if(_cardItem)
         {
            ObjectUtils.disposeObject(_cardItem);
         }
         _cardItem = null;
         if(_smeltBeadCell)
         {
            ObjectUtils.disposeObject(_smeltBeadCell);
         }
         _smeltBeadCell = null;
         if(_cardNumberTxt)
         {
            ObjectUtils.disposeObject(_cardNumberTxt);
         }
         _cardNumberTxt = null;
         if(_autoCheck)
         {
            ObjectUtils.disposeObject(_autoCheck);
         }
         _autoCheck = null;
         if(mSprite)
         {
            ObjectUtils.disposeObject(mSprite);
         }
         mSprite = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
