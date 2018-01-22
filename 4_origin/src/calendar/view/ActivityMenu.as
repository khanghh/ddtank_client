package calendar.view
{
   import activeEvents.data.ActiveEventsInfo;
   import calendar.CalendarControl;
   import calendar.CalendarModel;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class ActivityMenu extends Sprite implements Disposeable
   {
      
      public static const MENU_REFRESH:String = "activitymenu_refresh";
       
      
      private var _cells:Vector.<ActivityCell>;
      
      private var _model:CalendarModel;
      
      private var _contentHolder:ActivityContentHolder;
      
      private var _selectedItem:ActivityCell;
      
      public function ActivityMenu(param1:CalendarModel)
      {
         _cells = new Vector.<ActivityCell>();
         super();
         _model = param1;
         configUI();
      }
      
      private function cleanCells() : void
      {
         var _loc1_:ActivityCell = _cells.shift();
         while(_loc1_ != null)
         {
            ObjectUtils.disposeObject(_loc1_);
            _loc1_.removeEventListener("click",__cellClick);
            _loc1_ = _cells.shift();
         }
      }
      
      public function setActivityDate(param1:Date) : void
      {
         var _loc4_:* = null;
         var _loc6_:int = 0;
         var _loc3_:* = null;
         var _loc2_:* = null;
         cleanCells();
         var _loc5_:int = _model.eventActives.length;
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc3_ = _model.eventActives[_loc6_];
            if(isInValidDate(param1,_loc3_,isAfterToday(param1)))
            {
               if(!(isAfterToday(param1) && !_loc3_.IsAdvance && !isActivityStartedAndInProgress(param1,_loc3_)))
               {
                  _loc2_ = new ActivityCell(_loc3_);
                  _loc2_.y = _loc6_ * 54;
                  _loc2_.addEventListener("click",__cellClick);
                  addChild(_loc2_);
                  _cells.push(_loc2_);
               }
            }
            _loc6_++;
         }
         if(_cells.length > 0)
         {
            setSeletedItem(_cells[0]);
            CalendarControl.getInstance().setState(_cells[0].info);
            _contentHolder.visible = true;
         }
         else if(param1.time != _model.today.time)
         {
            _contentHolder.visible = false;
         }
         else
         {
            _contentHolder.visible = false;
         }
      }
      
      private function isActivityStartedAndInProgress(param1:Date, param2:ActiveEventsInfo) : Boolean
      {
         var _loc4_:Date = TimeManager.Instance.Now();
         var _loc3_:Date = new Date(param1.fullYear,param1.month,param1.date,param1.hours,param1.minutes,param1.seconds);
         var _loc5_:Date = new Date(param2.start.fullYear,param2.start.month,param2.start.date,param2.start.hours,param2.start.minutes,param2.start.seconds);
         return _loc4_.time > _loc5_.time && _loc3_.time > _loc5_.time;
      }
      
      private function isInValidDate(param1:Date, param2:ActiveEventsInfo, param3:Boolean = false) : Boolean
      {
         var _loc4_:Date = null;
         var _loc5_:Date = null;
         var _loc6_:Date = null;
         if(param3)
         {
            _loc4_ = new Date(param1.fullYear,param1.month,param1.date);
            _loc5_ = new Date(param2.start.fullYear,param2.start.month,param2.start.date);
            _loc6_ = new Date(param2.end.fullYear,param2.end.month,param2.end.date);
         }
         else
         {
            _loc4_ = new Date(param1.fullYear,param1.month,param1.date,param1.hours,param1.minutes,param1.seconds);
            _loc5_ = new Date(param2.start.fullYear,param2.start.month,param2.start.date,param2.start.hours,param2.start.minutes,param2.start.seconds);
            _loc6_ = new Date(param2.end.fullYear,param2.end.month,param2.end.date,param2.end.hours,param2.end.minutes,param2.end.seconds);
         }
         if(_loc4_.time <= _loc6_.time && _loc4_.time >= _loc5_.time)
         {
            return true;
         }
         return false;
      }
      
      private function isBeforeToday(param1:Date) : Boolean
      {
         var _loc2_:Date = new Date(param1.fullYear,param1.month,param1.date);
         return _loc2_ <= TimeManager.Instance.Now();
      }
      
      private function isAfterToday(param1:Date) : Boolean
      {
         var _loc2_:Date = new Date(param1.fullYear,param1.month,param1.date);
         return _loc2_ > TimeManager.Instance.Now();
      }
      
      private function configUI() : void
      {
         _contentHolder = ComponentFactory.Instance.creatCustomObject("ddtcalendar.ActivityContentHolder");
      }
      
      public function setSeletedItem(param1:ActivityCell) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(param1 != _selectedItem)
         {
            if(_selectedItem)
            {
               _selectedItem.selected = false;
            }
            _selectedItem = param1;
            _selectedItem.selected = true;
            addChildAt(_contentHolder,0);
            _loc2_ = _cells.indexOf(_selectedItem);
            _loc3_ = _cells.length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               if(_loc4_ <= _loc2_)
               {
                  _cells[_loc4_].y = _loc4_ * 54;
               }
               else
               {
                  _cells[_loc4_].y = _loc4_ * 54 + _contentHolder.height - 53;
               }
               _loc4_++;
            }
            _contentHolder.y = _selectedItem.y + 33;
            dispatchEvent(new Event("activitymenu_refresh"));
         }
      }
      
      private function __cellClick(param1:MouseEvent) : void
      {
         var _loc2_:ActivityCell = param1.currentTarget as ActivityCell;
         setSeletedItem(_loc2_);
         CalendarControl.getInstance().setState(_loc2_.info);
         SoundManager.instance.play("008");
      }
      
      override public function get height() : Number
      {
         var _loc1_:int = 0;
         if(_cells.length == 1)
         {
            _loc1_ = _contentHolder.y + _contentHolder.height;
         }
         else if(_cells.length > 0)
         {
            _loc1_ = 53 * _cells.length + _contentHolder.height - 28;
         }
         return _loc1_;
      }
      
      public function showByQQ(param1:int) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _cells;
         for each(var _loc2_ in _cells)
         {
            if(_loc2_.info.ActiveID == param1)
            {
               _loc2_.dispatchEvent(new MouseEvent("click"));
               _loc2_.openCell();
               _contentHolder.visible = true;
               break;
            }
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:ActivityCell = _cells.shift();
         while(_loc1_ != null)
         {
            ObjectUtils.disposeObject(_loc1_);
            _loc1_.removeEventListener("click",__cellClick);
            _loc1_ = _cells.shift();
         }
         ObjectUtils.disposeObject(_contentHolder);
         _contentHolder = null;
         _selectedItem = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
