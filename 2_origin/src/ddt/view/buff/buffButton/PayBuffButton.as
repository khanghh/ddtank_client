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
      
      public function PayBuffButton(param1:String = "")
      {
         _buffs = new Vector.<BuffInfo>();
         if(param1 == "")
         {
            _str = "asset.core.payBuffAsset";
         }
         else
         {
            _str = param1;
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
      
      private function __timerTick(param1:Event) : void
      {
         validBuff();
         if(_isMouseOver)
         {
            ShowTipManager.Instance.showTip(this);
         }
      }
      
      private function validBuff() : void
      {
         var _loc1_:int = 0;
         if(_isActived)
         {
            _loc1_ = 0;
            var _loc4_:int = 0;
            var _loc3_:* = _buffs;
            for each(var _loc2_ in _buffs)
            {
               _loc2_.calculatePayBuffValidDay();
               if(!_loc2_.valided)
               {
                  _loc1_++;
               }
            }
            if(_loc1_ >= _buffs.length)
            {
               setAcived(false);
            }
         }
      }
      
      override protected function __onclick(param1:MouseEvent) : void
      {
         if(!CanClick)
         {
            return;
         }
         shop();
      }
      
      private function shop() : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         var _loc4_:Array = [];
         _loc3_ = ShopManager.Instance.getGoodsByTemplateID(11907);
         _loc2_ = new ShopCarItemInfo(_loc3_.ShopID,_loc3_.TemplateID);
         ObjectUtils.copyProperties(_loc2_,_loc3_);
         _loc4_.push(_loc2_);
         _loc3_ = ShopManager.Instance.getGoodsByTemplateID(11908);
         _loc2_ = new ShopCarItemInfo(_loc3_.ShopID,_loc3_.TemplateID);
         ObjectUtils.copyProperties(_loc2_,_loc3_);
         _loc4_.push(_loc2_);
         _loc3_ = ShopManager.Instance.getGoodsByTemplateID(11909);
         _loc2_ = new ShopCarItemInfo(_loc3_.ShopID,_loc3_.TemplateID);
         ObjectUtils.copyProperties(_loc2_,_loc3_);
         _loc4_.push(_loc2_);
         _loc3_ = ShopManager.Instance.getGoodsByTemplateID(11910);
         _loc2_ = new ShopCarItemInfo(_loc3_.ShopID,_loc3_.TemplateID);
         ObjectUtils.copyProperties(_loc2_,_loc3_);
         _loc4_.push(_loc2_);
         _loc3_ = ShopManager.Instance.getGoodsByTemplateID(11911);
         _loc2_ = new ShopCarItemInfo(_loc3_.ShopID,_loc3_.TemplateID);
         ObjectUtils.copyProperties(_loc2_,_loc3_);
         _loc4_.push(_loc2_);
         _loc3_ = ShopManager.Instance.getGoodsByTemplateID(11912);
         _loc2_ = new ShopCarItemInfo(_loc3_.ShopID,_loc3_.TemplateID);
         ObjectUtils.copyProperties(_loc2_,_loc3_);
         _loc4_.push(_loc2_);
         _loc3_ = ShopManager.Instance.getGoodsByTemplateID(11913);
         _loc2_ = new ShopCarItemInfo(_loc3_.ShopID,_loc3_.TemplateID);
         ObjectUtils.copyProperties(_loc2_,_loc3_);
         _loc4_.push(_loc2_);
         var _loc1_:SetsShopView = new SetsShopView();
         _loc1_.initialize(_loc4_);
         LayerManager.Instance.addToLayer(_loc1_,3,true,1);
         ShowTipManager.Instance.hideTip(this);
      }
      
      public function addBuff(param1:BuffInfo) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _buffs.length)
         {
            if(_buffs[_loc2_].Type == param1.Type)
            {
               _buffs[_loc2_] = param1;
               setAcived(true);
               return;
            }
            _loc2_++;
         }
         _buffs.push(param1);
         setAcived(true);
         __timerTick(null);
      }
      
      public function setAcived(param1:Boolean) : void
      {
         if(_isActived == param1)
         {
            return;
         }
         _isActived = param1;
         if(_isActived)
         {
            filters = null;
         }
         else
         {
            filters = ComponentFactory.Instance.creatFilters("grayFilter");
         }
      }
      
      override protected function __onMouseOver(param1:MouseEvent) : void
      {
         if(_isActived)
         {
            filters = ComponentFactory.Instance.creatFilters("lightFilter");
         }
         _isMouseOver = true;
      }
      
      override protected function __onMouseOut(param1:MouseEvent) : void
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
