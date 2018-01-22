package sanXiao.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.NumberSelecter;
   import ddt.manager.LanguageMgr;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SoundManager;
   import ddt.view.DoubleSelectedItem;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class SXBuyTimesFrame extends BaseAlerFrame
   {
       
      
      private var _selecedItem:DoubleSelectedItem;
      
      public var buyFunction:Function;
      
      public var clickFunction:Function;
      
      private var _timesSelector:NumberSelecter;
      
      private var _txt:FilterFrameText;
      
      private var _target:Sprite;
      
      public var autoClose:Boolean = true;
      
      private var _timesLabel:FilterFrameText;
      
      public function SXBuyTimesFrame()
      {
         super();
         initView();
         initEvents();
      }
      
      public function set target(param1:Sprite) : void
      {
         _target = param1;
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
         _timesLabel = ComponentFactory.Instance.creat("sanxiao.TimesLabelbt");
         addToContent(_timesLabel);
         _txt = ComponentFactory.Instance.creatComponentByStylename("core.alert.txt");
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
         var _loc2_:Number = _timesSelector.number * ServerConfigManager.instance.getThreeCleanBuyCost;
         var _loc3_:String = LanguageMgr.GetTranslation(!!_selecedItem.isBind?"ddtMoney":"money");
         _timesLabel.text = LanguageMgr.GetTranslation("sanxiao.buyTimesLabel",_loc2_,_loc3_,_timesSelector.number.toString());
      }
      
      private function removeEvnets() : void
      {
         removeEventListener("response",responseHander);
         _selecedItem.removeEventListener("change",onMoneyChange);
         _timesSelector.removeEventListener("change",onMoneyChange);
      }
      
      private function responseHander(param1:FrameEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            if(buyFunction != null)
            {
               buyFunction(_timesSelector.number,_selecedItem.isBind);
            }
            if(autoClose)
            {
               dispose();
            }
         }
         else if(param1.responseCode == 0 || param1.responseCode == 1 || param1.responseCode == 4)
         {
            dispose();
         }
      }
      
      public function get isBind() : Boolean
      {
         return _selecedItem.isBind;
      }
      
      public function setTxt(param1:String) : void
      {
         _txt.text = param1;
      }
      
      override public function dispose() : void
      {
         buyFunction = null;
         clickFunction = null;
         removeEvnets();
         if(_selecedItem)
         {
            ObjectUtils.disposeObject(_selecedItem);
         }
         while(_container.numChildren)
         {
            ObjectUtils.disposeObject(_container.getChildAt(0));
         }
         super.dispose();
         _selecedItem = null;
         _timesSelector = null;
         _timesLabel = null;
      }
   }
}
