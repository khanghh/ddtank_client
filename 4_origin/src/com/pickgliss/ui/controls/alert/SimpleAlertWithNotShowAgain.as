package com.pickgliss.ui.controls.alert
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.vo.AlertInfo;
   
   public class SimpleAlertWithNotShowAgain extends SimpleAlert
   {
       
      
      private var _scb:SelectedCheckButton;
      
      public function SimpleAlertWithNotShowAgain()
      {
         super();
      }
      
      public function get isNoPrompt() : Boolean
      {
         return _scb.selected;
      }
      
      override public function set info(param1:AlertInfo) : void
      {
         .super.info = param1;
         _scb = ComponentFactory.Instance.creatComponentByStylename("ddtGame.buyConfirmNo.scb");
         addToContent(_scb);
         _scb.text = "Không nhắc nữa";
         if(info.type == 0)
         {
            _scb.x = (this.width - _scb.width - 30) / 2;
            _scb.y = _textField.height + _textField.y - 95 + 35 - 5 - _scb.height + 46;
         }
         else
         {
            _scb.x = 15;
            _scb.y = 60;
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
      
      override protected function layoutFrameRect() : void
      {
         this.height = this.height - 30;
         super.layoutFrameRect();
         this.height = this.height + 30;
      }
   }
}
