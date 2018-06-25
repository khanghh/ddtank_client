package worldboss.view
{
   import bagAndInfo.cell.CellFactory;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.loader.BitmapLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import shop.view.ShopPlayerCell;
   import worldboss.WorldBossManager;
   import worldboss.model.WorldBossBuffInfo;
   
   public class BuffCartItem extends Sprite implements Disposeable
   {
       
      
      private var _buffInfo:WorldBossBuffInfo;
      
      private var _bg:DisplayObject;
      
      private var _itemCellBg:DisplayObject;
      
      private var _verticalLine:Image;
      
      private var _itemName:FilterFrameText;
      
      private var _description:FilterFrameText;
      
      private var _cell:ShopPlayerCell;
      
      private var _buffIconLoader:BitmapLoader;
      
      private var _buffIcon:Bitmap;
      
      private var _payPaneBuyBtn:BaseButton;
      
      private var _itemPrice:FilterFrameText;
      
      private var _moneyBitmap:Bitmap;
      
      private var _isBuyText:FilterFrameText;
      
      private var _autoBuySelectedBtn:SelectedCheckButton;
      
      private var _isAlreadyBuy:Boolean = false;
      
      private var _isAllSelected:Boolean = false;
      
      public function BuffCartItem()
      {
         super();
         drawBackground();
         drawNameField();
         drawCellField();
         init();
         addEvent();
      }
      
      protected function drawBackground() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("ddtshop.CartItemBg");
         _itemCellBg = ComponentFactory.Instance.creat("ddtshop.CartItemCellBg");
         _verticalLine = ComponentFactory.Instance.creatComponentByStylename("ddtshop.VerticalLine");
         addChild(_bg);
         addChild(_verticalLine);
         addChild(_itemCellBg);
      }
      
      protected function drawNameField() : void
      {
         _itemName = ComponentFactory.Instance.creatComponentByStylename("worldboss.buffCartItemName");
         _description = ComponentFactory.Instance.creatComponentByStylename("worldboss.buffCartDescription");
         addChild(_itemName);
         addChild(_description);
      }
      
      protected function drawCellField() : void
      {
         _cell = CellFactory.instance.createShopCartItemCell() as ShopPlayerCell;
         PositionUtils.setPos(_cell,"ddtshop.CartItemCellPoint");
         addChild(_cell);
      }
      
      private function init() : void
      {
         _payPaneBuyBtn = ComponentFactory.Instance.creatComponentByStylename("ddtshop.PayPaneBuyBtn");
         PositionUtils.setPos(_payPaneBuyBtn,"worldboss.buffCartItem.bugBtn");
         addChild(_payPaneBuyBtn);
         _moneyBitmap = ComponentFactory.Instance.creatBitmap("bagAndInfo.info.PointCoupon");
         PositionUtils.setPos(_moneyBitmap,"worldboss.buffCartItem.moneyBitmapPos");
         addChild(_moneyBitmap);
         _itemPrice = ComponentFactory.Instance.creatComponentByStylename("worldboss.buff.price");
         addChild(_itemPrice);
         _isBuyText = ComponentFactory.Instance.creatComponentByStylename("worldbossBuffIsBuyText");
         _isBuyText.text = LanguageMgr.GetTranslation("worldboss.buyBuff.haveBuy");
         addChild(_isBuyText);
         _isBuyText.visible = false;
         _autoBuySelectedBtn = ComponentFactory.Instance.creatComponentByStylename("worldbossAutoBuySelected");
         _autoBuySelectedBtn.text = LanguageMgr.GetTranslation("worldboss.buyBuff.autoBuy");
         addChild(_autoBuySelectedBtn);
      }
      
      private function updateStatus() : void
      {
         var i:int = 0;
         for(i = 0; i < WorldBossManager.Instance.bossInfo.myPlayerVO.buffs.length; )
         {
            if(buffID == WorldBossManager.Instance.bossInfo.myPlayerVO.buffs[i])
            {
               changeStatusBuy();
               return;
            }
            i++;
         }
      }
      
      private function _buffIconComplete(evt:LoaderEvent) : void
      {
         if(evt.loader.isSuccess)
         {
            evt.loader.removeEventListener("complete",_buffIconComplete);
            ObjectUtils.disposeObject(_buffIcon);
            _buffIcon = null;
            _buffIcon = evt.loader.content as Bitmap;
            addChild(_buffIcon);
            PositionUtils.setPos(_buffIcon,"worldboss.buffCartItem.Iconpos");
            var _loc2_:int = 60;
            _buffIcon.height = _loc2_;
            _buffIcon.width = _loc2_;
         }
      }
      
      private function addEvent() : void
      {
         _autoBuySelectedBtn.addEventListener("select",__autoBuyBuff);
         _payPaneBuyBtn.addEventListener("click",__payBuyBuff);
      }
      
      protected function __autoBuyBuff(event:Event) : void
      {
         var alert:* = null;
         var alert2:* = null;
         if(_autoBuySelectedBtn.selected)
         {
            if(PlayerManager.Instance.Self.Money >= _buffInfo.price)
            {
               if(WorldBossManager.Instance.isBuyBuffAlert)
               {
                  autoBuy();
                  return;
               }
               alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("worldboss.buyBuff.autoBuyConfirm"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"));
               alert.addEventListener("response",__onResponse);
            }
            else
            {
               alert2 = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.comon.lack"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
               alert2.moveEnable = false;
               alert2.addEventListener("response",_responseI);
               _autoBuySelectedBtn.selected = false;
               WorldBossManager.Instance.isBuyBuffAlert = false;
               return;
            }
         }
         else
         {
            WorldBossManager.Instance.autoBuyBuffs.remove(_buffInfo.ID);
         }
         dispatchEvent(new Event("select"));
      }
      
      protected function __onResponse(event:FrameEvent) : void
      {
         WorldBossManager.Instance.isBuyBuffAlert = true;
         switch(int(event.responseCode))
         {
            case 0:
               WorldBossManager.Instance.isBuyBuffAlert = false;
               _autoBuySelectedBtn.selected = false;
               break;
            default:
               WorldBossManager.Instance.isBuyBuffAlert = false;
               _autoBuySelectedBtn.selected = false;
               break;
            case 2:
            case 3:
            case 4:
               autoBuy();
         }
         Frame(event.currentTarget).dispose();
      }
      
      private function autoBuy() : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            _autoBuySelectedBtn.selected = false;
            WorldBossManager.Instance.isBuyBuffAlert = false;
            return;
         }
         WorldBossManager.Instance.autoBuyBuffs.add(_buffInfo.ID,_buffInfo);
         dispatchEvent(new Event("select"));
      }
      
      private function removeEvent() : void
      {
         _autoBuySelectedBtn.removeEventListener("select",__autoBuyBuff);
         _payPaneBuyBtn.removeEventListener("click",__payBuyBuff);
      }
      
      private function __selectedBuff(e:Event) : void
      {
         if(_isAllSelected)
         {
            _isAllSelected = false;
            return;
         }
         SoundManager.instance.play("008");
         dispatchEvent(new Event("select"));
      }
      
      public function selected(type:Boolean) : void
      {
         _isAllSelected = true;
         _autoBuySelectedBtn.selected = type;
      }
      
      private function __payBuyBuff(e:MouseEvent) : void
      {
         var alert:* = null;
         var amount:int = 0;
         var item:* = null;
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(_buffInfo.costID == -1)
         {
            if(PlayerManager.Instance.Self.Money >= _buffInfo.price)
            {
               SocketManager.Instance.out.sendBuyWorldBossBuff([_buffInfo.ID]);
            }
            else
            {
               alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.comon.lack"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
               alert.moveEnable = false;
               alert.addEventListener("response",_responseI);
            }
         }
         else
         {
            amount = 0;
            var _loc7_:int = 0;
            var _loc6_:* = PlayerManager.Instance.Self.PropBag.findItemsByTempleteID(_buffInfo.costID);
            for each(var info in PlayerManager.Instance.Self.PropBag.findItemsByTempleteID(_buffInfo.costID))
            {
               amount = amount + info.Count;
            }
            if(amount >= _buffInfo.price)
            {
               SocketManager.Instance.out.sendBuyWorldBossBuff([_buffInfo.ID]);
            }
            else
            {
               item = ItemManager.Instance.getTemplateById(_buffInfo.costID);
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("worldboss.buyBuff.lackItem",item.Name));
            }
         }
      }
      
      private function _responseI(e:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(e.responseCode == 3)
         {
            LeavePageManager.leaveToFillPath();
         }
         ObjectUtils.disposeObject(e.target);
      }
      
      public function set buffItemInfo(value:WorldBossBuffInfo) : void
      {
         var item:* = null;
         _buffInfo = value;
         _itemName.text = _buffInfo.name;
         _description.text = _buffInfo.decription;
         if(_buffInfo.costID == -1)
         {
            _itemPrice.text = LanguageMgr.GetTranslation("worldboss.buyBuff.eachMoney",_buffInfo.price.toString(),"1");
         }
         else
         {
            item = ItemManager.Instance.getTemplateById(_buffInfo.costID);
            _itemPrice.text = LanguageMgr.GetTranslation("worldboss.buyBuff.eachItem",_buffInfo.price.toString(),item.Name,"1");
            PositionUtils.setPos(_itemPrice,"worldboss.buffCartItem.costItemMoneyTxt");
            _moneyBitmap.visible = false;
         }
         _buffIconLoader = LoadResourceManager.Instance.createLoader(WorldBossRoomView.getImagePath(_buffInfo.ID),0);
         _buffIconLoader.addEventListener("complete",_buffIconComplete);
         LoadResourceManager.Instance.startLoad(_buffIconLoader);
         updateStatus();
      }
      
      public function changeStatusBuy() : void
      {
         _isAlreadyBuy = true;
         _isBuyText.visible = true;
         _autoBuySelectedBtn.visible = false;
         _payPaneBuyBtn.visible = false;
      }
      
      public function get IsSelected() : Boolean
      {
         return _isAlreadyBuy || _autoBuySelectedBtn.selected;
      }
      
      public function get price() : int
      {
         return _buffInfo.price;
      }
      
      public function get buffID() : int
      {
         return _buffInfo.ID;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _itemCellBg = null;
         _verticalLine = null;
         _itemName = null;
         _cell = null;
         _buffIconLoader = null;
         _buffIcon = null;
         _payPaneBuyBtn = null;
         _itemPrice = null;
         _moneyBitmap = null;
      }
   }
}
