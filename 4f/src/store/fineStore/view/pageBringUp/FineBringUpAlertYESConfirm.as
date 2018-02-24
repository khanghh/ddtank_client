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
      
      public function FineBringUpAlertYESConfirm(){super();}
      
      override protected function init() : void{}
      
      protected function onKeyDown(param1:KeyboardEvent) : void{}
      
      override public function set submitButtonStyle(param1:String) : void{}
      
      override protected function onProppertiesUpdate() : void{}
      
      protected function onInput(param1:Event) : void{}
      
      public function upadteView(param1:String, param2:String) : void{}
      
      public function isYesCorrect() : Boolean{return false;}
      
      override public function dispose() : void{}
   }
}
