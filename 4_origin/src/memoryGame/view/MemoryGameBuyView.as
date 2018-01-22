package memoryGame.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.NumberSelecter;
   import ddt.manager.LanguageMgr;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.PositionUtils;
   import ddt.view.DoubleSelectedItem;
   import flash.events.Event;
   
   public class MemoryGameBuyView extends BaseAlerFrame
   {
       
      
      private var _selecedItem:DoubleSelectedItem;
      
      private var _timesSelector:NumberSelecter;
      
      private var _txt:FilterFrameText;
      
      public var autoClose:Boolean = true;
      
      public function MemoryGameBuyView()
      {
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         var _loc1_:AlertInfo = new AlertInfo(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("shop.PresentFrame.OkBtnText"),LanguageMgr.GetTranslation("shop.PresentFrame.CancelBtnText"));
         info = _loc1_;
         _selecedItem = new DoubleSelectedItem();
         _selecedItem.x = 193;
         _selecedItem.y = 137;
         addToContent(_selecedItem);
         _timesSelector = ComponentFactory.Instance.creatCustomObject("ddtcore.numberSelecter");
         _timesSelector.x = 157;
         _timesSelector.y = 84;
         addToContent(_timesSelector);
         _txt = ComponentFactory.Instance.creatComponentByStylename("core.alert.txt");
         PositionUtils.setPos(_txt,"memoryGame.buyViewTextPos");
         addToContent(_txt);
         onMoneyChange(null);
      }
      
      private function initEvents() : void
      {
         addEventListener("response",responseHander);
         _selecedItem.addEventListener("change",onMoneyChange);
         _timesSelector.addEventListener("change",onMoneyChange);
      }
      
      protected function onMoneyChange(param1:Event) : void
      {
         var _loc2_:Number = _timesSelector.number * ServerConfigManager.instance.memoryGameCardMoney();
         var _loc3_:String = LanguageMgr.GetTranslation(!!_selecedItem.isBind?"ddtMoney":"money");
         _txt.text = LanguageMgr.GetTranslation("memoryGame.cardTips",_loc2_,_loc3_,_timesSelector.number.toString());
      }
      
      private function removeEvnets() : void
      {
         removeEventListener("response",responseHander);
         _selecedItem.removeEventListener("change",onMoneyChange);
         _timesSelector.removeEventListener("change",onMoneyChange);
      }
      
      private function responseHander(param1:FrameEvent) : void
      {
         e = param1;
         SoundManager.instance.playButtonSound();
         if(e.responseCode == 3 || e.responseCode == 2)
         {
            var moneyNeed:Number = _timesSelector.number * ServerConfigManager.instance.memoryGameCardMoney();
            CheckMoneyUtils.instance.checkMoney(_selecedItem.isBind,moneyNeed,function():void
            {
               SocketManager.Instance.out.sendMemoryGameBuy(_timesSelector.number,CheckMoneyUtils.instance.isBind);
               if(autoClose)
               {
                  dispose();
               }
            });
         }
         else if(e.responseCode == 0 || e.responseCode == 1 || e.responseCode == 4)
         {
            dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      public function get isBind() : Boolean
      {
         return _selecedItem.isBind;
      }
      
      override public function dispose() : void
      {
         removeEvnets();
         if(_selecedItem)
         {
            ObjectUtils.disposeObject(_selecedItem);
         }
         super.dispose();
         _selecedItem = null;
         _timesSelector = null;
      }
   }
}
