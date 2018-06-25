package league.view
{
   import bagAndInfo.cell.CellFactory;
   import baglocked.BaglockedManager;
   import battleGroud.BattleGroudControl;
   import battleGroud.data.BatlleData;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import league.LeagueControl;
   import shop.view.ShopItemCell;
   
   public class LeagueShopCell extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _moneyIcon:Bitmap;
      
      private var _nameTxt:FilterFrameText;
      
      private var _needMoneyTxt:FilterFrameText;
      
      private var _cannotBuyTipTxt:FilterFrameText;
      
      private var _buyBtn:SimpleBitmapButton;
      
      private var _itemCell:ShopItemCell;
      
      private var _shopItemInfo:ShopItemInfo;
      
      private var _confirmFrame:BaseAlerFrame;
      
      private var _buyOver:FilterFrameText;
      
      public function LeagueShopCell()
      {
         super();
         _bg = ComponentFactory.Instance.creatBitmap("asset.leagueShopCell.bg");
         _moneyIcon = ComponentFactory.Instance.creatBitmap("asset.leagueShopCell.moneyIcon");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("leagueShopCell.buyBtn");
         _buyBtn.visible = false;
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("leagueShopCell.nameTxt");
         _needMoneyTxt = ComponentFactory.Instance.creatComponentByStylename("leagueShopCell.needMoneyTxt");
         _cannotBuyTipTxt = ComponentFactory.Instance.creatComponentByStylename("leagueShopCell.cannotBuyTipTxt");
         _cannotBuyTipTxt.visible = false;
         var sp:Sprite = new Sprite();
         sp.graphics.beginFill(16777215,0);
         sp.graphics.drawRect(0,0,70,70);
         sp.graphics.endFill();
         _itemCell = CellFactory.instance.createShopItemCell(sp,null,true,true) as ShopItemCell;
         PositionUtils.setPos(_itemCell,"leagueShopCell.itemCell.pos");
         addChild(_bg);
         addChild(_moneyIcon);
         addChild(_buyBtn);
         addChild(_nameTxt);
         addChild(_needMoneyTxt);
         addChild(_cannotBuyTipTxt);
         addChild(_itemCell);
         _buyOver = ComponentFactory.Instance.creatComponentByStylename("leagueShopView.buyOver");
         _buyOver.text = LanguageMgr.GetTranslation("vipIntegralShopView.buyShopItem.buyOver");
         addChild(_buyOver);
         _buyOver.visible = false;
         _buyBtn.addEventListener("click",buyHandler,false,0,true);
      }
      
      private function buyHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(PlayerManager.Instance.Self.leagueMoney < int(_needMoneyTxt.text))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.league.unenoughMoneyTxpTxt"),0,true);
            return;
         }
         var buyAlert:LeagueShopBuySubmitAlert = ComponentFactory.Instance.creatComponentByStylename("leagueShopAlert");
         buyAlert.setData(_shopItemInfo.TemplateID,_shopItemInfo.GoodsID,_shopItemInfo.AValue1);
         var goodInfo:ShopItemInfo = ShopManager.Instance.getShopItemByGoodsID(_shopItemInfo.GoodsID);
         buyAlert.setBuyNum(goodInfo.personalBuyCnt);
         LayerManager.Instance.addToLayer(buyAlert,2,true,1);
      }
      
      private function __confirmBuy(evt:FrameEvent) : void
      {
         var items:* = null;
         var types:* = null;
         var colors:* = null;
         var places:* = null;
         var dresses:* = null;
         var goodsTypes:* = null;
         SoundManager.instance.play("008");
         _confirmFrame.removeEventListener("response",__confirmBuy);
         _confirmFrame = null;
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            items = [_shopItemInfo.GoodsID];
            types = [1];
            colors = [""];
            places = [""];
            dresses = [""];
            goodsTypes = [_shopItemInfo.isDiscount];
            SocketManager.Instance.out.sendBuyGoods(items,types,colors,places,dresses,null,0,goodsTypes);
         }
      }
      
      public function refreshShow(value:ShopItemInfo) : void
      {
         var tmpBattleData:* = null;
         _shopItemInfo = value;
         _itemCell.info = _shopItemInfo.TemplateInfo;
         _itemCell.tipInfo = _shopItemInfo;
         _nameTxt.text = _itemCell.info.Name;
         _needMoneyTxt.text = _shopItemInfo.AValue1.toString();
         _buyOver.visible = false;
         if(LeagueControl.instance.militaryRank == -1)
         {
            return;
         }
         if(_shopItemInfo.LimitGrade > LeagueControl.instance.militaryRank)
         {
            _buyBtn.visible = false;
            _cannotBuyTipTxt.visible = true;
            tmpBattleData = BattleGroudControl.Instance.getBattleDataByLevel(_shopItemInfo.LimitGrade);
            _cannotBuyTipTxt.text = LanguageMgr.GetTranslation("ddt.league.cannotBuyTipTxt",tmpBattleData.Name);
            _itemCell.filters = [ComponentFactory.Instance.model.getSet("grayFilter")];
         }
         else
         {
            _buyBtn.visible = true;
            _cannotBuyTipTxt.visible = false;
            _itemCell.filters = null;
            if(ShopManager.Instance.getShopItemByGoodsID(_shopItemInfo.GoodsID).personalBuyCnt == 0)
            {
               var _loc3_:Boolean = false;
               _buyBtn.visible = _loc3_;
               _buyBtn.enable = _loc3_;
               _buyOver.visible = true;
            }
            else
            {
               _loc3_ = true;
               _buyBtn.visible = _loc3_;
               _buyBtn.enable = _loc3_;
               _buyOver.visible = false;
            }
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _moneyIcon = null;
         _buyBtn = null;
         _nameTxt = null;
         _needMoneyTxt = null;
         _cannotBuyTipTxt = null;
         if(_confirmFrame)
         {
            _confirmFrame.removeEventListener("response",__confirmBuy);
            ObjectUtils.disposeObject(_confirmFrame);
         }
         _confirmFrame = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
