package email.view
{
   import com.pickgliss.ui.controls.Frame;
   import ddt.manager.SoundManager;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class BaseEmailRightView extends Frame
   {
       
      
      protected var _sender:TextField;
      
      protected var _topic:TextField;
      
      protected var _ta:TextField;
      
      public function BaseEmailRightView()
      {
         super();
         initView();
         addEvent();
      }
      
      protected function initView() : void
      {
         _sender = new TextField();
         _sender.maxChars = 36;
         _sender.defaultTextFormat = new TextFormat("Arial",12,0);
         _topic = new TextField();
         _topic.maxChars = 22;
         _topic.defaultTextFormat = new TextFormat("Arial",12,0);
         _ta = new TextField();
      }
      
      protected function addEvent() : void
      {
      }
      
      protected function removeEvent() : void
      {
      }
      
      protected function btnSound() : void
      {
         SoundManager.instance.play("043");
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_sender.parent)
         {
            _sender.parent.removeChild(_sender);
         }
         _sender = null;
         if(_topic.parent)
         {
            _topic.parent.removeChild(_topic);
         }
         _topic = null;
         if(_ta.parent)
         {
            _ta.parent.removeChild(_ta);
         }
         _ta = null;
      }
   }
}
