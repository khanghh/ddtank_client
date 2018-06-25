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
   
   public class CardSoulView extends RightView
   {
      
      public static var _instance:CardSoulView;
      
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
      
      public function CardSoulView()
      {
         mSprite = new Sprite();
         super();
         initView();
         initEvents();
      }
      
      public static function get instance() : CardSoulView
      {
         if(_instance == null)
         {
            _instance = new CardSoulView();
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
         getFont.text = LanguageMgr.GetTranslation("tank.view.award.getCardSoul");
         var goodsNameBG:Bitmap = ComponentFactory.Instance.creatBitmap("asset.bead.goodsNameBGII");
         _cardItem = ComponentFactory.Instance.creatCustomObject("card.cardCell");
         _cardItem.hideBg();
         _smeltBeadCell = ComponentFactory.Instance.creatCustomObject("bead.SmeltBeadCell");
         addChild(_smeltBeadCell);
         _smeltBeadCell.hideBg();
         _inputTxt = ComponentFactory.Instance.creatComponentByStylename("bead.numberTxt2");
         _cardNumberTxt = ComponentFactory.Instance.creatComponentByStylename("caddy.card.cardNumber");
         _goodsNameTxt = ComponentFactory.Instance.creatComponentByStylename("bead.goodsNameTxt");
         _turnSprite = ComponentFactory.Instance.creatCustomObject("bead.turnSprite");
         _turnBG = ComponentFactory.Instance.creatBitmap("asset.cardSoul.turnBG");
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
      
      private function _update(e:BagEvent) : void
      {
         _cardItem.count = PlayerManager.Instance.Self.Bag.getItemCountByTemplateId(_cardID);
         _inputTxt.text = String(_cardItem.count);
      }
      
      private function _upPropdate(event:BagEvent) : void
      {
         _smeltBeadCell.count = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(_cardID);
         _inputTxt.text = String(_smeltBeadCell.count);
      }
      
      private function _updateCaddyBag(e:DictionaryEvent) : void
      {
         var number:int = haveCardNumber(int(_cardInfo.Property5));
         if(number == _haveCardNumber)
         {
            _cardNumberTxt.text = (int(_cardNumberTxt.text) + number - _haveCardNumber).toString();
            _haveCardNumber = number;
            moviePlay();
         }
      }
      
      private function __getSoul(event:PkgEvent) : void
      {
         var tempArr:* = undefined;
         var info:* = null;
         var number:int = 0;
         var pkg:PackageIn = event.pkg;
         var b:Boolean = pkg.readBoolean();
         if(b)
         {
            tempArr = new Vector.<AwardsInfo>();
            info = new AwardsInfo();
            info.zoneID = pkg.readInt();
            info.name = "";
            number = haveCardNumber(int(_cardInfo.Property5));
            PlayerManager.Instance.Self.CardSoul = PlayerManager.Instance.Self.CardSoul + info.zoneID;
            _cardNumberTxt.text = (int(_cardNumberTxt.text) + number - _haveCardNumber).toString();
            _haveCardNumber = number;
            mAwardSoul = info;
            moviePlay();
            tempArr.push(info);
            CaddyModel.instance.addAwardsInfoByArr(tempArr);
         }
      }
      
      private function __setGoodName(event:Event) : void
      {
         info = PlayerManager.Instance.Self.cardInfo;
         _goodsNameTxt.text = info.templateInfo.Name;
         var card:String = LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.card");
         if(info.CardType == 1)
         {
            _goodsNameTxt.text = _goodsNameTxt.text + (LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.jin") + card);
         }
         else if(info.CardType == 2)
         {
            _goodsNameTxt.text = _goodsNameTxt.text + (LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.yin") + card);
         }
         else if(info.CardType == 4)
         {
            _goodsNameTxt.text = _goodsNameTxt.text + (LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.baijin") + card);
         }
         else
         {
            _goodsNameTxt.text = _goodsNameTxt.text + (LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.tong") + card);
         }
      }
      
      private function _openClick(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         openImp();
      }
      
      private function __selectedChanged(e:Event) : void
      {
         _localAutoOpen = _autoCheck.selected;
         SharedManager.Instance.autoOfferPack = _autoCheck.selected;
      }
      
      public function setCard(val:int, place:int) : void
      {
         _cardID = val;
         _cardPlace = place;
         _cardInfo = ItemManager.Instance.getTemplateById(_cardID);
         _cardItem.info = _cardInfo;
         _smeltBeadCell.info = ItemManager.Instance.getTemplateById(_cardID);
         if(_cardID == 112108)
         {
            _smeltBeadCell.count = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(_cardID);
            _inputTxt.text = String(_smeltBeadCell.count);
         }
         else if(_cardID == 112150)
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
         shape.graphics.beginFill(16777215,0);
         shape.graphics.drawRect(0,0,size.x,size.y);
         shape.graphics.endFill();
         _selectCell = new BaseCell(shape);
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
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.card.noCardSoulBox"));
            }
         }
      }
      
      private function getCardBagType(place:int) : int
      {
         var arr:Array = PlayerManager.Instance.Self.Bag.findCellsByTempleteID(_cardID);
         var _loc5_:int = 0;
         var _loc4_:* = arr;
         for each(var info in arr)
         {
            if(info.Place == place)
            {
               return info.BagType;
            }
         }
         return arr[0].BagType;
      }
      
      private function getCardPlace(place:int) : int
      {
         var arr:Array = PlayerManager.Instance.Self.Bag.findCellsByTempleteID(_cardID);
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
         var arr:Array = PlayerManager.Instance.Self.PropBag.findCellsByTempleteID(_cardID);
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
      
      private function SetSoulNumBmp(pSoulNum:int) : void
      {
         var temp:int = 0;
         var tempBmp:* = null;
         var zeroBmp:* = null;
         var zeroBmp1:* = null;
         var zeroBmp2:* = null;
         var vLength:int = pSoulNum.toString().length;
         var vMax:int = Math.pow(10,vLength - 1);
         while(pSoulNum != 0)
         {
            temp = Math.floor(pSoulNum / vMax);
            tempBmp = ComponentFactory.Instance.creatBitmap("asset.card.soulNum" + temp);
            tempBmp.x = mSprite.width;
            mSprite.addChild(tempBmp);
            pSoulNum = pSoulNum - temp * vMax;
            if(vMax == 10 && pSoulNum == 0)
            {
               zeroBmp = ComponentFactory.Instance.creatBitmap("asset.card.soulNum0");
               zeroBmp.x = mSprite.width;
               mSprite.addChild(zeroBmp);
            }
            else if(vMax == 100 && pSoulNum == 0)
            {
               zeroBmp1 = ComponentFactory.Instance.creatBitmap("asset.card.soulNum0");
               zeroBmp1.x = mSprite.width;
               mSprite.addChild(zeroBmp1);
               zeroBmp2 = ComponentFactory.Instance.creatBitmap("asset.card.soulNum0");
               zeroBmp2.x = mSprite.width;
               mSprite.addChild(zeroBmp2);
            }
            vMax = vMax / 10;
         }
         var hunStr:Bitmap = ComponentFactory.Instance.creatBitmap("asset.card.soulNum");
         hunStr.x = mSprite.width + 2;
         hunStr.y = -5;
         mSprite.addChild(hunStr);
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
