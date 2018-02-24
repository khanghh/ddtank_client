package calendar.view
{
   import activeEvents.data.ActiveEventsInfo;
   import calendar.CalendarControl;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class ActivityCell extends Sprite implements Disposeable
   {
       
      
      private var _back:DisplayObject;
      
      private var _icon:DisplayObject;
      
      private var _titleField:FilterFrameText;
      
      private var _info:ActiveEventsInfo;
      
      private var _quanMC:MovieClip;
      
      private var _selected:Boolean = false;
      
      public function ActivityCell(param1:ActiveEventsInfo){super();}
      
      public function get info() : ActiveEventsInfo{return null;}
      
      private function addEvent() : void{}
      
      private function __detailClick(param1:MouseEvent) : void{}
      
      private function removeEvent() : void{}
      
      private function configUI() : void{}
      
      private function getActivityDispType(param1:int) : int{return 0;}
      
      public function get selected() : Boolean{return false;}
      
      public function set selected(param1:Boolean) : void{}
      
      public function openCell() : void{}
      
      public function dispose() : void{}
   }
}
