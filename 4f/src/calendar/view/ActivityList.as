package calendar.view{   import calendar.CalendarModel;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.ScrollPanel;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import flash.display.DisplayObject;   import flash.display.Sprite;   import flash.events.Event;      public class ActivityList extends Sprite implements Disposeable   {                   private var _back:DisplayObject;            private var _list:ScrollPanel;            private var _model:CalendarModel;            private var _activityMenu:ActivityMenu;            public function ActivityList(model:CalendarModel) { super(); }
            private function configUI() : void { }
            private function addEvent() : void { }
            private function removeEvent() : void { }
            private function menuItemClick(event:Event) : void { }
            public function setActivityDate(date:Date) : void { }
            public function showByQQ(activeID:int) : void { }
            public function dispose() : void { }
   }}