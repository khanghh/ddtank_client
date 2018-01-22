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
         var _loc3_:int = 0;
         var _loc1_:* = null;
         var _loc2_:Array = WorldBossManager.Instance.bossInfo.buffArray;
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc1_ = new BuffCartItem();
            _loc1_.buffItemInfo = _loc2_[_loc3_] as WorldBossBuffInfo;
            _cartList.addChild(_loc1_);
            _selectedArr.push(_loc1_);
            _loc1_.selected(_autoBuyBuffItem.hasKey(_loc1_.buffID));
            _loc1_.addEventListener("select",__itemSelected);
            _loc3_++;
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
      
      protected function __onPropertyChanged(param1:PlayerPropertyEvent) : void
      {
         if(param1.changedProperties["Money"])
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
      
      private function __itemSelected(param1:Event = null) : void
      {
         updatePrice();
         var _loc2_:BuffCartItem = param1.currentTarget as BuffCartItem;
         if(_loc2_.IsSelected)
         {
            _autoBuyBuffItem.add(_loc2_.buffID,_loc2_.buffID);
         }
         else
         {
            _autoBuyBuffItem.remove(_loc2_.buffID);
         }
      }
      
      private function updatePrice() : void
      {
         var _loc1_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = _selectedArr;
         for each(var _loc2_ in _selectedArr)
         {
            if(_loc2_.IsSelected)
            {
               _loc1_ = _loc1_ + _loc2_.price;
            }
         }
      }
      
      private function __againChange(param1:Event) : void
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
      
      private function _responseI(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(param1.responseCode == 3)
         {
            LeavePageManager.leaveToFillPath();
         }
         ObjectUtils.disposeObject(param1.target);
      }
      
      private function __frameEventHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               SoundManager.instance.play("008");
               dispose();
         }
      }
      
      private function __getBuff(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:PackageIn = param1.pkg;
         if(_loc5_.readBoolean())
         {
            _loc2_ = _loc5_.readInt();
            if(_loc2_ > 1)
            {
               dispose();
            }
            _loc6_ = 0;
            while(_loc6_ < _loc2_)
            {
               _loc4_ = _loc5_.readInt();
               var _loc8_:int = 0;
               var _loc7_:* = _selectedArr;
               for each(var _loc3_ in _selectedArr)
               {
                  if(_loc4_ == _loc3_.buffID)
                  {
                     WorldBossManager.Instance.bossInfo.myPlayerVO.buffID = _loc4_;
                     _loc3_.changeStatusBuy();
                  }
               }
               _loc6_++;
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
