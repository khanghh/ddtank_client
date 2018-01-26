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
      
      public function PayBuffButton(param1:String = ""){super(null);}
      
      override public function dispose() : void{}
      
      private function __timerTick(param1:Event) : void{}
      
      private function validBuff() : void{}
      
      override protected function __onclick(param1:MouseEvent) : void{}
      
      private function shop() : void{}
      
      public function addBuff(param1:BuffInfo) : void{}
      
      public function setAcived(param1:Boolean) : void{}
      
      override protected function __onMouseOver(param1:MouseEvent) : void{}
      
      override protected function __onMouseOut(param1:MouseEvent) : void{}
      
      override public function get tipData() : Object{return null;}
   }
}
