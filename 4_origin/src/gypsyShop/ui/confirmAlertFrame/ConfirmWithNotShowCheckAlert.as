package gypsyShop.ui.confirmAlertFrame
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.alert.SimpleAlert;
   import com.pickgliss.ui.vo.AlertInfo;
   import ddt.manager.LanguageMgr;
   
   public class ConfirmWithNotShowCheckAlert extends SimpleAlert
   {
       
      
      private var _scb:SelectedCheckButton;
      
      public function ConfirmWithNotShowCheckAlert()
      {
         super();
      }
      
      public function set selectedCheckButton(param1:SelectedCheckButton) : void
      {
         _scb = param1;
      }
      
      public function get isNoPrompt() : Boolean
      {
         return _scb.selected;
      }
      
      override public function set info(param1:AlertInfo) : void
      {
         .super.info = param1;
         if(_scb == null)
         {
            _scb = ComponentFactory.Instance.creatComponentByStylename("ddtGame.buyConfirmNo.scb");
         }
         addToContent(_scb);
         _scb.text = LanguageMgr.GetTranslation("ddt.consortiaBattle.buyConfirm.noAlertTxt");
         _seleContent.y = _seleContent.y + 35;
         _scb.x = _seleContent.x + (_seleContent.width - _scb.width) / 2;
         _scb.y = _seleContent.y - 5 - _scb.height + 46;
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(!_seleContent)
         {
            return;
         }
         _backgound.width = Math.max(_width,_seleContent.width + 14);
         _backgound.height = _height + 40;
         _submitButton.y = _submitButton.y + 40;
         _cancelButton.y = _cancelButton.y + 40;
      }
   }
}
