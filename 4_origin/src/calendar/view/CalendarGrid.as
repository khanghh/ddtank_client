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
      
      public function CalendarGrid(param1:CalendarModel)
      {
         _dayCells = new Vector.<DayCell>();
         super();
         _model = param1;
         configUI();
         addEvent();
      }
      
      private function configUI() : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = null;
         var _loc3_:* = null;
         _back = ComponentFactory.Instance.creatCustomObject("ddtcalendar.CalendarBackBg");
         addChild(_back);
         _front = ComponentFactory.Instance.creatCustomObject("ddtcalendar.CalendarFrontBg");
         addChild(_front);
         _title = ComponentFactory.Instance.creatBitmap("asset.ddtcalendar.CalendarGridTitleBg");
         addChild(_title);
         var _loc4_:Date = _model.today;
         _monthField = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.CalendarGrid.NumMonthField");
         _monthField.text = String(_loc4_.month + 1);
         addChild(_monthField);
         _enMonthField = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.CalendarGrid.EnMonthField");
         _enMonthField.text = LanguageMgr.GetTranslation("tank.calendar.grid.month" + _loc4_.month);
         _enMonthField.x = _monthField.x + _monthField.width;
         addChild(_enMonthField);
         _enYearField = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.CalendarGrid.EnYearField");
         _enYearField.text = _loc4_.fullYear + "";
         addChild(_enYearField);
         _todyField = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.CalendarGrid.TodayField");
         _todyField.text = LanguageMgr.GetTranslation("tank.calendar.grid.today",_loc4_.fullYear,_loc4_.month + 1,_loc4_.date);
         _todyField.text = _todyField.text + LanguageMgr.GetTranslation("tank.calendar.grid.week" + _loc4_.day);
         addChild(_todyField);
         _signField = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.CalendarGrid.SignField");
         _signField.text = LanguageMgr.GetTranslation("tank.calendar.grid.Sign",CalendarManager.getInstance().price);
         addChild(_signField);
         _signFieldNumber = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.CalendarGrid.SignFieldNumber");
         _signFieldNumber.text = LanguageMgr.GetTranslation("tank.calendar.grid.signFieldNumber",CalendarManager.getInstance().price);
         addChild(_signFieldNumber);
         var _loc2_:Point = ComponentFactory.Instance.creatCustomObject("ddtcalendar.CalendarGrid.TopLeft");
         var _loc1_:Date = new Date();
         _loc1_.time = _loc4_.time;
         _loc1_.setDate(1);
         if(_loc1_.day != 0)
         {
            if(_loc1_.month > 0)
            {
               _loc1_.setMonth(_loc4_.month - 1,CalendarModel.getMonthMaxDay(_loc4_.month - 1,_loc4_.fullYear) - _loc1_.day + 1);
            }
            else
            {
               _loc1_.setFullYear(_loc4_.fullYear - 1,11,31 - _loc1_.day + 1);
            }
         }
         _loc6_ = 0;
         while(_loc6_ < 42)
         {
            _loc5_ = new Date();
            _loc5_.time = _loc1_.time + _loc6_ * 86400000;
            _loc3_ = new DayCell(_loc5_,_model);
            _loc3_.x = _loc2_.x + _loc6_ % 7 * 57;
            _loc3_.y = _loc2_.y + Math.floor(_loc6_ / 7) * 26;
            addChild(_loc3_);
            _dayCells.push(_loc3_);
            _loc6_++;
         }
      }
      
      private function drawLayer() : void
      {
      }
      
      private function addEvent() : void
      {
         _model.addEventListener("TodayChanged",__todayChanged);
      }
      
      private function __todayChanged(param1:Event) : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = null;
         var _loc3_:Date = _model.today;
         _monthField.text = String(_loc3_.month + 1);
         _enMonthField.text = LanguageMgr.GetTranslation("tank.calendar.grid.month" + _loc3_.month);
         _enMonthField.x = _monthField.x + _monthField.width;
         _todyField.text = LanguageMgr.GetTranslation("tank.calendar.grid.today",_loc3_.fullYear,_loc3_.month + 1,_loc3_.date);
         _todyField.text = _todyField.text + LanguageMgr.GetTranslation("tank.calendar.grid.week" + _loc3_.day);
         var _loc2_:Date = new Date();
         _loc2_.time = _loc3_.time;
         _loc2_.setDate(1);
         if(_loc2_.day != 0)
         {
            if(_loc2_.month > 0)
            {
               _loc2_.setMonth(_loc3_.month - 1,CalendarModel.getMonthMaxDay(_loc3_.month - 1,_loc3_.fullYear) - _loc2_.day + 1);
            }
            else
            {
               _loc2_.setUTCFullYear(_loc3_.fullYear - 1,11,31 - _loc2_.day + 1);
            }
         }
         var _loc4_:int = _dayCells.length;
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            _loc5_ = new Date();
            _loc5_.time = _loc2_.time + _loc6_ * 86400000;
            _dayCells[_loc6_].date = _loc5_;
            _dayCells[_loc6_].signed = _model.hasSigned(_dayCells[_loc6_].date) || _model.hasRestroSigned(_dayCells[_loc6_].date);
            _loc6_++;
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
         var _loc1_:DayCell = _dayCells.shift();
         while(_loc1_ != null)
         {
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = _dayCells.shift();
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
