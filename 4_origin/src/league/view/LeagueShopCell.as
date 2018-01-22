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
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(16777215,0);
         _loc1_.graphics.drawRect(0,0,70,70);
         _loc1_.graphics.endFill();
         _itemCell = CellFactory.instance.createShopItemCell(_loc1_,null,true,true) as ShopItemCell;
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
      
      private function buyHandler(param1:MouseEvent) : void
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
         var _loc3_:LeagueShopBuySubmitAlert = ComponentFactory.Instance.creatComponentByStylename("leagueShopAlert");
         _loc3_.setData(_shopItemInfo.TemplateID,_shopItemInfo.GoodsID,_shopItemInfo.AValue1);
         var _loc2_:ShopItemInfo = ShopManager.Instance.getShopItemByGoodsID(_shopItemInfo.GoodsID);
         _loc3_.setBuyNum(_loc2_.personalBuyCnt);
         LayerManager.Instance.addToLayer(_loc3_,2,true,1);
      }
      
      private function __confirmBuy(param1:FrameEvent) : void
      {
         var _loc2_:* = null;
         var _loc7_:* = null;
         var _loc4_:* = null;
         var _loc6_:* = null;
         var _loc5_:* = null;
         var _loc3_:* = null;
         SoundManager.instance.play("008");
         _confirmFrame.removeEventListener("response",__confirmBuy);
         _confirmFrame = null;
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            _loc2_ = [_shopItemInfo.GoodsID];
            _loc7_ = [1];
            _loc4_ = [""];
            _loc6_ = [""];
            _loc5_ = [""];
            _loc3_ = [_shopItemInfo.isDiscount];
            SocketManager.Instance.out.sendBuyGoods(_loc2_,_loc7_,_loc4_,_loc6_,_loc5_,null,0,_loc3_);
         }
      }
      
      public function refreshShow(param1:ShopItemInfo) : void
      {
         var _loc2_:* = null;
         _shopItemInfo = param1;
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
            _loc2_ = BattleGroudControl.Instance.getBattleDataByLevel(_shopItemInfo.LimitGrade);
            _cannotBuyTipTxt.text = LanguageMgr.GetTranslation("ddt.league.cannotBuyTipTxt",_loc2_.Name);
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
