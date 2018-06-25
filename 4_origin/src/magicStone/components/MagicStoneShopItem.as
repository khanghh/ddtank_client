package magicStone.components
{
   import bagAndInfo.cell.CellFactory;
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ShopItemInfo;
   import ddt.events.ItemEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import magicStone.MagicStoneControl;
   import magicStone.MagicStoneManager;
   
   public class MagicStoneShopItem extends Sprite implements Disposeable
   {
       
      
      protected var _itemBg:ScaleFrameImage;
      
      protected var _itemCellBg:Image;
      
      protected var _dotLine:Image;
      
      protected var _payType:ScaleFrameImage;
      
      protected var _itemNameTxt:FilterFrameText;
      
      protected var _itemPriceTxt:FilterFrameText;
      
      protected var _itemCell:EmbedMgStoneCell;
      
      protected var _itemCellBtn:Sprite;
      
      private var _needScore:FilterFrameText;
      
      private var _canNotBuyTips:FilterFrameText;
      
      private var _covertBtn:SimpleBitmapButton;
      
      private var _buyBtn:SimpleBitmapButton;
      
      private var _remainCount:FilterFrameText;
      
      private var _batFrame:MagicStoneBatFrame;
      
      protected var _shopItemInfo:ShopItemInfo;
      
      protected var _selected:Boolean;
      
      protected var _isMouseOver:Boolean;
      
      protected var _lightMc:MovieClip;
      
      public function MagicStoneShopItem()
      {
         super();
         initContent();
         addEvent();
      }
      
      protected function initContent() : void
      {
         _itemBg = ComponentFactory.Instance.creatComponentByStylename("ddtshop.GoodItemBg");
         _itemCellBg = ComponentFactory.Instance.creatComponentByStylename("ddtshop.GoodItemCellBg");
         _dotLine = ComponentFactory.Instance.creatComponentByStylename("ddtshop.GoodItemDotLine");
         _payType = ComponentFactory.Instance.creatComponentByStylename("ddtshop.GoodPayTypeLabel");
         _payType.mouseChildren = false;
         _payType.mouseEnabled = false;
         _itemNameTxt = ComponentFactory.Instance.creatComponentByStylename("ddtshop.GoodItemName");
         _itemPriceTxt = ComponentFactory.Instance.creatComponentByStylename("ddtshop.GoodItemPrice");
         var sp:Sprite = new Sprite();
         sp.graphics.beginFill(16777215,0);
         sp.graphics.drawRect(0,0,60,60);
         sp.graphics.endFill();
         _itemCell = new EmbedMgStoneCell(0,null,true,sp);
         CellFactory.instance.fillTipProp(_itemCell);
         _needScore = ComponentFactory.Instance.creatComponentByStylename("magicStone.shopFrame.needScoreTxt");
         _needScore.text = LanguageMgr.GetTranslation("magicStone.score");
         _canNotBuyTips = ComponentFactory.Instance.creatComponentByStylename("magicStone.shopFrame.scoreNotEnoughTxt");
         _canNotBuyTips.visible = false;
         _covertBtn = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.ConvertBtn");
         _covertBtn.visible = false;
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.BuyBtn");
         _buyBtn.visible = false;
         _remainCount = ComponentFactory.Instance.creatComponentByStylename("magicStone.shopFrame.remainCountTxt");
         _remainCount.visible = false;
         _itemBg.setFrame(1);
         _itemCellBg.setFrame(1);
         _payType.setFrame(1);
         _itemCellBtn = new Sprite();
         var _loc2_:int = 15;
         _itemCellBtn.y = _loc2_;
         _itemCellBtn.x = _loc2_;
         _itemCellBtn.addChild(_itemCell);
         _itemCellBtn.addChild(_remainCount);
         addChild(_itemBg);
         addChild(_itemCellBg);
         addChild(_dotLine);
         addChild(_payType);
         addChild(_itemNameTxt);
         addChild(_itemPriceTxt);
         addChild(_itemCellBtn);
         addChild(_needScore);
         addChild(_canNotBuyTips);
         addChild(_covertBtn);
         addChild(_buyBtn);
         _payType.visible = false;
         _itemPriceTxt.visible = false;
      }
      
      public function set shopItemInfo(value:ShopItemInfo) : void
      {
         var curScore:int = 0;
         if(value)
         {
            _shopItemInfo = value;
            _shopItemInfo.TemplateInfo.Level = 1;
            MagicStoneManager.instance.fillPropertys(value.TemplateInfo);
            _itemCell.info = value.TemplateInfo;
            _itemCell.visible = true;
            _itemCellBtn.visible = true;
            _itemNameTxt.visible = true;
            _itemNameTxt.text = String(_itemCell.info.Name);
            if(_itemNameTxt.text.length > 6)
            {
               _itemNameTxt.text = _itemNameTxt.text.substr(0,6) + "...";
            }
            _needScore.visible = true;
            _needScore.text = LanguageMgr.GetTranslation("magicStone.score",String(value.AValue1));
            curScore = MagicStoneControl.instance.mgStoneScore;
            if(value.TemplateInfo.Property3 == "0")
            {
               if(PlayerManager.Instance.Self.IsVIP && PlayerManager.Instance.Self.VIPLevel >= 4)
               {
                  _covertBtn.visible = false;
                  _buyBtn.visible = true;
                  _canNotBuyTips.visible = false;
                  _remainCount.visible = true;
                  _remainCount.text = "10";
                  _needScore.visible = false;
                  _payType.visible = true;
                  _payType.setFrame(2);
                  _itemPriceTxt.visible = true;
                  _itemPriceTxt.text = String(value.AValue1);
               }
               else
               {
                  _covertBtn.visible = false;
                  _buyBtn.visible = false;
                  _canNotBuyTips.visible = true;
                  _remainCount.visible = false;
                  _canNotBuyTips.text = LanguageMgr.GetTranslation("magicStone.onlyVIP4CanBuy");
                  PositionUtils.setPos(_canNotBuyTips,"magicStone.canNotBuyTipsPos2");
                  _needScore.visible = false;
                  _payType.visible = true;
                  _payType.setFrame(2);
                  _itemPriceTxt.visible = true;
                  _itemPriceTxt.text = String(value.AValue1);
               }
            }
            else
            {
               _remainCount.visible = false;
               _covertBtn.visible = true;
               _buyBtn.visible = false;
               _canNotBuyTips.visible = false;
            }
         }
         else
         {
            _shopItemInfo = null;
            _itemCell.info = null;
            _itemCellBtn.visible = false;
            _itemBg.setFrame(1);
            _itemCellBg.setFrame(1);
            _payType.visible = false;
            _itemPriceTxt.visible = false;
            _itemNameTxt.visible = false;
            _needScore.visible = false;
            _covertBtn.visible = false;
            _buyBtn.visible = false;
            _remainCount.visible = false;
            _canNotBuyTips.visible = false;
         }
      }
      
      public function get shopItemInfo() : ShopItemInfo
      {
         return _shopItemInfo;
      }
      
      protected function addEvent() : void
      {
         _covertBtn.addEventListener("click",__covertBtnClick);
         _buyBtn.addEventListener("click",__buyBtnClick);
         _itemBg.addEventListener("mouseOver",__itemMouseOver);
         _itemBg.addEventListener("mouseOut",__itemMouseOut);
         _itemCellBtn.addEventListener("click",__itemClick);
         _itemCellBtn.addEventListener("mouseOver",__itemMouseOver);
         _itemCellBtn.addEventListener("mouseOut",__itemMouseOut);
      }
      
      protected function removeEvent() : void
      {
         _covertBtn.removeEventListener("click",__covertBtnClick);
         _buyBtn.removeEventListener("click",__buyBtnClick);
         _itemBg.removeEventListener("mouseOver",__itemMouseOver);
         _itemBg.removeEventListener("mouseOut",__itemMouseOut);
         _itemCellBtn.removeEventListener("click",__itemClick);
         _itemCellBtn.removeEventListener("mouseOver",__itemMouseOver);
         _itemCellBtn.removeEventListener("mouseOut",__itemMouseOut);
      }
      
      protected function __itemClick(evt:MouseEvent) : void
      {
         if(!_shopItemInfo)
         {
            return;
         }
         SoundManager.instance.play("008");
         dispatchEvent(new ItemEvent("itemClick",_shopItemInfo,1));
      }
      
      protected function __covertBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         SocketManager.Instance.out.convertMgStoneScore(_shopItemInfo.GoodsID);
      }
      
      protected function __buyBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         _batFrame = ComponentFactory.Instance.creat("magicStone.batFrame");
         _batFrame.init2(1);
         _batFrame.shopItemInfo = _shopItemInfo;
         _batFrame.setNumMax(parseInt(_remainCount.text));
         _batFrame.show();
      }
      
      protected function __itemMouseOver(event:MouseEvent) : void
      {
         if(!_itemCell.info)
         {
            return;
         }
         if(_lightMc)
         {
            addChild(_lightMc);
         }
         parent.addChild(this);
         _isMouseOver = true;
      }
      
      protected function __itemMouseOut(event:MouseEvent) : void
      {
         ObjectUtils.disposeObject(_lightMc);
         if(!_shopItemInfo)
         {
            return;
         }
         _isMouseOver = false;
      }
      
      public function setItemLight($lightMc:MovieClip) : void
      {
         if(_lightMc == $lightMc)
         {
            return;
         }
         _lightMc = $lightMc;
         _lightMc.mouseChildren = false;
         _lightMc.mouseEnabled = false;
         _lightMc.gotoAndPlay(1);
      }
      
      public function setRemainCount(remain:int) : void
      {
         if(_remainCount)
         {
            _remainCount.text = remain.toString();
         }
         if(remain == 0)
         {
            _buyBtn.enable = false;
         }
         else
         {
            _buyBtn.enable = true;
         }
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(value:Boolean) : void
      {
         if(_selected == value)
         {
            return;
         }
         _selected = value;
         _itemNameTxt.setFrame(!!value?2:1);
         _itemPriceTxt.setFrame(!!value?2:1);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_itemBg);
         _itemBg = null;
         ObjectUtils.disposeObject(_itemCellBg);
         _itemCellBg = null;
         ObjectUtils.disposeObject(_dotLine);
         _dotLine = null;
         ObjectUtils.disposeObject(_payType);
         _payType = null;
         ObjectUtils.disposeObject(_itemNameTxt);
         _itemNameTxt = null;
         ObjectUtils.disposeObject(_itemPriceTxt);
         _itemPriceTxt = null;
         ObjectUtils.disposeObject(_itemCell);
         _itemCell = null;
         ObjectUtils.disposeObject(_itemCellBtn);
         _itemCellBtn = null;
         ObjectUtils.disposeObject(_needScore);
         _needScore = null;
         ObjectUtils.disposeObject(_canNotBuyTips);
         _canNotBuyTips = null;
         ObjectUtils.disposeObject(_covertBtn);
         _covertBtn = null;
         ObjectUtils.disposeObject(_buyBtn);
         _buyBtn = null;
         ObjectUtils.disposeObject(_remainCount);
         _remainCount = null;
      }
   }
}
