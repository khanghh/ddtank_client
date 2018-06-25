package ddt.view.caddyII.bead
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.events.Event;
   
   public class CardBoxQuickBuy extends BaseAlerFrame
   {
       
      
      private var _item:QuickBuyItem;
      
      private var _font1:Image;
      
      private var _font2:Image;
      
      private var _moneyBG:Image;
      
      private var _moneyTxt:FilterFrameText;
      
      private var _money:int;
      
      public function CardBoxQuickBuy()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var alertInfo:AlertInfo = new AlertInfo();
         alertInfo.title = LanguageMgr.GetTranslation("tank.view.store.matte.goldQuickBuy");
         alertInfo.submitLabel = LanguageMgr.GetTranslation("store.view.shortcutBuy.buyBtn");
         alertInfo.showCancel = false;
         alertInfo.moveEnable = false;
         info = alertInfo;
         _item = new QuickBuyItem();
         _item.itemID = 112150;
         PositionUtils.setPos(_item,"cardBoxQuickBuy.pos");
         _item.count = 1;
         _font1 = ComponentFactory.Instance.creatComponentByStylename("bead.quickFont1");
         PositionUtils.setPos(_font1,"cardBoxQuickBuy.font1pos");
         _font2 = ComponentFactory.Instance.creatComponentByStylename("bead.quickFont2");
         PositionUtils.setPos(_font2,"cardBoxQuickBuy.font2pos");
         _moneyBG = ComponentFactory.Instance.creatComponentByStylename("bead.quickMoneyBG");
         PositionUtils.setPos(_moneyBG,"cardBoxQuickBuy.moneyBGpos");
         _moneyTxt = ComponentFactory.Instance.creatComponentByStylename("bead.moneyTxt");
         PositionUtils.setPos(_moneyTxt,"cardBoxQuickBuy.moneyTxtpos");
         addToContent(_item);
         addToContent(_font1);
         addToContent(_font2);
         addToContent(_moneyBG);
         addToContent(_moneyTxt);
         _numberChange(null);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",_response);
         _item.removeEventListener("change",_numberChange);
         _item.removeEventListener("number_close",_numberClose);
         _item.addEventListener("number_enter",_numberEnter);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",_response);
         _item.addEventListener("change",_numberChange);
         _item.addEventListener("number_close",_numberClose);
         _item.addEventListener("number_enter",_numberEnter);
      }
      
      private function _numberChange(e:Event) : void
      {
         var sum:int = 0;
         money = _item.count * ShopManager.Instance.getMoneyShopItemByTemplateID(_item.info.TemplateID).getItemPrice(1).bothMoneyValue;
      }
      
      private function _numberEnter(e:Event) : void
      {
         if(money > 0)
         {
            buy();
            ObjectUtils.disposeObject(this);
         }
         else
         {
            _showTip();
         }
      }
      
      private function _numberClose(e:Event) : void
      {
         ObjectUtils.disposeObject(this);
      }
      
      public function set money(value:int) : void
      {
         _money = value;
         _moneyTxt.text = String(_money);
      }
      
      public function get money() : int
      {
         return _money;
      }
      
      private function _response(e:FrameEvent) : void
      {
         var alert:* = null;
         SoundManager.instance.play("008");
         if(e.responseCode == 3 || e.responseCode == 2)
         {
            if(money > 0)
            {
               if(PlayerManager.Instance.Self.Money < money)
               {
                  ObjectUtils.disposeObject(this);
                  alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.comon.lack"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
                  alert.moveEnable = false;
                  alert.addEventListener("response",_responseI);
                  return;
               }
               buy();
               ObjectUtils.disposeObject(this);
            }
            else
            {
               _showTip();
            }
         }
         else
         {
            ObjectUtils.disposeObject(this);
         }
      }
      
      private function _showTip() : void
      {
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bead.quickNumber"));
      }
      
      private function buy() : void
      {
         var i:int = 0;
         var items:Array = [];
         var types:Array = [];
         var colors:Array = [];
         var dresses:Array = [];
         var skins:Array = [];
         var places:Array = [];
         for(i = 0; i < _item.count; )
         {
            items.push(ShopManager.Instance.getMoneyShopItemByTemplateID(_item.info.TemplateID).GoodsID);
            types.push(1);
            colors.push("");
            dresses.push(false);
            skins.push("");
            places.push(-1);
            i++;
         }
         SocketManager.Instance.out.sendBuyGoods(items,types,colors,places,dresses,skins,5);
      }
      
      private function _responseI(e:FrameEvent) : void
      {
         (e.currentTarget as BaseAlerFrame).removeEventListener("response",_responseI);
         if(e.responseCode == 3 || e.responseCode == 2)
         {
            LeavePageManager.showFillFrame();
         }
         ObjectUtils.disposeObject(e.target);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_item)
         {
            ObjectUtils.disposeObject(_item);
         }
         _item = null;
         if(_font1)
         {
            ObjectUtils.disposeObject(_font1);
         }
         _font1 = null;
         if(_font2)
         {
            ObjectUtils.disposeObject(_font2);
         }
         _font2 = null;
         if(_moneyBG)
         {
            ObjectUtils.disposeObject(_moneyBG);
         }
         _moneyBG = null;
         if(_moneyTxt)
         {
            ObjectUtils.disposeObject(_moneyTxt);
         }
         _moneyTxt = null;
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
