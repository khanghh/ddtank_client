package ddt.view.caddyII.bead
{
   import bagAndInfo.cell.BaseCell;
   import com.greensock.TweenMax;
   import com.greensock.easing.Elastic;
   import com.pickgliss.effect.EffectManager;
   import com.pickgliss.effect.IEffect;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.bagStore.BagStore;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
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
   import ddt.view.caddyII.LookTrophy;
   import ddt.view.caddyII.RightView;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.setTimeout;
   
   public class BeadViewII extends RightView
   {
      
      public static const BeadFromSmelt:int = -1;
      
      public static const Bead:int = 1;
      
      public static const OFFER_TURNSPRITE:int = 5;
      
      public static const SCALE_NUMBER:Number = 0;
      
      public static const SELECT_SCALE_NUMBER:Number = 0;
       
      
      private var _titleTipTxt:FilterFrameText;
      
      private var _bg:ScaleBitmapImage;
      
      private var _gridBGI:MovieImage;
      
      private var _gridBGII:MovieImage;
      
      private var _openBtn:BaseButton;
      
      private var _itemContainer:HBox;
      
      private var _itemGroup:SelectedButtonGroup;
      
      private var _turnBG:ScaleFrameImage;
      
      private var _movie:MovieImage;
      
      private var _goodsNameTxt:FilterFrameText;
      
      private var _selectCell:BaseCell;
      
      private var _selectSprite:Sprite;
      
      private var _lookTrophy:LookTrophy;
      
      private var _selectGoodsInfo:InventoryItemInfo;
      
      private var _selectItem:int = -1;
      
      private var _turnSprite:Sprite;
      
      private var _effect:IEffect;
      
      private var _startY:Number;
      
      private var _endFrame:int;
      
      private var _clickNumber:int;
      
      private var _turnItemShape:Shape;
      
      private var _cellId:Array;
      
      private var _smeltBeadCell:BeadItem;
      
      private var _beadQuickBuyBtn:BaseButton;
      
      private var _beadQuickBuyBtnText1:FilterFrameText;
      
      private var _turnCell:BeadCell;
      
      private var _hasCell:Boolean = false;
      
      private var _localAutoOpen:Boolean;
      
      private var _inputBg:Image;
      
      private var _font:FilterFrameText;
      
      private var _inputTxt:FilterFrameText;
      
      private var _buyType:int = 0;
      
      public function BeadViewII()
      {
         _cellId = [311500,312500,313500];
         super();
         initView();
         initEvents();
      }
      
      public function get openBtn() : BaseButton
      {
         return _openBtn;
      }
      
      private function updateTitleTip(val:int) : void
      {
         var _loc2_:* = val;
         if(112150 !== _loc2_)
         {
            if(112108 !== _loc2_)
            {
               _titleTipTxt.text = LanguageMgr.GetTranslation("tank.view.bead.rightTitleTip");
            }
            else
            {
               _titleTipTxt.text = LanguageMgr.GetTranslation("tank.view.bead.rightTitleTip3");
            }
         }
         else
         {
            _titleTipTxt.text = LanguageMgr.GetTranslation("tank.view.bead.rightTitleTip2");
         }
      }
      
      override public function setType(val:int) : void
      {
         _type = val;
         _buyType = val;
         updateTitleTip(val);
         if(EquipType.isBeadFromSmeltByID(_type) || _type == 112150)
         {
            clearCell();
            createBead();
            updateBead();
            _beadQuickBuyBtn.visible = false;
            _inputBg.visible = true;
            _font.visible = true;
            _inputTxt.visible = true;
            _inputBg.visible = true;
            _font.visible = true;
            _inputTxt.visible = true;
         }
         else if(_type == 112108)
         {
            clearCell();
            createBead();
            updateBead();
            _beadQuickBuyBtn.visible = false;
            _inputBg.visible = true;
            _font.visible = true;
            _inputTxt.visible = true;
         }
         else
         {
            clearBead();
            createCell();
            _inputBg.visible = false;
            _font.visible = false;
            _inputTxt.visible = false;
         }
      }
      
      private function createCell() : void
      {
         var i:int = 0;
         var cell:* = null;
         if(_hasCell)
         {
            return;
         }
         i = 0;
         while(i < _cellId.length)
         {
            cell = new BeadItem();
            cell.info = ItemManager.Instance.getTemplateById(_cellId[i]);
            cell.buttonMode = true;
            cell.addEventListener("click",_itemClick);
            _itemContainer.addChild(cell);
            _itemGroup.addSelectItem(cell);
            cell.count = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(_cellId[i]);
            i++;
         }
         _hasCell = true;
      }
      
      private function updateCell() : void
      {
         var i:int = 0;
         for(i = 0; i < _itemContainer.numChildren; )
         {
            (_itemContainer.getChildAt(i) as BeadItem).count = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(_cellId[i]);
            i++;
         }
      }
      
      private function clearCell() : void
      {
         var item:* = null;
         while(_itemContainer.numChildren > 0)
         {
            item = _itemContainer.getChildAt(0) as BeadItem;
            item.removeEventListener("click",_itemClick);
            ObjectUtils.disposeObject(item);
            _itemGroup.removeSelectItem(item);
            item = null;
         }
         _hasCell = false;
      }
      
      private function createBead() : void
      {
         _smeltBeadCell = ComponentFactory.Instance.creatCustomObject("bead.SmeltBeadCell");
         _smeltBeadCell.mouseEnabled = false;
         _smeltBeadCell.info = ItemManager.Instance.getTemplateById(_type);
         addChild(_smeltBeadCell);
         _smeltBeadCell.hideBg();
         _turnCell.info = ItemManager.Instance.getTemplateById(_type);
         creatTweenMagnify();
      }
      
      private function updateBead() : void
      {
         _smeltBeadCell.count = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(_type);
         _inputTxt.text = String(_smeltBeadCell.count);
      }
      
      private function clearBead() : void
      {
         if(_smeltBeadCell)
         {
            ObjectUtils.disposeObject(_smeltBeadCell);
            _smeltBeadCell = null;
         }
      }
      
      private function updateItemShape() : void
      {
         _turnCell.x = _turnCell.width / -2;
         _turnCell.y = -89;
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var goldBorder:ScaleBitmapImage = ComponentFactory.Instance.creatComponentByStylename("bead.rightGrid.goldBorder");
         _titleTipTxt = ComponentFactory.Instance.creatComponentByStylename("bead.titleTipTxt");
         _titleTipTxt.text = LanguageMgr.GetTranslation("tank.view.bead.rightTitleTip");
         _itemGroup = new SelectedButtonGroup();
         _bg = ComponentFactory.Instance.creatComponentByStylename("caddy.rightBG");
         _inputBg = ComponentFactory.Instance.creatComponentByStylename("bead.numInput.bg2");
         _gridBGI = ComponentFactory.Instance.creatComponentByStylename("bead.rightGridBGI");
         _gridBGII = ComponentFactory.Instance.creatComponentByStylename("bead.rightGridBGII");
         _openBtn = ComponentFactory.Instance.creatComponentByStylename("caddy.OpenBtn");
         _itemContainer = ComponentFactory.Instance.creatComponentByStylename("bead.selectBox");
         var openBG:Bitmap = ComponentFactory.Instance.creatBitmap("asset.bead.openBG");
         _font = ComponentFactory.Instance.creatComponentByStylename("bead.fontII");
         _font.text = LanguageMgr.GetTranslation("tank.view.award.bagHaving");
         var goodsNameBG:Bitmap = ComponentFactory.Instance.creatBitmap("asset.bead.goodsNameBGII");
         _inputTxt = ComponentFactory.Instance.creatComponentByStylename("bead.numberTxt2");
         _goodsNameTxt = ComponentFactory.Instance.creatComponentByStylename("bead.goodsNameTxt");
         _turnSprite = ComponentFactory.Instance.creatCustomObject("bead.turnSprite");
         _turnBG = ComponentFactory.Instance.creatComponentByStylename("bead.turnBG");
         _turnCell = new BeadCell();
         _movie = ComponentFactory.Instance.creatComponentByStylename("bead.movieAsset");
         for(i = 0; i < _movie.movie.currentLabels.length; )
         {
            if(_movie.movie.currentLabels[i].name == "endFrame")
            {
               _endFrame = _movie.movie.currentLabels[i].frame;
            }
            i++;
         }
         _beadQuickBuyBtn = ComponentFactory.Instance.creatComponentByStylename("caddy.bead.QuickBuyButton");
         _beadQuickBuyBtnText1 = ComponentFactory.Instance.creatComponentByStylename("bead.quickBuyBtn.text");
         _beadQuickBuyBtnText1.text = LanguageMgr.GetTranslation("store.Strength.BuyButtonText");
         addChild(_bg);
         addChild(_inputBg);
         addChild(_gridBGI);
         addChild(_gridBGII);
         addChild(_openBtn);
         addChild(_itemContainer);
         addChild(openBG);
         addChild(_font);
         addChild(goodsNameBG);
         addChild(_inputTxt);
         addChild(goldBorder);
         addChild(_titleTipTxt);
         addChild(_goodsNameTxt);
         _turnSprite.addChild(_turnCell);
         addChild(_turnSprite);
         _beadQuickBuyBtn.addChild(_beadQuickBuyBtnText1);
         _beadQuickBuyBtn.addChild(_beadQuickBuyBtnText1);
         _autoCheck = ComponentFactory.Instance.creatComponentByStylename("AutoOpenButton");
         var _loc5_:* = SharedManager.Instance.autoBead;
         _autoCheck.selected = _loc5_;
         _localAutoOpen = _loc5_;
         _autoCheck.text = LanguageMgr.GetTranslation("tank.view.award.auto");
         addChild(_autoCheck);
         _turnBG.setFrame(1);
         _startY = _turnSprite.y;
         createSelectCell();
         addChild(_movie);
         _movie.movie.stop();
         _movie.visible = false;
         updateItemShape();
         creatEffect();
         createCell();
      }
      
      private function initEvents() : void
      {
         PlayerManager.Instance.Self.PropBag.addEventListener("update",_update);
         CaddyModel.instance.addEventListener("beadType_change",_beadTypeChange);
         _openBtn.addEventListener("click",_openClick);
         _movie.movie.addEventListener("enterFrame",__frameHandler);
         _beadQuickBuyBtn.addEventListener("click",__beadQuickBuy);
         _autoCheck.addEventListener("select",__selectedChanged);
      }
      
      private function __selectedChanged(event:Event) : void
      {
         _localAutoOpen = _autoCheck.selected;
         SharedManager.Instance.autoBead = _autoCheck.selected;
      }
      
      private function __beadQuickBuy(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         showQuickBuyBead();
      }
      
      private function showQuickBuyBead() : void
      {
         var tmpSelectedIndex:int = 0;
         var cardQuick:* = null;
         if(_type != 112150 && _type != 112108)
         {
            tmpSelectedIndex = -1;
            if(_buyType == 0 || EquipType.isAttackBeadFromSmeltByID(_buyType))
            {
               tmpSelectedIndex = 0;
            }
            else if(_buyType == 1 || EquipType.isDefenceBeadFromSmeltByID(_buyType))
            {
               tmpSelectedIndex = 1;
            }
            else if(_buyType == 2 || EquipType.isAttributeBeadFromSmeltByID(_buyType))
            {
               tmpSelectedIndex = 2;
            }
            else
            {
               tmpSelectedIndex = _clickNumber;
            }
            openShortcutBuyFrame(tmpSelectedIndex);
         }
         else
         {
            cardQuick = ComponentFactory.Instance.creatCustomObject("bead.CardBoxQuickBuy");
            LayerManager.Instance.addToLayer(cardQuick,2,true,1);
         }
      }
      
      private function openShortcutBuyFrame(tmpSelectedIndex:int) : void
      {
         BagStore.instance.showShortcutBuyFrame(_cellId,false,LanguageMgr.GetTranslation("tank.view.bead.quickBuyTitle"),5,tmpSelectedIndex,75);
      }
      
      private function __buyGoods(event:Event) : void
      {
      }
      
      private function removeEvents() : void
      {
         PlayerManager.Instance.Self.PropBag.removeEventListener("update",_update);
         CaddyModel.instance.removeEventListener("beadType_change",_beadTypeChange);
         _openBtn.removeEventListener("click",_openClick);
         _movie.movie.removeEventListener("enterFrame",__frameHandler);
         _beadQuickBuyBtn.removeEventListener("click",__beadQuickBuy);
         _autoCheck.removeEventListener("select",__selectedChanged);
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
         addChild(_selectSprite);
         _selectSprite.visible = false;
      }
      
      private function _update(e:BagEvent) : void
      {
         if(EquipType.isBeadFromSmeltByID(_type) || _type == 112150 || _type == 112108)
         {
            updateBead();
         }
         else
         {
            updateCell();
         }
      }
      
      private function _beadTypeChange(e:Event) : void
      {
         if(!EquipType.isBeadFromSmeltByID(CaddyModel.instance.beadType) && CaddyModel.instance.beadType != 112150 && CaddyModel.instance.beadType != 112108)
         {
            selectItem = CaddyModel.instance.beadType;
            _itemGroup.selectIndex = CaddyModel.instance.beadType;
            _goodsNameTxt.text = ItemManager.Instance.getTemplateById(_cellId[selectItem]).Name;
         }
         else
         {
            _goodsNameTxt.text = ItemManager.Instance.getTemplateById(CaddyModel.instance.beadType).Name;
         }
      }
      
      private function openImp() : void
      {
         var alert:* = null;
         if(EquipType.isBeadFromSmeltByID(_type) || _type == 112150 || _type == 112108)
         {
            if(_smeltBeadCell.count > 0)
            {
               if(CaddyModel.instance.bagInfo.itemNumber >= 25)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.caddy.FullBag"));
               }
               else
               {
                  _openBtn.enable = false;
                  _localAutoOpen = SharedManager.Instance.autoBead;
                  SocketManager.Instance.out.sendOpenDead(CaddyModel.instance.bagInfo.BagType,-2,_type);
               }
            }
            else
            {
               if(_type != 112150 && _type != 112108)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bead.buyNode1"));
                  return;
               }
               if(_type == 112108)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bead.buyNoCardBox1"));
               }
               else
               {
                  alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.bead.buyNoCardBox"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
                  alert.moveEnable = false;
                  alert.addEventListener("response",_response);
                  return;
               }
            }
         }
         else if((_itemContainer.getChildAt(_selectItem) as BeadItem).count > 0)
         {
            if(CaddyModel.instance.bagInfo.itemNumber >= 25)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.caddy.FullBag"));
            }
            else
            {
               _openBtn.enable = false;
               _localAutoOpen = SharedManager.Instance.autoBead;
               SocketManager.Instance.out.sendOpenDead(CaddyModel.instance.bagInfo.BagType,-2,_cellId[_selectItem]);
            }
         }
         else
         {
            _clickNumber = _selectItem;
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bead.buyNode1"));
            return;
         }
      }
      
      private function _openClick(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         openImp();
      }
      
      private function _lookClick(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      private function __frameHandler(e:Event) : void
      {
         if(_movie.movie.currentFrame == _endFrame)
         {
            _selectSprite.visible = true;
            _goodsNameTxt.text = _selectGoodsInfo.Name;
            creatTweenSelectMagnify();
         }
      }
      
      private function _itemClick(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _clickNumber = _itemContainer.getChildIndex(e.currentTarget as BeadItem);
         selectItem = _clickNumber;
         _itemGroup.selectIndex = _clickNumber;
         _buyType = _clickNumber;
         if((_itemContainer.getChildAt(_clickNumber) as BeadItem).count <= 0)
         {
            _localAutoOpen = false;
            e.stopImmediatePropagation();
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bead.buyNode1"));
            return;
         }
      }
      
      private function _response(e:FrameEvent) : void
      {
         ObjectUtils.disposeObject(e.currentTarget);
         (e.currentTarget as BaseAlerFrame).removeEventListener("response",_response);
         if(e.responseCode == 2 || e.responseCode == 3)
         {
            showQuickBuyBead();
         }
      }
      
      private function _responseI(e:FrameEvent) : void
      {
         ObjectUtils.disposeObject(e.currentTarget);
         (e.currentTarget as BaseAlerFrame).removeEventListener("response",_responseI);
         if(e.responseCode == 2 || e.responseCode == 3)
         {
            openShortcutBuyFrame(_clickNumber);
         }
      }
      
      private function creatEffect() : void
      {
         _effect = EffectManager.Instance.creatEffect(4,_turnCell,{
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
         TweenMax.killTweensOf(_turnSprite);
         var _loc1_:int = 1;
         _turnSprite.scaleY = _loc1_;
         _turnSprite.scaleX = _loc1_;
         _turnSprite.y = _startY;
         TweenMax.from(_turnSprite,0.5,{
            "scaleX":0,
            "scaleY":0
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
         if(EquipType.isBeadFromSmeltByID(_type) || _type == 112150 || _type == 112108)
         {
            if(_goodsNameTxt)
            {
               _goodsNameTxt.text = ItemManager.Instance.getTemplateById(_type).Name;
            }
         }
         else if(_goodsNameTxt)
         {
            _goodsNameTxt.text = ItemManager.Instance.getTemplateById(_cellId[selectItem]).Name;
         }
      }
      
      public function set selectItem(value:int) : void
      {
         if(_selectItem == value)
         {
            return;
         }
         _selectItem = value;
         _turnCell.info = ItemManager.Instance.getTemplateById(_cellId[selectItem]);
         EffectManager.Instance.removeEffect(_effect);
         creatTweenMagnify();
         creatEffect();
         CaddyModel.instance.beadType = _cellId[_selectItem];
      }
      
      public function get selectItem() : int
      {
         return _selectItem;
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
      
      override public function get openBtnEnable() : Boolean
      {
         return _openBtn.enable;
      }
      
      override public function dispose() : void
      {
         var item:* = null;
         removeEvents();
         TweenMax.killTweensOf(_turnSprite);
         TweenMax.killTweensOf(_selectSprite);
         while(_itemContainer.numChildren > 0)
         {
            item = _itemContainer.getChildAt(0) as BeadItem;
            item.removeEventListener("click",_itemClick);
            ObjectUtils.disposeObject(item);
            item = null;
         }
         if(_beadQuickBuyBtn)
         {
            ObjectUtils.disposeObject(_beadQuickBuyBtn);
         }
         _beadQuickBuyBtn = null;
         if(_beadQuickBuyBtnText1)
         {
            ObjectUtils.disposeObject(_beadQuickBuyBtnText1);
         }
         _beadQuickBuyBtnText1 = null;
         if(_font)
         {
            ObjectUtils.disposeObject(_font);
         }
         _font = null;
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
         if(_inputBg)
         {
            ObjectUtils.disposeObject(_inputBg);
         }
         _inputBg = null;
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
         if(_itemContainer)
         {
            ObjectUtils.disposeObject(_itemContainer);
         }
         _itemContainer = null;
         if(_turnBG)
         {
            ObjectUtils.disposeObject(_turnBG);
         }
         _turnBG = null;
         if(_movie)
         {
            ObjectUtils.disposeObject(_movie);
         }
         _movie = null;
         if(_goodsNameTxt)
         {
            ObjectUtils.disposeObject(_goodsNameTxt);
         }
         _goodsNameTxt = null;
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
         if(_lookTrophy)
         {
            ObjectUtils.disposeObject(_lookTrophy);
         }
         _lookTrophy = null;
         if(_itemGroup)
         {
            ObjectUtils.disposeObject(_itemGroup);
         }
         _itemGroup = null;
         ObjectUtils.disposeObject(_autoCheck);
         _autoCheck = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
