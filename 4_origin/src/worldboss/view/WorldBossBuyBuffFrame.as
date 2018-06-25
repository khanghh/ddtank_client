package worldboss.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   import worldboss.WorldBossManager;
   import worldboss.model.WorldBossBuffInfo;
   
   public class WorldBossBuyBuffFrame extends Sprite implements Disposeable
   {
      
      public static var IsAutoShow:Boolean = true;
      
      private static var _autoBuyBuffItem:DictionaryData = new DictionaryData();
       
      
      private var _notAgainBtn:SelectedCheckButton;
      
      private var _selectedArr:Array;
      
      private var _cartList:VBox;
      
      private var _cartScroll:ScrollPanel;
      
      private var _frame:Frame;
      
      private var _innerBg:Image;
      
      private var _moneyTip:FilterFrameText;
      
      private var _moneyBg:Image;
      
      private var _money:FilterFrameText;
      
      private var _bottomBg:Image;
      
      public function WorldBossBuyBuffFrame()
      {
         _selectedArr = [];
         super();
         init();
         addEvent();
      }
      
      private function drawFrame() : void
      {
         _frame = ComponentFactory.Instance.creatComponentByStylename("worldBoss.BuyBuffFrame");
         _frame.titleText = LanguageMgr.GetTranslation("worldboss.buyBuff.FrameTitle");
         addChild(_frame);
      }
      
      private function drawItemCountField() : void
      {
         _notAgainBtn = ComponentFactory.Instance.creatComponentByStylename("worldbossnotAgainBtn");
         _notAgainBtn.text = LanguageMgr.GetTranslation("worldboss.buyBuff.NotAgain");
         _notAgainBtn.selected = !IsAutoShow;
         _bottomBg = ComponentFactory.Instance.creatComponentByStylename("worldBoss.BuyBuffFrame.bottomBg");
         _moneyBg = ComponentFactory.Instance.creatComponentByStylename("ddtshop.TicketTextBg");
         PositionUtils.setPos(_moneyBg,"worldboss.buyBuffFrame.moneyBg");
         _money = ComponentFactory.Instance.creatComponentByStylename("ddtshop.PlayerMoney");
         PositionUtils.setPos(_money,"worldboss.buyBuffFrame.money");
         _money.text = PlayerManager.Instance.Self.Money.toString();
         _moneyTip = ComponentFactory.Instance.creatComponentByStylename("worldBoss.BuyBUffFrame.moneyTip");
         _moneyTip.text = LanguageMgr.GetTranslation("worldboss.buyBuff.moneyTip");
         _frame.addToContent(_notAgainBtn);
         _frame.addToContent(_bottomBg);
         _frame.addToContent(_moneyBg);
         _frame.addToContent(_money);
         _frame.addToContent(_moneyTip);
      }
      
      protected function drawPayListField() : void
      {
         _innerBg = ComponentFactory.Instance.creatComponentByStylename("worldBoss.BuyBuffFrameBg");
         _frame.addToContent(_innerBg);
      }
      
      protected function init() : void
      {
         _cartList = new VBox();
         drawFrame();
         _cartScroll = ComponentFactory.Instance.creatComponentByStylename("worldBoss.BuffItemList");
         _cartScroll.setView(_cartList);
         _cartScroll.vScrollProxy = 0;
         _cartList.spacing = 5;
         _cartList.strictSize = 80;
         _cartList.isReverAdd = true;
         drawPayListField();
         _frame.addToContent(_cartScroll);
         drawItemCountField();
         setList();
      }
      
      private function setList() : void
      {
         var i:int = 0;
         var cItem:* = null;
         var arr:Array = WorldBossManager.Instance.bossInfo.buffArray;
         for(i = 0; i < arr.length; )
         {
            cItem = new BuffCartItem();
            cItem.buffItemInfo = arr[i] as WorldBossBuffInfo;
            _cartList.addChild(cItem);
            _selectedArr.push(cItem);
            cItem.selected(_autoBuyBuffItem.hasKey(cItem.buffID));
            cItem.addEventListener("select",__itemSelected);
            i++;
         }
         _cartScroll.invalidateViewport();
         updatePrice();
      }
      
      private function addEvent() : void
      {
         _frame.addEventListener("response",__frameEventHandler);
         _notAgainBtn.addEventListener("select",__againChange);
         SocketManager.Instance.addEventListener("worldboss_buy_buff",__getBuff);
         PlayerManager.Instance.Self.addEventListener("propertychange",__onPropertyChanged);
      }
      
      protected function __onPropertyChanged(event:PlayerPropertyEvent) : void
      {
         if(event.changedProperties["Money"])
         {
            _money.text = PlayerManager.Instance.Self.Money.toString();
         }
      }
      
      private function removeEvent() : void
      {
         _frame.removeEventListener("response",__frameEventHandler);
         _notAgainBtn.removeEventListener("select",__againChange);
         SocketManager.Instance.removeEventListener("worldboss_buy_buff",__getBuff);
         PlayerManager.Instance.Self.removeEventListener("propertychange",__onPropertyChanged);
      }
      
      private function __itemSelected(e:Event = null) : void
      {
         updatePrice();
         var cartItem:BuffCartItem = e.currentTarget as BuffCartItem;
         if(cartItem.IsSelected)
         {
            _autoBuyBuffItem.add(cartItem.buffID,cartItem.buffID);
         }
         else
         {
            _autoBuyBuffItem.remove(cartItem.buffID);
         }
      }
      
      private function updatePrice() : void
      {
         var num:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = _selectedArr;
         for each(var item in _selectedArr)
         {
            if(item.IsSelected)
            {
               num = num + item.price;
            }
         }
      }
      
      private function __againChange(e:Event) : void
      {
         SoundManager.instance.play("008");
         if(_notAgainBtn.selected)
         {
            IsAutoShow = false;
         }
         else
         {
            IsAutoShow = true;
         }
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("worldboss.buyBuff.setShowSucess"));
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
      
      private function __frameEventHandler(evt:FrameEvent) : void
      {
         switch(int(evt.responseCode))
         {
            case 0:
            case 1:
               SoundManager.instance.play("008");
               dispose();
         }
      }
      
      private function __getBuff(evt:CrazyTankSocketEvent) : void
      {
         var count:int = 0;
         var i:int = 0;
         var buffID:int = 0;
         var pkg:PackageIn = evt.pkg;
         if(pkg.readBoolean())
         {
            count = pkg.readInt();
            if(count > 1)
            {
               dispose();
            }
            i = 0;
            while(i < count)
            {
               buffID = pkg.readInt();
               var _loc8_:int = 0;
               var _loc7_:* = _selectedArr;
               for each(var item in _selectedArr)
               {
                  if(buffID == item.buffID)
                  {
                     WorldBossManager.Instance.bossInfo.myPlayerVO.buffID = buffID;
                     item.changeStatusBuy();
                  }
               }
               i++;
            }
            updatePrice();
            dispatchEvent(new Event("change"));
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(_frame);
         ObjectUtils.disposeAllChildren(this);
         _bottomBg = null;
         _moneyTip = null;
         _moneyBg = null;
         _money = null;
         _selectedArr = null;
         _cartList = null;
         _cartScroll = null;
         _innerBg = null;
         _frame = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
