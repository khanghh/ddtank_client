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
      
      public function CalendarState(param1:CalendarModel){super();}
      
      private function configUI() : void{}
      
      public function setData(param1:* = null) : void{}
      
      public function dispose() : void{}
   }
}
