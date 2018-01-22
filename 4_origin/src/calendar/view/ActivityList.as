package calendar.view
{
   import calendar.CalendarModel;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class ActivityList extends Sprite implements Disposeable
   {
       
      
      private var _back:DisplayObject;
      
      private var _list:ScrollPanel;
      
      private var _model:CalendarModel;
      
      private var _activityMenu:ActivityMenu;
      
      public function ActivityList(param1:CalendarModel)
      {
         super();
         _model = param1;
         configUI();
         addEvent();
      }
      
      private function configUI() : void
      {
         _back = ComponentFactory.Instance.creatCustomObject("ddtcalendar.ActivityListBg");
         addChild(_back);
         _list = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.ActivityList");
         addChild(_list);
         _activityMenu = ComponentFactory.Instance.creatCustomObject("ddtcalendar.ActivityMenu",[_model]);
         _list.setView(_activityMenu);
      }
      
      private function addEvent() : void
      {
         _activityMenu.addEventListener("activitymenu_refresh",menuItemClick);
      }
      
      private function removeEvent() : void
      {
         _activityMenu.removeEventListener("activitymenu_refresh",menuItemClick);
      }
      
      private function menuItemClick(param1:Event) : void
      {
         _list.invalidateViewport();
      }
      
      public function setActivityDate(param1:Date) : void
      {
         _activityMenu.setActivityDate(param1);
         _list.invalidateViewport();
      }
      
      public function showByQQ(param1:int) : void
      {
         _activityMenu.showByQQ(param1);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_list);
         _list = null;
         ObjectUtils.disposeObject(_activityMenu);
         _activityMenu = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
