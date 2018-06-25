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
      
      public function ActivityList(model:CalendarModel)
      {
         super();
         _model = model;
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
      
      private function menuItemClick(event:Event) : void
      {
         _list.invalidateViewport();
      }
      
      public function setActivityDate(date:Date) : void
      {
         _activityMenu.setActivityDate(date);
         _list.invalidateViewport();
      }
      
      public function showByQQ(activeID:int) : void
      {
         _activityMenu.showByQQ(activeID);
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
