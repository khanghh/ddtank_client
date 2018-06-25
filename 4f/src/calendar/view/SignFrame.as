package calendar.view{   import calendar.CalendarControl;   import calendar.CalendarModel;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.SoundManager;   import flash.display.DisplayObject;   import flash.events.Event;      public class SignFrame extends Frame   {                   private var _signCalendar:ICalendar;            private var _model:CalendarModel;            public function SignFrame(model:CalendarModel, data:* = null) { super(); }
            private function initView(pData:*, data:*) : void { }
            private function addEvent() : void { }
            private function __response(event:FrameEvent) : void { }
            private function __getFocus(evt:Event) : void { }
            override public function dispose() : void { }
   }}