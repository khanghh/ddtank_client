package email.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.email.EmailModel;
   import ddt.events.EmailEvent;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import email.manager.MailControl;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   
   public class EmailView extends Sprite implements Disposeable
   {
       
      
      private var _controller:MailControl;
      
      private var _model:EmailModel;
      
      private var _read:ReadingView;
      
      private var _write:WritingView;
      
      public function EmailView(){super();}
      
      public function setup(param1:MailControl, param2:EmailModel) : void{}
      
      private function addEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __keyDownHandler(param1:KeyboardEvent) : void{}
      
      public function dispose() : void{}
      
      public function show() : void{}
      
      public function resetWrite() : void{}
      
      public function cancelMail() : void{}
      
      private function __addToStage(param1:Event) : void{}
      
      private function __changeType(param1:EmailEvent) : void{}
      
      private function __changeState(param1:EmailEvent) : void{}
      
      private function __changePage(param1:EmailEvent) : void{}
      
      private function __selectEmail(param1:EmailEvent) : void{}
      
      private function __removeEmail(param1:EmailEvent) : void{}
      
      private function __initEmail(param1:EmailEvent) : void{}
      
      private function updateListView() : void{}
      
      public function get writeView() : WritingView{return null;}
   }
}
