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
      
      public function ActivityMenu(model:CalendarModel)
      {
         _cells = new Vector.<ActivityCell>();
         super();
         _model = model;
         configUI();
      }
      
      private function cleanCells() : void
      {
         var cell:ActivityCell = _cells.shift();
         while(cell != null)
         {
            ObjectUtils.disposeObject(cell);
            cell.removeEventListener("click",__cellClick);
            cell = _cells.shift();
         }
      }
      
      public function setActivityDate(date:Date) : void
      {
         var activeInfo:* = null;
         var i:int = 0;
         var active:* = null;
         var cell:* = null;
         cleanCells();
         var len:int = _model.eventActives.length;
         for(i = 0; i < len; )
         {
            active = _model.eventActives[i];
            if(isInValidDate(date,active,isAfterToday(date)))
            {
               if(!(isAfterToday(date) && !active.IsAdvance && !isActivityStartedAndInProgress(date,active)))
               {
                  cell = new ActivityCell(active);
                  cell.y = i * 54;
                  cell.addEventListener("click",__cellClick);
                  addChild(cell);
                  _cells.push(cell);
               }
            }
            i++;
         }
         if(_cells.length > 0)
         {
            setSeletedItem(_cells[0]);
            CalendarControl.getInstance().setState(_cells[0].info);
            _contentHolder.visible = true;
         }
         else if(date.time != _model.today.time)
         {
            _contentHolder.visible = false;
         }
         else
         {
            _contentHolder.visible = false;
         }
      }
      
      private function isActivityStartedAndInProgress(date:Date, activity:ActiveEventsInfo) : Boolean
      {
         var now:Date = TimeManager.Instance.Now();
         var newDate:Date = new Date(date.fullYear,date.month,date.date,date.hours,date.minutes,date.seconds);
         var activityDate:Date = new Date(activity.start.fullYear,activity.start.month,activity.start.date,activity.start.hours,activity.start.minutes,activity.start.seconds);
         return now.time > activityDate.time && newDate.time > activityDate.time;
      }
      
      private function isInValidDate(date:Date, activeInfo:ActiveEventsInfo, ignoreConcreteTime:Boolean = false) : Boolean
      {
         var newDate:Date = null;
         var newActiveDateStart:Date = null;
         var newActiveDateEnd:Date = null;
         if(ignoreConcreteTime)
         {
            newDate = new Date(date.fullYear,date.month,date.date);
            newActiveDateStart = new Date(activeInfo.start.fullYear,activeInfo.start.month,activeInfo.start.date);
            newActiveDateEnd = new Date(activeInfo.end.fullYear,activeInfo.end.month,activeInfo.end.date);
         }
         else
         {
            newDate = new Date(date.fullYear,date.month,date.date,date.hours,date.minutes,date.seconds);
            newActiveDateStart = new Date(activeInfo.start.fullYear,activeInfo.start.month,activeInfo.start.date,activeInfo.start.hours,activeInfo.start.minutes,activeInfo.start.seconds);
            newActiveDateEnd = new Date(activeInfo.end.fullYear,activeInfo.end.month,activeInfo.end.date,activeInfo.end.hours,activeInfo.end.minutes,activeInfo.end.seconds);
         }
         if(newDate.time <= newActiveDateEnd.time && newDate.time >= newActiveDateStart.time)
         {
            return true;
         }
         return false;
      }
      
      private function isBeforeToday(date:Date) : Boolean
      {
         var newDate:Date = new Date(date.fullYear,date.month,date.date);
         return newDate <= TimeManager.Instance.Now();
      }
      
      private function isAfterToday(date:Date) : Boolean
      {
         var newDate:Date = new Date(date.fullYear,date.month,date.date);
         return newDate > TimeManager.Instance.Now();
      }
      
      private function configUI() : void
      {
         _contentHolder = ComponentFactory.Instance.creatCustomObject("ddtcalendar.ActivityContentHolder");
      }
      
      public function setSeletedItem(item:ActivityCell) : void
      {
         var idx:int = 0;
         var len:int = 0;
         var i:int = 0;
         if(item != _selectedItem)
         {
            if(_selectedItem)
            {
               _selectedItem.selected = false;
            }
            _selectedItem = item;
            _selectedItem.selected = true;
            addChildAt(_contentHolder,0);
            idx = _cells.indexOf(_selectedItem);
            len = _cells.length;
            for(i = 0; i < len; )
            {
               if(i <= idx)
               {
                  _cells[i].y = i * 54;
               }
               else
               {
                  _cells[i].y = i * 54 + _contentHolder.height - 53;
               }
               i++;
            }
            _contentHolder.y = _selectedItem.y + 33;
            dispatchEvent(new Event("activitymenu_refresh"));
         }
      }
      
      private function __cellClick(event:MouseEvent) : void
      {
         var item:ActivityCell = event.currentTarget as ActivityCell;
         setSeletedItem(item);
         CalendarControl.getInstance().setState(item.info);
         SoundManager.instance.play("008");
      }
      
      override public function get height() : Number
      {
         var h:int = 0;
         if(_cells.length == 1)
         {
            h = _contentHolder.y + _contentHolder.height;
         }
         else if(_cells.length > 0)
         {
            h = 53 * _cells.length + _contentHolder.height - 28;
         }
         return h;
      }
      
      public function showByQQ(activeID:int) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _cells;
         for each(var cell in _cells)
         {
            if(cell.info.ActiveID == activeID)
            {
               cell.dispatchEvent(new MouseEvent("click"));
               cell.openCell();
               _contentHolder.visible = true;
               break;
            }
         }
      }
      
      public function dispose() : void
      {
         var cell:ActivityCell = _cells.shift();
         while(cell != null)
         {
            ObjectUtils.disposeObject(cell);
            cell.removeEventListener("click",__cellClick);
            cell = _cells.shift();
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
