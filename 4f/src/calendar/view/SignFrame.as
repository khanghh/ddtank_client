package calendar.view
{
   import calendar.CalendarControl;
   import calendar.CalendarModel;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import flash.display.DisplayObject;
   import flash.events.Event;
   
   public class SignFrame extends Frame
   {
       
      
      private var _signCalendar:ICalendar;
      
      private var _model:CalendarModel;
      
      public function SignFrame(param1:CalendarModel, param2:* = null){super();}
      
      private function initView(param1:*, param2:*) : void{}
      
      private function addEvent() : void{}
      
      private function __response(param1:FrameEvent) : void{}
      
      private function __getFocus(param1:Event) : void{}
      
      override public function dispose() : void{}
   }
}
