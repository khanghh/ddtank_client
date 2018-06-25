package calendar.view{   import activeEvents.data.ActiveEventsInfo;   import calendar.CalendarControl;   import calendar.CalendarModel;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.SoundManager;   import ddt.manager.TimeManager;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;      public class ActivityMenu extends Sprite implements Disposeable   {            public static const MENU_REFRESH:String = "activitymenu_refresh";                   private var _cells:Vector.<ActivityCell>;            private var _model:CalendarModel;            private var _contentHolder:ActivityContentHolder;            private var _selectedItem:ActivityCell;            public function ActivityMenu(model:CalendarModel) { super(); }
            private function cleanCells() : void { }
            public function setActivityDate(date:Date) : void { }
            private function isActivityStartedAndInProgress(date:Date, activity:ActiveEventsInfo) : Boolean { return false; }
            private function isInValidDate(date:Date, activeInfo:ActiveEventsInfo, ignoreConcreteTime:Boolean = false) : Boolean { return false; }
            private function isBeforeToday(date:Date) : Boolean { return false; }
            private function isAfterToday(date:Date) : Boolean { return false; }
            private function configUI() : void { }
            public function setSeletedItem(item:ActivityCell) : void { }
            private function __cellClick(event:MouseEvent) : void { }
            override public function get height() : Number { return 0; }
            public function showByQQ(activeID:int) : void { }
            public function dispose() : void { }
   }}