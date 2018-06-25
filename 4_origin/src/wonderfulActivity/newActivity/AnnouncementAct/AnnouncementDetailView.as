package wonderfulActivity.newActivity.AnnouncementAct
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import wonderfulActivity.data.GmActivityInfo;
   
   public class AnnouncementDetailView extends Sprite implements Disposeable
   {
       
      
      private var _timeField:FilterFrameText;
      
      private var _awardField:FilterFrameText;
      
      private var _contentField:FilterFrameText;
      
      private var _timeTitle:FilterFrameText;
      
      private var _awardTitle:FilterFrameText;
      
      private var _contentTitle:FilterFrameText;
      
      private var _timeWidth:int;
      
      private var _awardWidth:int;
      
      private var _contentWidth:int;
      
      private var _time:DisplayObject;
      
      private var _award:DisplayObject;
      
      private var _content:DisplayObject;
      
      private var _input:DisplayObject;
      
      private var _lines:Vector.<DisplayObject>;
      
      private var _hasKey:int;
      
      private var _activityInfo:GmActivityInfo;
      
      public function AnnouncementDetailView()
      {
         _lines = new Vector.<DisplayObject>();
         super();
         initView();
      }
      
      private function initView() : void
      {
         _timeTitle = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.ActivityState.TimeFieldTitle");
         _timeTitle.text = LanguageMgr.GetTranslation("tank.calendar.ActivityDetail.TimeFieldTitle");
         addChild(_timeTitle);
         _awardTitle = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.ActivityState.AwardFieldTitle");
         _awardTitle.text = LanguageMgr.GetTranslation("tank.calendar.ActivityDetail.AwardFieldTitle");
         addChild(_awardTitle);
         _contentTitle = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.ActivityState.ContentFieldTitle");
         _contentTitle.text = LanguageMgr.GetTranslation("tank.calendar.ActivityDetail.ContentFieldTitle");
         addChild(_contentTitle);
         _timeField = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.ActivityState.TimeField");
         PositionUtils.setPos(_timeField,"ddtcalendar.ActivityState.timeField.pos");
         _timeWidth = _timeField.width;
         addChild(_timeField);
         _awardField = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.ActivityState.AwardField");
         _awardWidth = _awardField.width;
         addChild(_awardField);
         _contentField = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.ActivityState.StateContentField");
         _contentWidth = _contentField.width;
         addChild(_contentField);
         var line:DisplayObject = ComponentFactory.Instance.creatBitmap("asset.ddtcalendar.ActivityState.SeparatorLine");
         PositionUtils.setPos(line,"ddtcalendar.ActivityState.LinePos" + _lines.length);
         _lines.push(line);
         addChild(line);
         line = ComponentFactory.Instance.creatBitmap("asset.ddtcalendar.ActivityState.SeparatorLine");
         PositionUtils.setPos(line,"ddtcalendar.ActivityState.LinePos" + _lines.length);
         _lines.push(line);
         addChild(line);
         _time = ComponentFactory.Instance.creatBitmap("asset.ddtcalendar.ActivityState.TimeIcon");
         addChild(_time);
         _award = ComponentFactory.Instance.creatBitmap("asset.ddtcalendar.ActivityState.AwardIcon");
         addChild(_award);
         _content = ComponentFactory.Instance.creatBitmap("asset.ddtcalendar.ActivityState.ContentIcon");
         addChild(_content);
      }
      
      public function setData(activityInfo:GmActivityInfo) : void
      {
         if(!activityInfo)
         {
            return;
         }
         _activityInfo = activityInfo;
         _awardField.y = _award.y + _award.height - 4;
         _awardField.autoSize = "none";
         _awardField.width = _awardWidth;
         _awardField.text = _activityInfo.rewardDesc;
         _awardField.autoSize = "left";
         _awardTitle.x = _award.x + _award.width + 4;
         _awardTitle.y = _award.y;
         _lines[0].y = _awardField.y + _awardField.height + 8;
         _content.y = _lines[0].y + _lines[0].height + 4;
         _contentField.y = _content.y + _content.height - 8;
         _contentField.autoSize = "none";
         _contentField.width = _contentWidth;
         _contentField.htmlText = _activityInfo.desc;
         _contentField.autoSize = "left";
         _contentField.mouseEnabled = true;
         _contentField.selectable = false;
         _contentTitle.x = _content.x + _content.width + 4;
         _contentTitle.y = _content.y;
         _lines[1].y = _contentField.y + _contentField.height + 8;
         _timeField.y = _lines[1].y + _lines[1].height + 8;
         _timeField.autoSize = "none";
         _timeField.width = _timeWidth;
         var timeArr:Array = [_activityInfo.beginTime.split(" ")[0],_activityInfo.endTime.split(" ")[0]];
         _timeField.text = timeArr[0] + "-" + timeArr[1];
         _timeField.autoSize = "left";
         _time.y = _timeField.y - 2;
         _timeTitle.x = _time.x + _time.width + 4;
         _timeTitle.y = _time.y;
      }
      
      override public function get height() : Number
      {
         var h:int = 0;
         h = _timeField.y + _timeField.height + 10;
         return h;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_timeField);
         _timeField = null;
         ObjectUtils.disposeObject(_awardField);
         _awardField = null;
         ObjectUtils.disposeObject(_contentField);
         _contentField = null;
         ObjectUtils.disposeObject(_time);
         _time = null;
         ObjectUtils.disposeObject(_award);
         _award = null;
         ObjectUtils.disposeObject(_content);
         _content = null;
         ObjectUtils.disposeObject(_timeTitle);
         _timeTitle = null;
         ObjectUtils.disposeObject(_awardTitle);
         _awardTitle = null;
         ObjectUtils.disposeObject(_contentTitle);
         _contentTitle = null;
         var line:DisplayObject = _lines.shift();
         while(line != null)
         {
            ObjectUtils.disposeObject(line);
            line = null;
            line = _lines.shift();
         }
         _lines = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
