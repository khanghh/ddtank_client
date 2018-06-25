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
      
      public function SignFrame(model:CalendarModel, data:* = null)
      {
         super();
         initView(model,data);
         addEvent();
      }
      
      private function initView(pData:*, data:*) : void
      {
         _signCalendar = ComponentFactory.Instance.creatCustomObject("ddtcalendar.CalendarState",[pData]);
         addToContent(_signCalendar as DisplayObject);
         if(_signCalendar)
         {
            _signCalendar.setData(data);
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__response);
         addEventListener("addedToStage",__getFocus);
      }
      
      private function __response(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(event.responseCode))
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
      
      private function __getFocus(evt:Event) : void
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
