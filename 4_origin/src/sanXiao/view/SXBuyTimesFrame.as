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
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class SXBuyTimesFrame extends BaseAlerFrame
   {
       
      
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
      
      public function set target($target:Sprite) : void
      {
         _target = $target;
      }
      
      private function initView() : void
      {
         var alerInfo:AlertInfo = new AlertInfo(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("shop.PresentFrame.OkBtnText"),LanguageMgr.GetTranslation("shop.PresentFrame.CancelBtnText"));
         info = alerInfo;
         _timesSelector = ComponentFactory.Instance.creatCustomObject("ddtcore.numberSelecter");
         _timesSelector.needFocus = false;
         _timesSelector.setNumberTxt(false);
         _timesSelector.x = 157;
         _timesSelector.y = 84;
         _timesSelector.number = 10;
         _timesSelector.minimum = 10;
         _timesSelector.maximum = 90;
         _timesSelector.times = 10;
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
         _timesSelector.addEventListener("change",onMoneyChange);
      }
      
      protected function onMoneyChange(e:Event) : void
      {
         var price:int = ServerConfigManager.instance.SanXiaoStepPrice();
         var moneyNeed:Number = _timesSelector.number * price;
         var moneyType:String = LanguageMgr.GetTranslation("money");
         _timesLabel.text = LanguageMgr.GetTranslation("sanxiao.buyTimesLabel",moneyNeed,moneyType,_timesSelector.number.toString());
      }
      
      private function removeEvnets() : void
      {
         removeEventListener("response",responseHander);
         _timesSelector.removeEventListener("change",onMoneyChange);
      }
      
      private function responseHander(e:FrameEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(e.responseCode == 3 || e.responseCode == 2)
         {
            if(buyFunction != null)
            {
               buyFunction(_timesSelector.number,false);
            }
            if(autoClose)
            {
               dispose();
            }
         }
         else if(e.responseCode == 0 || e.responseCode == 1 || e.responseCode == 4)
         {
            dispose();
         }
      }
      
      public function setTxt(str:String) : void
      {
         _txt.text = str;
      }
      
      override public function dispose() : void
      {
         buyFunction = null;
         clickFunction = null;
         removeEvnets();
         while(_container.numChildren)
         {
            ObjectUtils.disposeObject(_container.getChildAt(0));
         }
         super.dispose();
         _timesSelector = null;
         _timesLabel = null;
      }
   }
}
