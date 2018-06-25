package calendar.view
{
   import activeEvents.data.ActiveEventsInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class ActivityDetail extends Sprite implements Disposeable
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
      
      private var _inputField:TextInput;
      
      private var _hasKey:int;
      
      private var _timer:TimerJuggler;
      
      private var _info:ActiveEventsInfo;
      
      public function ActivityDetail()
      {
         _lines = new Vector.<DisplayObject>();
         super();
         configUI();
      }
      
      private static function calculateLast(end:Date, now:Date) : String
      {
         var last:int = end.time - now.time;
         var op:String = "";
         if(last >= 86400000)
         {
            op = op + (Math.floor(last / 86400000) + LanguageMgr.GetTranslation("day"));
            last = last % 86400000;
         }
         if(last >= 3600000)
         {
            op = op + (Math.floor(last / 3600000) + LanguageMgr.GetTranslation("hour"));
            last = last % 3600000;
         }
         else if(op.length > 0)
         {
            op = op + ("00" + LanguageMgr.GetTranslation("hour"));
         }
         if(last >= 60000)
         {
            op = op + (Math.floor(last / 60000) + LanguageMgr.GetTranslation("minute"));
            last = last % 60000;
         }
         else if(op.length > 0)
         {
            op = op + ("00" + LanguageMgr.GetTranslation("minute"));
         }
         if(last >= 1000)
         {
            op = op + (Math.floor(last / 1000) + LanguageMgr.GetTranslation("second"));
         }
         else if(op.length > 0)
         {
            op = op + ("00" + LanguageMgr.GetTranslation("second"));
         }
         return op;
      }
      
      private function configUI() : void
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
         _input = ComponentFactory.Instance.creatBitmap("aaset.ddtcalendar.ActivityState.Pwd");
         addChild(_input);
         _inputField = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.ActivityState.InputField");
         addChild(_inputField);
      }
      
      private function __timer(event:Event) : void
      {
         var now:Date = TimeManager.Instance.Now();
         if(now.time <= _info.end.time)
         {
         }
      }
      
      private function startMark() : void
      {
         _timer.addEventListener("timer",__timer);
         _timer.start();
         __timer(null);
      }
      
      public function setData(info:ActiveEventsInfo) : void
      {
         if(_info == info)
         {
            return;
         }
         _info = info;
         if(_timer == null)
         {
            _timer = TimerManager.getInstance().addTimerJuggler(1000);
         }
         else
         {
            _timer.removeEventListener("timer",__timer);
         }
         _awardField.y = _award.y + _award.height - 4;
         _awardField.autoSize = "none";
         _awardField.width = _awardWidth;
         _awardField.text = info.AwardContent;
         _awardField.autoSize = "left";
         _awardTitle.x = _award.x + _award.width + 4;
         _awardTitle.y = _award.y;
         _lines[0].y = _awardField.y + _awardField.height + 8;
         _content.y = _lines[0].y + _lines[0].height + 4;
         _contentField.y = _content.y + _content.height - 8;
         _contentField.autoSize = "none";
         _contentField.width = _contentWidth;
         _contentField.htmlText = info.Content;
         _contentField.autoSize = "left";
         _contentField.mouseEnabled = true;
         _contentField.selectable = false;
         _contentTitle.x = _content.x + _content.width + 4;
         _contentTitle.y = _content.y;
         _hasKey = info.HasKey;
         if(_hasKey == 1 || _hasKey == 7 || _hasKey == 8)
         {
            var _loc2_:Boolean = true;
            _inputField.visible = _loc2_;
            _input.visible = _loc2_;
            _inputField.y = _contentField.y + _contentField.height + 20;
            _input.y = _inputField.y + 4;
            _lines[1].y = _input.y + _input.height + 14;
         }
         else
         {
            _loc2_ = false;
            _inputField.visible = _loc2_;
            _input.visible = _loc2_;
            _lines[1].y = _contentField.y + _contentField.height + 8;
         }
         _timeField.y = _lines[1].y + _lines[1].height + 8;
         _timeField.autoSize = "none";
         _timeField.width = _timeWidth;
         _timeField.text = info.activeTime();
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
      
      public function getInputField() : TextInput
      {
         return _inputField;
      }
      
      public function dispose() : void
      {
         if(_timer != null)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__timer);
            TimerManager.getInstance().removeTimerJuggler(_timer.id);
            _timer = null;
         }
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
         ObjectUtils.disposeObject(_input);
         _input = null;
         ObjectUtils.disposeObject(_inputField);
         _inputField = null;
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
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
