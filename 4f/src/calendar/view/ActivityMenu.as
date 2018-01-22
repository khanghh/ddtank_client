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
      
      public function ActivityMenu(param1:CalendarModel){super();}
      
      private function cleanCells() : void{}
      
      public function setActivityDate(param1:Date) : void{}
      
      private function isActivityStartedAndInProgress(param1:Date, param2:ActiveEventsInfo) : Boolean{return false;}
      
      private function isInValidDate(param1:Date, param2:ActiveEventsInfo, param3:Boolean = false) : Boolean{return false;}
      
      private function isBeforeToday(param1:Date) : Boolean{return false;}
      
      private function isAfterToday(param1:Date) : Boolean{return false;}
      
      private function configUI() : void{}
      
      public function setSeletedItem(param1:ActivityCell) : void{}
      
      private function __cellClick(param1:MouseEvent) : void{}
      
      override public function get height() : Number{return 0;}
      
      public function showByQQ(param1:int) : void{}
      
      public function dispose() : void{}
   }
}
