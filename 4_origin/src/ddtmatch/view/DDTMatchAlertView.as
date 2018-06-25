package ddtmatch.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.DoubleSelectedItem;
   import ddtmatch.event.DDTMatchEvent;
   import flash.events.Event;
   
   public class DDTMatchAlertView extends BaseAlerFrame
   {
       
      
      private var _tipInfo:FilterFrameText;
      
      private var _selecedItem:DoubleSelectedItem;
      
      private var _checkBtn:SelectedCheckButton;
      
      public function DDTMatchAlertView()
      {
         super();
         info = new AlertInfo(LanguageMgr.GetTranslation("tips"));
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _tipInfo = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.expert.alertText");
         addToContent(_tipInfo);
         _checkBtn = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.expert.selectBtn");
         _checkBtn.text = LanguageMgr.GetTranslation("ddt.farms.refreshPetsNOAlert");
         addToContent(_checkBtn);
         _selecedItem = new DoubleSelectedItem();
         PositionUtils.setPos(_selecedItem,"ddtmatch.expert.doubleSelect");
      }
      
      private function initEvent() : void
      {
         _checkBtn.addEventListener("select",__noAlertTip);
      }
      
      protected function __noAlertTip(event:Event) : void
      {
         SoundManager.instance.play("008");
         var evt:DDTMatchEvent = new DDTMatchEvent("expertSelect");
         evt.flag = _checkBtn.selected;
         dispatchEvent(evt);
      }
      
      override public function get isBand() : Boolean
      {
         return _selecedItem.isBind;
      }
      
      public function set text(text:String) : void
      {
         _tipInfo.text = text;
      }
      
      private function removeEvent() : void
      {
         if(_checkBtn)
         {
            _checkBtn.removeEventListener("select",__noAlertTip);
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_tipInfo)
         {
            _tipInfo.dispose();
            _tipInfo = null;
         }
         if(_selecedItem)
         {
            _selecedItem.dispose();
            _selecedItem = null;
         }
         if(_checkBtn)
         {
            _checkBtn.dispose();
            _checkBtn = null;
         }
         super.dispose();
      }
   }
}
