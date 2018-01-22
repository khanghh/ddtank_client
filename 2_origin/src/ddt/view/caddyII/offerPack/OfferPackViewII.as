package ddt.view.caddyII.offerPack
{
   import bagAndInfo.cell.BaseCell;
   import com.greensock.TweenMax;
   import com.greensock.easing.Elastic;
   import com.pickgliss.effect.EffectManager;
   import com.pickgliss.effect.IEffect;
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.goods.ShopItemInfo;
   import ddt.events.BagEvent;
   import ddt.events.PkgEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SharedManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.view.caddyII.CaddyEvent;
   import ddt.view.caddyII.CaddyModel;
   import ddt.view.caddyII.LookTrophy;
   import ddt.view.caddyII.RightView;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.setTimeout;
   import store.view.ConsortiaRateManager;
   
   public class OfferPackViewII extends RightView
   {
      
      public static const OFFER_TURNSPRITE:int = 5;
      
      public static const SCALE_NUMBER:Number = 0.1;
      
      public static const SELECT_SCALE_NUMBER:Number = 0.05;
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _gridBGII:MovieImage;
      
      private var _openBtn:BaseButton;
      
      private var _lookTrophy:LookTrophy;
      
      private var _goodsNameTxt:FilterFrameText;
      
      private var _selectGoodsInfo:InventoryItemInfo;
      
      private var _effect:IEffect;
      
      private var _movie:MovieImage;
      
      private var _turnSprite:Sprite;
      
      private var _turnBG:ScaleFrameImage;
      
      private var _selectSprite:Sprite;
      
      private var _selectCell:BaseCell;
      
      private var _offerNumber:int;
      
      private var _packNumber:int;
      
      private var _selectNumber:int = -1;
      
      private var _endFrame:int;
      
      private var _startY:int;
      
      private var _consortiaManagerBtn:TextButton;
      
      private var _itemTempLateID:Array;
      
      private var _offerBack:ScaleBitmapImage;
      
      private var _offerField:FilterFrameText;
      
      private var _isItem:Boolean = true;
      
      private var _packItems:Array;
      
      private var _selectedPackItem:OfferPackItem;
      
      private var _itemBox:HBox;
      
      private var _localAutoOpen:Boolean;
      
      private var _offerShopList:Vector.<ShopItemInfo>;
      
      public function OfferPackViewII()
      {
         _itemTempLateID = [11252,11257,11258,11259,11260];
         _packItems = [];
         super();
         initView();
         initEvents();
         initOfferShopList();
      }
      
      private function initView() : void
      {
         var _loc9_:int = 0;
         var _loc8_:int = 0;
         var _loc12_:* = null;
         var _loc11_:* = null;
         _bg = ComponentFactory.Instance.creatComponentByStylename("caddy.rightBG");
         var _loc5_:ScaleBitmapImage = ComponentFactory.Instance.creatComponentByStylename("bead.rightGrid.goldBorder");
         _gridBGII = ComponentFactory.Instance.creatComponentByStylename("bead.rightGridBGI");
         var _loc3_:MovieImage = ComponentFactory.Instance.creatComponentByStylename("bead.rightGridBGII");
         _openBtn = ComponentFactory.Instance.creatComponentByStylename("caddy.OpenBtn");
         _lookTrophy = ComponentFactory.Instance.creatCustomObject("caddyII.LookTrophy");
         var _loc4_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.bead.openBG");
         var _loc13_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.bead.goodsNameBGII");
         _goodsNameTxt = ComponentFactory.Instance.creatComponentByStylename("bead.goodsNameTxt");
         var _loc10_:Point = ComponentFactory.Instance.creatCustomObject("offer.turnCellSize");
         var _loc6_:Shape = new Shape();
         _loc6_.graphics.beginFill(16777215,0);
         _loc6_.graphics.drawRect(0,0,_loc10_.x,_loc10_.y);
         _loc6_.graphics.endFill();
         _turnBG = ComponentFactory.Instance.creatComponentByStylename("offer.turnBG");
         _turnSprite = ComponentFactory.Instance.creatCustomObject("bead.turnSprite");
         _movie = ComponentFactory.Instance.creatComponentByStylename("bead.movieAsset");
         _loc9_ = 0;
         while(_loc9_ < _movie.movie.currentLabels.length)
         {
            if(_movie.movie.currentLabels[_loc9_].name == "endFrame")
            {
               _endFrame = _movie.movie.currentLabels[_loc9_].frame;
            }
            _loc9_++;
         }
         addChild(_bg);
         addChild(_gridBGII);
         addChild(_loc3_);
         addChild(_openBtn);
         addChild(_loc4_);
         addChild(_loc13_);
         addChild(_loc5_);
         addChild(_goodsNameTxt);
         addChild(_turnSprite);
         _turnBG.x = _turnBG.width / -2;
         _turnBG.y = _turnBG.height * -1 + 5;
         _turnSprite.addChild(_turnBG);
         _startY = _turnSprite.y;
         addChild(_movie);
         _movie.movie.stop();
         _movie.visible = false;
         _autoCheck = ComponentFactory.Instance.creatComponentByStylename("AutoOpenButton");
         _autoCheck.text = LanguageMgr.GetTranslation("tank.view.award.auto");
         var _loc14_:* = SharedManager.Instance.autoOfferPack;
         _autoCheck.selected = _loc14_;
         _localAutoOpen = _loc14_;
         addChild(_autoCheck);
         creatEffect();
         createSelectCell();
         offerNumber = PlayerManager.Instance.Self.Offer;
         _itemBox = ComponentFactory.Instance.creatComponentByStylename("offer.oferItemBox");
         var _loc7_:int = _itemTempLateID.length;
         _loc8_ = 0;
         while(_loc8_ < _loc7_)
         {
            _loc12_ = ItemManager.Instance.getTemplateById(_itemTempLateID[_loc8_]);
            _loc11_ = ComponentFactory.Instance.creatCustomObject("ddt.view.caddyII.offerPack.OfferPackItem");
            _loc11_.info = _loc12_;
            _itemBox.addChild(_loc11_);
            _packItems.push(_loc11_);
            _loc11_.addEventListener("click",__packItemClick);
            _loc8_++;
         }
         addChild(_itemBox);
         setupSelectedPack(CaddyModel.instance.offerType);
         _offerBack = ComponentFactory.Instance.creatComponentByStylename("offer.BackBG");
         var _loc2_:Scale9CornerImage = ComponentFactory.Instance.creatComponentByStylename("caddy.BackCountBg");
         var _loc1_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("caddy.BackCountTiptxt");
         _loc1_.text = LanguageMgr.GetTranslation("tank.view.offer.NowHaveOffer");
         addChild(_offerBack);
         addChild(_loc1_);
         addChild(_loc2_);
         _offerField = ComponentFactory.Instance.creatComponentByStylename("ddt.view.caddy.OfferPack.OfferField");
         addChild(_offerField);
         _offerField.text = String(PlayerManager.Instance.Self.Offer);
         if(PlayerManager.Instance.Self.ConsortiaID != 0)
         {
            _consortiaManagerBtn = ComponentFactory.Instance.creat("offerPack.consortiaManagerBtn");
            _consortiaManagerBtn.text = LanguageMgr.GetTranslation("consortion.shop.manager.Text");
            addChild(_consortiaManagerBtn);
         }
      }
      
      public function setupSelectedPack(param1:int) : void
      {
         var _loc2_:OfferPackItem = _packItems[param1];
         selectedItem = _loc2_;
      }
      
      private function __packItemClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:OfferPackItem = param1.currentTarget as OfferPackItem;
         selectedItem = _loc2_;
         if(_loc2_ && _loc2_.count <= 0)
         {
            _localAutoOpen = false;
            _quickBuy(null);
         }
      }
      
      private function initOfferShopList() : void
      {
         var _loc3_:int = 0;
         var _loc1_:* = undefined;
         _offerShopList = new Vector.<ShopItemInfo>();
         _loc3_ = 1;
         while(_loc3_ < 6)
         {
            _loc1_ = ShopManager.Instance.consortiaShopLevelTemplates(_loc3_);
            var _loc5_:int = 0;
            var _loc4_:* = _loc1_;
            for each(var _loc2_ in _loc1_)
            {
               if(_loc2_.TemplateID == 11252 || _loc2_.TemplateID == 11257 || _loc2_.TemplateID == 11258 || _loc2_.TemplateID == 11259 || _loc2_.TemplateID == 11260)
               {
                  _offerShopList.push(_loc2_);
               }
            }
            _loc3_++;
         }
      }
      
      override public function get openBtnEnable() : Boolean
      {
         return _openBtn.enable;
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
         _selectSprite.visible = false;
      }
      
      private function initEvents() : void
      {
         PlayerManager.Instance.Self.addEventListener("propertychange",__changeProperty);
         PlayerManager.Instance.Self.PropBag.addEventListener("update",_bagUpdate);
         _openBtn.addEventListener("click",_openClick);
         _movie.movie.addEventListener("enterFrame",__frameHandler);
         _autoCheck.addEventListener("select",__selectedChanged);
         if(_consortiaManagerBtn != null)
         {
            _consortiaManagerBtn.addEventListener("click",__consortiaMgrClick);
         }
         SocketManager.Instance.addEventListener(PkgEvent.format(28),__packComplete);
         ConsortiaRateManager.instance.addEventListener("loadComplete_consortia",__changeConsortia);
      }
      
      private function __selectedChanged(param1:Event) : void
      {
         _localAutoOpen = _autoCheck.selected;
         SharedManager.Instance.autoOfferPack = _autoCheck.selected;
      }
      
      private function __changeConsortia(param1:Event) : void
      {
         if(PlayerManager.Instance.Self.ConsortiaID != 0)
         {
            if(_consortiaManagerBtn == null)
            {
               _consortiaManagerBtn = ComponentFactory.Instance.creat("offerPack.consortiaManagerBtn");
               _consortiaManagerBtn.text = LanguageMgr.GetTranslation("consortion.shop.manager.Text");
               addChild(_consortiaManagerBtn);
            }
            _consortiaManagerBtn.visible = true;
         }
         else if(_consortiaManagerBtn)
         {
            _consortiaManagerBtn.visible = false;
         }
      }
      
      private function __consortiaMgrClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         ConsortionModelManager.Instance.alertManagerFrame();
      }
      
      private function __packComplete(param1:PkgEvent) : void
      {
         moviePlay();
      }
      
      private function removeEvents() : void
      {
         PlayerManager.Instance.Self.removeEventListener("propertychange",__changeProperty);
         PlayerManager.Instance.Self.PropBag.removeEventListener("update",_bagUpdate);
         _openBtn.removeEventListener("click",_openClick);
         _movie.movie.removeEventListener("enterFrame",__frameHandler);
         _autoCheck.removeEventListener("select",__selectedChanged);
         if(_consortiaManagerBtn != null)
         {
            _consortiaManagerBtn.removeEventListener("click",__consortiaMgrClick);
         }
         var _loc1_:OfferPackItem = _packItems.shift();
         while(_loc1_)
         {
            _loc1_.removeEventListener("click",__packItemClick);
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = _packItems.shift();
         }
         SocketManager.Instance.removeEventListener(PkgEvent.format(28),__packComplete);
         ConsortiaRateManager.instance.removeEventListener("loadComplete_consortia",__changeConsortia);
      }
      
      private function openImp() : void
      {
         if(_selectedPackItem)
         {
            if(_selectedPackItem.count > 0)
            {
               if(CaddyModel.instance.bagInfo.itemNumber >= 25)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.caddy.FullBag"));
               }
               else
               {
                  _openBtn.enable = false;
                  _localAutoOpen = SharedManager.Instance.autoOfferPack;
                  SocketManager.Instance.out.sendOpenDead(CaddyModel.instance.bagInfo.BagType,-3,_selectedPackItem.info.TemplateID);
               }
            }
            else
            {
               _quickBuy(null);
            }
         }
      }
      
      private function _openClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         openImp();
      }
      
      private function _lookClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      private function _quickBuy(param1:MouseEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         if(_offerShopList.length > 0)
         {
            SoundManager.instance.play("008");
            _loc3_ = ComponentFactory.Instance.creatCustomObject("offer.OfferQuickBuyFrame");
            _loc3_.offShopList = _offerShopList;
            _loc2_ = _packItems.indexOf(_selectedPackItem);
            if(_loc2_ >= 0)
            {
               _loc3_.show(_loc2_);
            }
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.game.GameView.GiftBattleTxt"));
         }
      }
      
      private function __changeProperty(param1:PlayerPropertyEvent) : void
      {
         if(param1.changedProperties["Offer"])
         {
            offerNumber = PlayerManager.Instance.Self.Offer;
         }
      }
      
      private function _bagUpdate(param1:BagEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _packItems;
         for each(var _loc2_ in _packItems)
         {
            _loc2_.count = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(_loc2_.info.TemplateID);
         }
      }
      
      private function __frameHandler(param1:Event) : void
      {
         if(_isItem)
         {
            if(_movie.movie.currentFrame == _endFrame)
            {
               _selectSprite.visible = true;
               _goodsNameTxt.text = _selectGoodsInfo.Name;
               creatTweenSelectMagnify();
            }
         }
         else if(_movie.movie.currentFrame == _movie.movie.totalFrames)
         {
            movieComplete();
         }
      }
      
      private function __buttonClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      private function __itemClick(param1:ListItemEvent) : void
      {
         SoundManager.instance.play("008");
         selectNumber = param1.index;
      }
      
      private function creatTweenMagnify() : void
      {
         TweenMax.killTweensOf(_turnSprite);
         var _loc1_:int = 1;
         _turnSprite.scaleY = _loc1_;
         _turnSprite.scaleX = _loc1_;
         _turnSprite.y = _startY;
         TweenMax.from(_turnSprite,0.5,{
            "scaleX":0.1,
            "scaleY":0.1
         });
         TweenMax.to(_turnSprite,0.4,{
            "delay":0.5,
            "y":_startY + 4,
            "repeat":-1,
            "yoyo":true
         });
      }
      
      private function creatTweenSelectMagnify() : void
      {
         TweenMax.from(_selectSprite,0.7,{
            "scaleX":0.05,
            "scaleY":0.05,
            "y":320,
            "alpha":20,
            "onComplete":_moveOk,
            "ease":Elastic.easeOut
         });
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
            _goodsNameTxt.text = _selectedPackItem.info.Name;
         }
      }
      
      public function set offerNumber(param1:int) : void
      {
         _offerNumber = param1;
         if(_offerField)
         {
            _offerField.text = String(_offerNumber);
         }
      }
      
      public function get offerNumber() : int
      {
         return _offerNumber;
      }
      
      public function set packNumber(param1:int) : void
      {
         _packNumber = param1;
      }
      
      public function get packNumber() : int
      {
         return _packNumber;
      }
      
      public function set selectNumber(param1:int) : void
      {
         if(_selectNumber == param1)
         {
            return;
         }
         _selectNumber = param1;
         CaddyModel.instance.offerType = _itemTempLateID[_selectNumber];
         _bagUpdate(null);
         _goodsNameTxt.text = _selectedPackItem.info.Name;
         _turnBG.setFrame(selectNumber + 1);
         EffectManager.Instance.removeEffect(_effect);
         creatTweenMagnify();
         creatEffect();
      }
      
      public function get selectNumber() : int
      {
         return _selectNumber;
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
      
      override public function setSelectGoodsInfo(param1:InventoryItemInfo) : void
      {
         _selectGoodsInfo = param1;
         _selectCell.info = _selectGoodsInfo;
         moviePlay(true);
      }
      
      private function moviePlay(param1:Boolean = false) : void
      {
         _isItem = param1;
         SoundManager.instance.play("139");
         _openBtn.enable = false;
         _turnSprite.visible = false;
         _movie.visible = true;
         _movie.movie.play();
         if(_isItem)
         {
            _startTurn();
         }
         else
         {
            setTimeout(again,1000);
         }
      }
      
      private function movieComplete() : void
      {
         _turnSprite.visible = true;
         _movie.visible = false;
         _movie.movie.gotoAndStop(1);
         _selectSprite.visible = false;
         _openBtn.enable = true;
      }
      
      private function _startTurn() : void
      {
         var _loc1_:CaddyEvent = new CaddyEvent("caddy_start_turn");
         _loc1_.info = _selectGoodsInfo;
         dispatchEvent(_loc1_);
      }
      
      public function get selectedItem() : OfferPackItem
      {
         return _selectedPackItem;
      }
      
      public function set selectedItem(param1:OfferPackItem) : void
      {
         if(_selectedPackItem == param1)
         {
            return;
         }
         var _loc2_:OfferPackItem = _selectedPackItem;
         _selectedPackItem = param1;
         if(_selectedPackItem)
         {
            _selectedPackItem.selected = true;
            CaddyModel.instance.offerType = _selectedPackItem.info.TemplateID;
            _bagUpdate(null);
            _goodsNameTxt.text = _selectedPackItem.info.Name;
            _turnBG.setFrame(_packItems.indexOf(_selectedPackItem) + 1);
            EffectManager.Instance.removeEffect(_effect);
            creatTweenMagnify();
            creatEffect();
         }
         if(_loc2_)
         {
            _loc2_.selected = false;
         }
      }
      
      override public function dispose() : void
      {
         removeEvents();
         TweenMax.killTweensOf(_turnSprite);
         TweenMax.killTweensOf(_selectSprite);
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
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
         if(_lookTrophy)
         {
            ObjectUtils.disposeObject(_lookTrophy);
         }
         _lookTrophy = null;
         if(_goodsNameTxt)
         {
            ObjectUtils.disposeObject(_goodsNameTxt);
         }
         _goodsNameTxt = null;
         if(_movie)
         {
            _movie.movie.stop();
            ObjectUtils.disposeObject(_movie);
            _movie = null;
         }
         if(_turnSprite)
         {
            ObjectUtils.disposeObject(_turnSprite);
         }
         _turnSprite = null;
         if(_turnBG)
         {
            ObjectUtils.disposeObject(_turnBG);
         }
         _turnBG = null;
         if(_selectSprite)
         {
            ObjectUtils.disposeObject(_selectSprite);
         }
         _selectSprite = null;
         if(_selectCell)
         {
            ObjectUtils.disposeObject(_selectCell);
         }
         _selectCell = null;
         if(_effect)
         {
            ObjectUtils.disposeObject(_effect);
         }
         _effect = null;
         ObjectUtils.disposeObject(_autoCheck);
         _autoCheck = null;
         if(_itemBox)
         {
            ObjectUtils.disposeObject(_itemBox);
         }
         _itemBox = null;
         if(_offerBack)
         {
            ObjectUtils.disposeObject(_offerBack);
         }
         _offerBack = null;
         if(_offerField)
         {
            ObjectUtils.disposeObject(_offerField);
         }
         _offerField = null;
         if(_consortiaManagerBtn)
         {
            ObjectUtils.disposeObject(_consortiaManagerBtn);
         }
         _consortiaManagerBtn = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
