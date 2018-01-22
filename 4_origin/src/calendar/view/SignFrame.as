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
      
      public function SignFrame(param1:CalendarModel, param2:* = null)
      {
         super();
         initView(param1,param2);
         addEvent();
      }
      
      private function initView(param1:*, param2:*) : void
      {
         _signCalendar = ComponentFactory.Instance.creatCustomObject("ddtcalendar.CalendarState",[param1]);
         addToContent(_signCalendar as DisplayObject);
         if(_signCalendar)
         {
            _signCalendar.setData(param2);
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__response);
         addEventListener("addedToStage",__getFocus);
      }
      
      private function __response(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               CalendarControl.getInstance().close();
               dispose();
            default:
               CalendarControl.getInstance().close();
               dispose();
            default:
            case 4:
               CalendarControl.getInstance().close();
               dispose();
         }
      }
      
      private function __getFocus(param1:Event) : void
      {
         removeEventListener("addedToStage",__getFocus);
         StageReferance.stage.focus = this;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_signCalendar);
         _signCalendar = null;
         super.dispose();
      }
   }
}
