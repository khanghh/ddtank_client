package calendar.view
{
   import calendar.CalendarManager;
   import calendar.CalendarModel;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   
   public class CalendarGrid extends Sprite implements Disposeable
   {
       
      
      private var _dayCells:Vector.<DayCell>;
      
      private var _model:CalendarModel;
      
      private var _monthField:FilterFrameText;
      
      private var _enMonthField:FilterFrameText;
      
      private var _dateField:FilterFrameText;
      
      private var _todyField:FilterFrameText;
      
      private var _back:DisplayObject;
      
      private var _front:DisplayObject;
      
      private var _backGrid:Shape;
      
      private var _title:DisplayObject;
      
      private var _enYearField:FilterFrameText;
      
      private var _signField:FilterFrameText;
      
      private var _signFieldNumber:FilterFrameText;
      
      public function CalendarGrid(model:CalendarModel)
      {
         _dayCells = new Vector.<DayCell>();
         super();
         _model = model;
         configUI();
         addEvent();
      }
      
      private function configUI() : void
      {
         var i:int = 0;
         var date:* = null;
         var cell:* = null;
         _back = ComponentFactory.Instance.creatCustomObject("ddtcalendar.CalendarBackBg");
         addChild(_back);
         _front = ComponentFactory.Instance.creatCustomObject("ddtcalendar.CalendarFrontBg");
         addChild(_front);
         _title = ComponentFactory.Instance.creatBitmap("asset.ddtcalendar.CalendarGridTitleBg");
         addChild(_title);
         var today:Date = _model.today;
         _monthField = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.CalendarGrid.NumMonthField");
         _monthField.text = String(today.month + 1);
         addChild(_monthField);
         _enMonthField = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.CalendarGrid.EnMonthField");
         _enMonthField.text = LanguageMgr.GetTranslation("tank.calendar.grid.month" + today.month);
         _enMonthField.x = _monthField.x + _monthField.width;
         addChild(_enMonthField);
         _enYearField = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.CalendarGrid.EnYearField");
         _enYearField.text = today.fullYear + "";
         addChild(_enYearField);
         _todyField = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.CalendarGrid.TodayField");
         _todyField.text = LanguageMgr.GetTranslation("tank.calendar.grid.today",today.fullYear,today.month + 1,today.date);
         _todyField.text = _todyField.text + LanguageMgr.GetTranslation("tank.calendar.grid.week" + today.day);
         addChild(_todyField);
         _signField = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.CalendarGrid.SignField");
         _signField.text = LanguageMgr.GetTranslation("tank.calendar.grid.Sign",CalendarManager.getInstance().price);
         addChild(_signField);
         _signFieldNumber = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.CalendarGrid.SignFieldNumber");
         _signFieldNumber.text = LanguageMgr.GetTranslation("tank.calendar.grid.signFieldNumber",CalendarManager.getInstance().price);
         addChild(_signFieldNumber);
         var topLeft:Point = ComponentFactory.Instance.creatCustomObject("ddtcalendar.CalendarGrid.TopLeft");
         var last:Date = new Date();
         last.time = today.time;
         last.setDate(1);
         if(last.day != 0)
         {
            if(last.month > 0)
            {
               last.setMonth(today.month - 1,CalendarModel.getMonthMaxDay(today.month - 1,today.fullYear) - last.day + 1);
            }
            else
            {
               last.setFullYear(today.fullYear - 1,11,31 - last.day + 1);
            }
         }
         i = 0;
         while(i < 42)
         {
            date = new Date();
            date.time = last.time + i * 86400000;
            cell = new DayCell(date,_model);
            cell.x = topLeft.x + i % 7 * 57;
            cell.y = topLeft.y + Math.floor(i / 7) * 26;
            addChild(cell);
            _dayCells.push(cell);
            i++;
         }
      }
      
      private function drawLayer() : void
      {
      }
      
      private function addEvent() : void
      {
         _model.addEventListener("TodayChanged",__todayChanged);
      }
      
      private function __todayChanged(event:Event) : void
      {
         var i:int = 0;
         var date:* = null;
         var today:Date = _model.today;
         _monthField.text = String(today.month + 1);
         _enMonthField.text = LanguageMgr.GetTranslation("tank.calendar.grid.month" + today.month);
         _enMonthField.x = _monthField.x + _monthField.width;
         _todyField.text = LanguageMgr.GetTranslation("tank.calendar.grid.today",today.fullYear,today.month + 1,today.date);
         _todyField.text = _todyField.text + LanguageMgr.GetTranslation("tank.calendar.grid.week" + today.day);
         var last:Date = new Date();
         last.time = today.time;
         last.setDate(1);
         if(last.day != 0)
         {
            if(last.month > 0)
            {
               last.setMonth(today.month - 1,CalendarModel.getMonthMaxDay(today.month - 1,today.fullYear) - last.day + 1);
            }
            else
            {
               last.setUTCFullYear(today.fullYear - 1,11,31 - last.day + 1);
            }
         }
         var len:int = _dayCells.length;
         for(i = 0; i < len; )
         {
            date = new Date();
            date.time = last.time + i * 86400000;
            _dayCells[i].date = date;
            _dayCells[i].signed = _model.hasSigned(_dayCells[i].date) || _model.hasRestroSigned(_dayCells[i].date);
            i++;
         }
      }
      
      private function removeEvent() : void
      {
         _model.removeEventListener("TodayChanged",__todayChanged);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_front);
         _front = null;
         ObjectUtils.disposeObject(_backGrid);
         _backGrid = null;
         ObjectUtils.disposeObject(_title);
         _title = null;
         ObjectUtils.disposeObject(_monthField);
         _monthField = null;
         ObjectUtils.disposeObject(_enMonthField);
         _enMonthField = null;
         ObjectUtils.disposeObject(_todyField);
         _todyField = null;
         ObjectUtils.disposeObject(_enYearField);
         _enYearField = null;
         var daycell:DayCell = _dayCells.shift();
         while(daycell != null)
         {
            ObjectUtils.disposeObject(daycell);
            daycell = _dayCells.shift();
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
