package ddt.view.buff.buffButton
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BuffInfo;
   import ddt.data.goods.ShopCarItemInfo;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.ShopManager;
   import ddt.manager.SoundManager;
   import ddt.view.tips.BuffTipInfo;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import shop.view.SetsShopView;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class PayBuffButton extends BuffButton
   {
       
      
      private var _buffs:Vector.<BuffInfo>;
      
      private var _isActived:Boolean = false;
      
      private var _timer:TimerJuggler;
      
      private var _str:String;
      
      private var _isMouseOver:Boolean = false;
      
      public function PayBuffButton(str:String = "")
      {
         _buffs = new Vector.<BuffInfo>();
         if(str == "")
         {
            _str = "asset.core.payBuffAsset";
         }
         else
         {
            _str = str;
         }
         super(_str);
         _tipStyle = "core.PayBuffTip";
         info = new BuffInfo(16);
         _timer = TimerManager.getInstance().addTimerJuggler(10000);
         _timer.addEventListener("timer",__timerTick);
         _timer.start();
      }
      
      override public function dispose() : void
      {
         if(_buffs)
         {
            _buffs.length = 0;
            _buffs = null;
         }
         _timer.removeEventListener("timer",__timerTick);
         _timer.stop();
         TimerManager.getInstance().removeJugglerByTimer(_timer);
         _timer = null;
         super.dispose();
      }
      
      private function __timerTick(event:Event) : void
      {
         validBuff();
         if(_isMouseOver)
         {
            ShowTipManager.Instance.showTip(this);
         }
      }
      
      private function validBuff() : void
      {
         var unValidedCount:int = 0;
         if(_isActived)
         {
            unValidedCount = 0;
            var _loc4_:int = 0;
            var _loc3_:* = _buffs;
            for each(var buff in _buffs)
            {
               buff.calculatePayBuffValidDay();
               if(!buff.valided)
               {
                  unValidedCount++;
               }
            }
            if(unValidedCount >= _buffs.length)
            {
               setAcived(false);
            }
         }
      }
      
      override protected function __onclick(evt:MouseEvent) : void
      {
         if(!CanClick)
         {
            return;
         }
         shop();
      }
      
      private function shop() : void
      {
         var item:* = null;
         var carItem:* = null;
         SoundManager.instance.play("008");
         var list:Array = [];
         item = ShopManager.Instance.getGoodsByTemplateID(11907);
         carItem = new ShopCarItemInfo(item.ShopID,item.TemplateID);
         ObjectUtils.copyProperties(carItem,item);
         list.push(carItem);
         item = ShopManager.Instance.getGoodsByTemplateID(11908);
         carItem = new ShopCarItemInfo(item.ShopID,item.TemplateID);
         ObjectUtils.copyProperties(carItem,item);
         list.push(carItem);
         item = ShopManager.Instance.getGoodsByTemplateID(11909);
         carItem = new ShopCarItemInfo(item.ShopID,item.TemplateID);
         ObjectUtils.copyProperties(carItem,item);
         list.push(carItem);
         item = ShopManager.Instance.getGoodsByTemplateID(11910);
         carItem = new ShopCarItemInfo(item.ShopID,item.TemplateID);
         ObjectUtils.copyProperties(carItem,item);
         list.push(carItem);
         item = ShopManager.Instance.getGoodsByTemplateID(11911);
         carItem = new ShopCarItemInfo(item.ShopID,item.TemplateID);
         ObjectUtils.copyProperties(carItem,item);
         list.push(carItem);
         item = ShopManager.Instance.getGoodsByTemplateID(11912);
         carItem = new ShopCarItemInfo(item.ShopID,item.TemplateID);
         ObjectUtils.copyProperties(carItem,item);
         list.push(carItem);
         item = ShopManager.Instance.getGoodsByTemplateID(11913);
         carItem = new ShopCarItemInfo(item.ShopID,item.TemplateID);
         ObjectUtils.copyProperties(carItem,item);
         list.push(carItem);
         var setspayFrame:SetsShopView = new SetsShopView();
         setspayFrame.initialize(list);
         LayerManager.Instance.addToLayer(setspayFrame,3,true,1);
         ShowTipManager.Instance.hideTip(this);
      }
      
      public function addBuff(buff:BuffInfo) : void
      {
         var i:int = 0;
         for(i = 0; i < _buffs.length; )
         {
            if(_buffs[i].Type == buff.Type)
            {
               _buffs[i] = buff;
               setAcived(true);
               return;
            }
            i++;
         }
         _buffs.push(buff);
         setAcived(true);
         __timerTick(null);
      }
      
      public function setAcived(val:Boolean) : void
      {
         if(_isActived == val)
         {
            return;
         }
         _isActived = val;
         if(_isActived)
         {
            filters = null;
         }
         else
         {
            filters = ComponentFactory.Instance.creatFilters("grayFilter");
         }
      }
      
      override protected function __onMouseOver(evt:MouseEvent) : void
      {
         if(_isActived)
         {
            filters = ComponentFactory.Instance.creatFilters("lightFilter");
         }
         _isMouseOver = true;
      }
      
      override protected function __onMouseOut(evt:MouseEvent) : void
      {
         if(_isActived)
         {
            filters = null;
         }
         _isMouseOver = false;
      }
      
      override public function get tipData() : Object
      {
         _tipData = new BuffTipInfo();
         validBuff();
         if(_info)
         {
            _tipData.isActive = _isActived;
            _tipData.describe = !!_isActived?"":LanguageMgr.GetTranslation("tank.view.buff.PayBuff.Note");
            _tipData.name = LanguageMgr.GetTranslation("tank.view.buff.PayBuff.Name");
            _tipData.isFree = false;
            _tipData.linkBuffs = _buffs;
         }
         return _tipData;
      }
   }
}
