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
      
      public function ActivityCell(param1:ActiveEventsInfo)
      {
         super();
         _info = param1;
         buttonMode = true;
         configUI();
         addEvent();
      }
      
      public function get info() : ActiveEventsInfo
      {
         return _info;
      }
      
      private function addEvent() : void
      {
      }
      
      private function __detailClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         CalendarControl.getInstance().setState(_info);
      }
      
      private function removeEvent() : void
      {
      }
      
      private function configUI() : void
      {
         var _loc1_:int = 0;
         _back = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.ActivityCellBg");
         DisplayUtils.setFrame(_back,!!_selected?2:1);
         addChild(_back);
         _titleField = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.ActivityCellTitleText");
         _titleField.htmlText = "<b>·</b> " + _info.Title;
         if(_titleField.textWidth > 90)
         {
            _loc1_ = _titleField.getCharIndexAtPoint(_titleField.x + 86,_titleField.y + 2);
            if(_loc1_ != -1)
            {
               _titleField.htmlText = "<b>·</b> " + _info.Title.substring(0,_loc1_) + "...";
            }
         }
         addChild(_titleField);
         if(!_quanMC)
         {
            _quanMC = ClassUtils.CreatInstance("asset.ddtActivity.MC");
            _quanMC.mouseChildren = false;
            _quanMC.mouseEnabled = false;
            _quanMC.gotoAndPlay(1);
            _quanMC.x = -5;
         }
         if(_info.Type == 2)
         {
            _quanMC.visible = true;
         }
         else
         {
            _quanMC.visible = false;
         }
         _icon = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.ActivityCellTitleIcon");
         DisplayUtils.setFrame(_icon,getActivityDispType(_info.IconID));
         addChild(_icon);
         addChild(_quanMC);
      }
      
      private function getActivityDispType(param1:int) : int
      {
         var _loc2_:int = 0;
         switch(int(param1) - 1)
         {
            case 0:
               _loc2_ = 1;
               break;
            case 1:
               _loc2_ = 2;
               break;
            case 2:
               _loc2_ = 3;
               break;
            case 3:
               _loc2_ = 4;
               break;
            case 4:
               _loc2_ = 5;
               break;
            case 5:
               _loc2_ = 6;
         }
         return _loc2_;
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         if(_selected == param1)
         {
            return;
         }
         _selected = param1;
         DisplayUtils.setFrame(_back,!!_selected?2:1);
         DisplayUtils.setFrame(_titleField,!!_selected?2:1);
      }
      
      public function openCell() : void
      {
         __detailClick(null);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_titleField);
         _titleField = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         if(_quanMC)
         {
            ObjectUtils.disposeObject(_quanMC);
         }
         _quanMC = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
