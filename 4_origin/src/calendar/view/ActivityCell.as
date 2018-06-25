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
      
      public function ActivityCell(info:ActiveEventsInfo)
      {
         super();
         _info = info;
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
      
      private function __detailClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         CalendarControl.getInstance().setState(_info);
      }
      
      private function removeEvent() : void
      {
      }
      
      private function configUI() : void
      {
         var tempIndex:int = 0;
         _back = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.ActivityCellBg");
         DisplayUtils.setFrame(_back,!!_selected?2:1);
         addChild(_back);
         _titleField = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.ActivityCellTitleText");
         _titleField.htmlText = "<b>·</b> " + _info.Title;
         if(_titleField.textWidth > 90)
         {
            tempIndex = _titleField.getCharIndexAtPoint(_titleField.x + 86,_titleField.y + 2);
            if(tempIndex != -1)
            {
               _titleField.htmlText = "<b>·</b> " + _info.Title.substring(0,tempIndex) + "...";
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
      
      private function getActivityDispType(pIconID:int) : int
      {
         var result:int = 0;
         switch(int(pIconID) - 1)
         {
            case 0:
               result = 1;
               break;
            case 1:
               result = 2;
               break;
            case 2:
               result = 3;
               break;
            case 3:
               result = 4;
               break;
            case 4:
               result = 5;
               break;
            case 5:
               result = 6;
         }
         return result;
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(value:Boolean) : void
      {
         if(_selected == value)
         {
            return;
         }
         _selected = value;
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
