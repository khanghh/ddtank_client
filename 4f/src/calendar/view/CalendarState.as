package calendar.view{   import calendar.CalendarModel;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.utils.ObjectUtils;   import flash.display.Sprite;      public class CalendarState extends Sprite implements ICalendar   {                   private var _calendarGrid:CalendarGrid;            private var _awardBar:SignAwardBar;            private var _model:CalendarModel;            public function CalendarState(model:CalendarModel) { super(); }
            private function configUI() : void { }
            public function setData(val:* = null) : void { }
            public function dispose() : void { }
   }}