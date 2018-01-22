package littleGame.view
{
   import bagAndInfo.cell.CellFactory;
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.ScoreExchangeFrame;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import shop.view.ShopGoodItem;
   import shop.view.ShopItemCell;
   
   [Event(name="purchase",type="ddt.events.ShopItemEvent")]
   [Event(name="collect",type="ddt.events.ShopItemEvent")]
   [Event(name="giving",type="ddt.events.ShopItemEvent")]
   public class AwardGoodItem extends ShopGoodItem
   {
      
      private static const AwardItemCell_Size:int = 61;
       
      
      private var _scoreTitleField:FilterFrameText;
      
      private var _scoreField:FilterFrameText;
      
      private var _exchangeBtn:SimpleBitmapButton;
      
      private var _exchangeTxt:FilterFrameText;
      
      private var _awardItem:MovieImage;
      
      public function AwardGoodItem()
      {
         super();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         ObjectUtils.disposeObject(_scoreTitleField);
         _scoreTitleField = null;
         ObjectUtils.disposeObject(_scoreField);
         _scoreField = null;
         ObjectUtils.disposeObject(_exchangeBtn);
         _exchangeBtn = null;
      }
      
      override protected function initContent() : void
      {
         _awardItem = ComponentFactory.Instance.creatComponentByStylename("asset.littleGame.background");
         addChild(_awardItem);
         super.initContent();
         _exchangeBtn = ComponentFactory.Instance.creatComponentByStylename("core.shop.exchangeButton");
         addChild(_exchangeBtn);
         _exchangeTxt = ComponentFactory.Instance.creatComponentByStylename("littleGame.exchangeText");
         _exchangeTxt.text = LanguageMgr.GetTranslation("tank.littlegame.exchange");
         _exchangeBtn.addChild(_exchangeTxt);
         var _loc1_:Rectangle = ComponentFactory.Instance.creatCustomObject("littleGame.GoodItemBG.size");
         _itemBg.width = _loc1_.width;
         _itemBg.height = _loc1_.height;
         _loc1_ = ComponentFactory.Instance.creatCustomObject("littleGame.GoodItemName.size");
         ObjectUtils.disposeObject(_itemNameTxt);
         _itemNameTxt = ComponentFactory.Instance.creatComponentByStylename("ddtshop.GoodItemNameII");
         _itemNameTxt.isAutoFitLength = true;
         _itemNameTxt.x = _loc1_.x;
         _itemNameTxt.width = _loc1_.width;
         addChild(_itemNameTxt);
         _loc1_ = ComponentFactory.Instance.creatCustomObject("littleGame.GoodItemDotLine.size");
         _dotLine.width = _loc1_.width;
         PositionUtils.setPos(_payType,"littleGame.GoodPayTypeLabel.pos");
         PositionUtils.setPos(_payPaneBuyBtn,"littleGame.PayPaneBuyBtn.pos");
         PositionUtils.setPos(_itemNameTxt,"littleGame.GoodItemName.pos");
         PositionUtils.setPos(_dotLine,"littleGame.GoodItemDotLine.pos");
         PositionUtils.setPos(_itemCellBg,"littleGame.GoodItemCellBg.pos");
         _payPaneGivingBtn.visible = false;
         _payPaneBuyBtn.visible = false;
         _exchangeBtn.visible = false;
         _itemBg.visible = false;
         _itemPriceTxt.visible = false;
         _shopItemCellTypeBg.visible = false;
         _payType.visible = false;
         _scoreTitleField = ComponentFactory.Instance.creatComponentByStylename("littleGame.AwardScoreTitleField");
         _scoreTitleField.text = LanguageMgr.GetTranslation("littlegame.AwardScore");
         addChild(_scoreTitleField);
         _scoreField = ComponentFactory.Instance.creatComponentByStylename("littleGame.AwardScoreField");
         addChild(_scoreField);
         PositionUtils.setPos(itemCell,"littleGame.GoodItemCell.pos");
         itemCell.cellSize = 61;
      }
      
      override protected function creatItemCell() : ShopItemCell
      {
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(16777215,0);
         _loc1_.graphics.drawRect(0,0,61,61);
         _loc1_.graphics.endFill();
         return CellFactory.instance.createShopItemCell(_loc1_,null,true,true) as ShopItemCell;
      }
      
      override protected function addEvent() : void
      {
         super.addEvent();
         _exchangeBtn.addEventListener("click",__payPanelClick);
         _itemCellBtn.addEventListener("mouseOver",__itemMouseOver);
         _itemCellBtn.addEventListener("mouseOut",__itemMouseOut);
         _itemBg.addEventListener("mouseOver",__itemMouseOver);
         _itemBg.addEventListener("mouseOut",__itemMouseOut);
      }
      
      override protected function __itemMouseOver(param1:MouseEvent) : void
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
         __timelineComplete();
      }
      
      override protected function __itemMouseOut(param1:MouseEvent) : void
      {
         ObjectUtils.disposeObject(_lightMc);
         if(!_shopItemInfo)
         {
            return;
         }
         _isMouseOver = false;
         __timelineComplete();
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
         _exchangeBtn.removeEventListener("click",__payPanelClick);
      }
      
      override protected function __payPanelClick(param1:MouseEvent) : void
      {
         if(_shopItemInfo == null)
         {
            return;
         }
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(PlayerManager.Instance.Self.Score < _shopItemInfo.getItemPrice(1).scoreValue)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.littlegame.scorelack"));
            return;
         }
         var _loc2_:ScoreExchangeFrame = ComponentFactory.Instance.creatComponentByStylename("ddtcore.exchangeFrame");
         _loc2_.type = 0;
         _loc2_.shopItem = _shopItemInfo;
         LayerManager.Instance.addToLayer(_loc2_,2,true,1);
      }
      
      override public function set shopItemInfo(param1:ShopItemInfo) : void
      {
         .super.shopItemInfo = param1;
         _payPaneGivingBtn.visible = false;
         _payPaneBuyBtn.visible = false;
         _payType.visible = false;
         _exchangeBtn.visible = param1 != null;
         _itemPriceTxt.visible = false;
         _shopItemCellTypeBg.visible = false;
         if(param1)
         {
            _scoreField.visible = true;
            _scoreTitleField.visible = true;
            _scoreField.text = String(param1.AValue1);
         }
         else
         {
            _scoreField.visible = false;
            _scoreTitleField.visible = false;
         }
      }
   }
}
