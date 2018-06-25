package sevenDouble.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.alert.SimpleAlert;
   import com.pickgliss.ui.vo.AlertInfo;
   import ddt.manager.LanguageMgr;
   
   public class SevenDoubleBuyConfirmView extends SimpleAlert
   {
       
      
      private var _scb:SelectedCheckButton;
      
      public function SevenDoubleBuyConfirmView()
      {
         super();
      }
      
      public function get isNoPrompt() : Boolean
      {
         return _scb.selected;
      }
      
      override public function set info(value:AlertInfo) : void
      {
         .super.info = value;
         _scb = ComponentFactory.Instance.creatComponentByStylename("ddtGame.buyConfirmNo.scb");
         addToContent(_scb);
         _scb.text = LanguageMgr.GetTranslation("ddt.consortiaBattle.buyConfirm.noAlertTxt");
         if(_seleContent)
         {
            _seleContent.y = _seleContent.y + 35;
            _scb.x = _seleContent.x + (_seleContent.width - _scb.width) / 2;
            _scb.y = _seleContent.y - 5 - _scb.height + 46;
         }
         else
         {
            _scb.x = this.width / 2 - _scb.width / 2 - _scb.parent.x;
            _scb.y = _textField.height + _textField.y - 38;
         }
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
