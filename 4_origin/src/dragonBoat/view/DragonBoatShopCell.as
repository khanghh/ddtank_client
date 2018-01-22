package dragonBoat.view
{
   import bagAndInfo.cell.CellFactory;
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.ScoreExchangeFrame;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import dragonBoat.DragonBoatManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import shop.view.ShopItemCell;
   
   public class DragonBoatShopCell extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _moneyTxt:FilterFrameText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _needMoneyTxt:FilterFrameText;
      
      private var _cannotBuyTipTxt:FilterFrameText;
      
      private var _buyBtn:SimpleBitmapButton;
      
      private var _itemCell:ShopItemCell;
      
      private var _shopItemInfo:ShopItemInfo;
      
      public function DragonBoatShopCell()
      {
         super();
         _bg = ComponentFactory.Instance.creatBitmap("asset.dragonBoat.shopFrame.cellBg");
         _moneyTxt = ComponentFactory.Instance.creatComponentByStylename("dragonBoat.shopFrame.coinTxt");
         _moneyTxt.text = LanguageMgr.GetTranslation("ddt.dragonBoat.shopCellMoneyTxt");
         PositionUtils.setPos(_moneyTxt,"dragonBoat.shopFrame.cellMoneyTxtPos");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("dragonBoat.shopFrame.cellBuyBtn");
         _buyBtn.visible = false;
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("dragonBoat.shopFrame.cellNameTxt");
         _needMoneyTxt = ComponentFactory.Instance.creatComponentByStylename("dragonBoat.shopFrame.cellNeedMoneyTxt");
         _cannotBuyTipTxt = ComponentFactory.Instance.creatComponentByStylename("dragonBoat.shopFrame.cellCannotBuyTipTxt");
         _cannotBuyTipTxt.text = LanguageMgr.GetTranslation("ddt.dragonBoat.shopScoreNotEnough");
         _cannotBuyTipTxt.visible = false;
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(16777215,0);
         _loc1_.graphics.drawRect(0,0,70,70);
         _loc1_.graphics.endFill();
         _itemCell = CellFactory.instance.createShopItemCell(_loc1_,null,true,true) as ShopItemCell;
         PositionUtils.setPos(_itemCell,"dragonBoat.shopFrame.cellItemCellPos");
         addChild(_bg);
         addChild(_moneyTxt);
         addChild(_buyBtn);
         addChild(_nameTxt);
         addChild(_needMoneyTxt);
         addChild(_cannotBuyTipTxt);
         addChild(_itemCell);
         _buyBtn.addEventListener("click",buyHandler,false,0,true);
      }
      
      private function buyHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:ScoreExchangeFrame = ComponentFactory.Instance.creatComponentByStylename("ddtcore.exchangeFrame");
         _loc2_.type = 1;
         _loc2_.shopItem = _shopItemInfo;
         LayerManager.Instance.addToLayer(_loc2_,2,true,1);
      }
      
      public function refreshShow(param1:ShopItemInfo) : void
      {
         _shopItemInfo = param1;
         if(_shopItemInfo)
         {
            _itemCell.visible = true;
            _nameTxt.visible = true;
            _needMoneyTxt.visible = true;
            _buyBtn.visible = true;
            _cannotBuyTipTxt.visible = true;
            _moneyTxt.visible = true;
            _itemCell.info = _shopItemInfo.TemplateInfo;
            _itemCell.tipInfo = _shopItemInfo;
            _nameTxt.text = _itemCell.info.Name;
            _needMoneyTxt.text = _shopItemInfo.AValue1.toString();
            if(int(_needMoneyTxt.text) > DragonBoatManager.instance.useableScore)
            {
               _buyBtn.visible = false;
               _cannotBuyTipTxt.visible = true;
               _itemCell.filters = [ComponentFactory.Instance.model.getSet("grayFilter")];
            }
            else
            {
               _buyBtn.visible = true;
               _cannotBuyTipTxt.visible = false;
               _itemCell.filters = null;
            }
         }
         else
         {
            _itemCell.visible = false;
            _nameTxt.visible = false;
            _needMoneyTxt.visible = false;
            _buyBtn.visible = false;
            _cannotBuyTipTxt.visible = false;
            _moneyTxt.visible = false;
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _moneyTxt = null;
         _buyBtn = null;
         _nameTxt = null;
         _needMoneyTxt = null;
         _cannotBuyTipTxt = null;
         _itemCell = null;
         _shopItemInfo = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
