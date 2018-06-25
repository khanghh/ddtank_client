package calendar.view
{
   import calendar.CalendarModel;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   
   public class CalendarState extends Sprite implements ICalendar
   {
       
      
      private var _calendarGrid:CalendarGrid;
      
      private var _awardBar:SignAwardBar;
      
      private var _model:CalendarModel;
      
      public function CalendarState(model:CalendarModel)
      {
         super();
         _model = model;
         configUI();
      }
      
      private function configUI() : void
      {
         _calendarGrid = ComponentFactory.Instance.creatCustomObject("ddtcalendar.CalendarGrid",[_model]);
         addChild(_calendarGrid);
         _awardBar = ComponentFactory.Instance.creatCustomObject("ddtcalendar.SignAwardBar",[_model]);
         addChild(_awardBar);
      }
      
      public function setData(val:* = null) : void
      {
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_calendarGrid);
         _calendarGrid = null;
         ObjectUtils.disposeObject(_awardBar);
         _awardBar = null;
         _model = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
