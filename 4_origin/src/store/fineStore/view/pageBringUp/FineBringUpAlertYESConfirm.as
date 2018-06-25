package store.fineStore.view.pageBringUp
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.controls.alert.SimpleAlert;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   
   public class FineBringUpAlertYESConfirm extends SimpleAlert
   {
       
      
      private var _confirmLabel:FilterFrameText;
      
      private var _confirmInput:TextInput;
      
      private var _itemNameText:FilterFrameText;
      
      private var _icon:Bitmap;
      
      public function FineBringUpAlertYESConfirm()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         enterEnable = true;
         escEnable = true;
         _confirmLabel = ComponentFactory.Instance.creat("storeBringUp.alertYesLabel");
         _confirmLabel.htmlText = LanguageMgr.GetTranslation("tank.view.bagII.alertConfirm");
         addToContent(_confirmLabel);
         _confirmInput = ComponentFactory.Instance.creat("storeBringUp.alertInput");
         addToContent(_confirmInput);
         _confirmInput.textField.addEventListener("change",onInput);
         _confirmInput.textField.addEventListener("keyDown",onKeyDown);
         textStyle = "bringup.simpleAlertContentText";
      }
      
      protected function onKeyDown(e:KeyboardEvent) : void
      {
         if(e.keyCode == 13)
         {
            dispatchEvent(new FrameEvent(3));
            e.stopPropagation();
         }
      }
      
      override public function set submitButtonStyle(stylename:String) : void
      {
         if(_submitButtonStyle == stylename)
         {
            return;
         }
         _submitButtonStyle = stylename;
         _submitButton = ComponentFactory.Instance.creat(_submitButtonStyle);
         onPropertiesChanged("submitButton");
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
      }
      
      protected function onInput(e:Event) : void
      {
         if(_confirmInput.text.toLowerCase() == "yes")
         {
            _submitButton.enable = true;
         }
         else
         {
            _submitButton.enable = false;
         }
      }
      
      public function upadteView(lan:String, itemName:String) : void
      {
         !_itemNameText && ComponentFactory.Instance.creat("bringup.itemNameText");
         addToContent(_itemNameText);
         _itemNameText.text = itemName;
         textStyle = "bringup.simpleAlertContentText";
         _textField.x = 69;
         _textField.y = 48;
         _textField.multiline = true;
         _textField.wordWrap = true;
         _textField.width = 250;
         _textField.height = 50;
         _textField.htmlText = lan;
      }
      
      public function isYesCorrect() : Boolean
      {
         return _confirmInput.text.toLowerCase() == "yes";
      }
      
      override public function dispose() : void
      {
         _confirmInput && _confirmInput.textField.removeEventListener("keyDown",onKeyDown);
         _confirmInput && _confirmInput.textField.removeEventListener("change",onInput);
         super.dispose();
         _confirmInput = null;
      }
   }
}
