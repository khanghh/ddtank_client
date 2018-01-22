package oldplayerintegralshop.view
{
   import bagAndInfo.cell.CellFactory;
   import baglocked.BaglockedManager;
   import battleGroud.BattleGroudControl;
   import battleGroud.data.BatlleData;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import league.LeagueControl;
   import oldplayerintegralshop.IntegralShopController;
   import shop.view.ShopItemCell;
   
   public class IntegralShopCell extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _nameTxt:FilterFrameText;
      
      private var _needMoneyTxt:FilterFrameText;
      
      private var _integral:FilterFrameText;
      
      private var _buyBtn:SimpleBitmapButton;
      
      private var _itemCell:ShopItemCell;
      
      private var _shopItemInfo:ShopItemInfo;
      
      private var _confirmFrame:BaseAlerFrame;
      
      public function IntegralShopCell()
      {
         super();
         _bg = ComponentFactory.Instance.creatBitmap("asset.integralShopView.bg");
         addChild(_bg);
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("integralShopView.buyBtn");
         addChild(_buyBtn);
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("integralShopView.nameTxt");
         addChild(_nameTxt);
         _needMoneyTxt = ComponentFactory.Instance.creatComponentByStylename("integralShopView.needMoneyTxt");
         addChild(_needMoneyTxt);
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(16777215,0);
         _loc1_.graphics.drawRect(0,0,70,70);
         _loc1_.graphics.endFill();
         _itemCell = CellFactory.instance.createShopItemCell(_loc1_,null,true,true) as ShopItemCell;
         PositionUtils.setPos(_itemCell,"integralShopView.itemCell.pos");
         addChild(_itemCell);
         _integral = ComponentFactory.Instance.creatComponentByStylename("integralShopView.integral");
         _integral.text = LanguageMgr.GetTranslation("ddt.dragonBoat.shopCellMoneyTxt");
         addChild(_integral);
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
         if(IntegralShopController.instance.integralNum < int(_needMoneyTxt.text))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.integral.unenoughIntegralText"),0,true);
            return;
         }
         _confirmFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("ddt.integral.buyConfirmTipTxt",_needMoneyTxt.text,_nameTxt.text),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
         _confirmFrame.moveEnable = false;
         _confirmFrame.addEventListener("response",__confirmBuy);
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
            SocketManager.Instance.out.sendBuyRegressIntegralGoods(_shopItemInfo.GoodsID,1);
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
         if(LeagueControl.instance.militaryRank == -1)
         {
            return;
         }
         if(_shopItemInfo.LimitGrade > LeagueControl.instance.militaryRank)
         {
            _loc2_ = BattleGroudControl.Instance.getBattleDataByLevel(_shopItemInfo.LimitGrade);
            _itemCell.filters = [ComponentFactory.Instance.model.getSet("grayFilter")];
         }
         else
         {
            _itemCell.filters = null;
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         if(_buyBtn)
         {
            _buyBtn.dispose();
            _buyBtn = null;
         }
         if(_nameTxt)
         {
            _nameTxt.dispose();
            _nameTxt = null;
         }
         if(_needMoneyTxt)
         {
            _needMoneyTxt.dispose();
            _needMoneyTxt = null;
         }
         if(_integral)
         {
            _integral.dispose();
            _integral = null;
         }
         if(_confirmFrame)
         {
            _confirmFrame.removeEventListener("response",__confirmBuy);
            ObjectUtils.disposeObject(_confirmFrame);
         }
         _confirmFrame = null;
         if(this.parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
