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
      
      private static function calculateLast(param1:Date, param2:Date) : String
      {
         var _loc4_:int = param1.time - param2.time;
         var _loc3_:String = "";
         if(_loc4_ >= 86400000)
         {
            _loc3_ = _loc3_ + (Math.floor(_loc4_ / 86400000) + LanguageMgr.GetTranslation("day"));
            _loc4_ = _loc4_ % 86400000;
         }
         if(_loc4_ >= 3600000)
         {
            _loc3_ = _loc3_ + (Math.floor(_loc4_ / 3600000) + LanguageMgr.GetTranslation("hour"));
            _loc4_ = _loc4_ % 3600000;
         }
         else if(_loc3_.length > 0)
         {
            _loc3_ = _loc3_ + ("00" + LanguageMgr.GetTranslation("hour"));
         }
         if(_loc4_ >= 60000)
         {
            _loc3_ = _loc3_ + (Math.floor(_loc4_ / 60000) + LanguageMgr.GetTranslation("minute"));
            _loc4_ = _loc4_ % 60000;
         }
         else if(_loc3_.length > 0)
         {
            _loc3_ = _loc3_ + ("00" + LanguageMgr.GetTranslation("minute"));
         }
         if(_loc4_ >= 1000)
         {
            _loc3_ = _loc3_ + (Math.floor(_loc4_ / 1000) + LanguageMgr.GetTranslation("second"));
         }
         else if(_loc3_.length > 0)
         {
            _loc3_ = _loc3_ + ("00" + LanguageMgr.GetTranslation("second"));
         }
         return _loc3_;
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
         var _loc1_:DisplayObject = ComponentFactory.Instance.creatBitmap("asset.ddtcalendar.ActivityState.SeparatorLine");
         PositionUtils.setPos(_loc1_,"ddtcalendar.ActivityState.LinePos" + _lines.length);
         _lines.push(_loc1_);
         addChild(_loc1_);
         _loc1_ = ComponentFactory.Instance.creatBitmap("asset.ddtcalendar.ActivityState.SeparatorLine");
         PositionUtils.setPos(_loc1_,"ddtcalendar.ActivityState.LinePos" + _lines.length);
         _lines.push(_loc1_);
         addChild(_loc1_);
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
      
      private function __timer(param1:Event) : void
      {
         var _loc2_:Date = TimeManager.Instance.Now();
         if(_loc2_.time <= _info.end.time)
         {
         }
      }
      
      private function startMark() : void
      {
         _timer.addEventListener("timer",__timer);
         _timer.start();
         __timer(null);
      }
      
      public function setData(param1:ActiveEventsInfo) : void
      {
         if(_info == param1)
         {
            return;
         }
         _info = param1;
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
         _awardField.text = param1.AwardContent;
         _awardField.autoSize = "left";
         _awardTitle.x = _award.x + _award.width + 4;
         _awardTitle.y = _award.y;
         _lines[0].y = _awardField.y + _awardField.height + 8;
         _content.y = _lines[0].y + _lines[0].height + 4;
         _contentField.y = _content.y + _content.height - 8;
         _contentField.autoSize = "none";
         _contentField.width = _contentWidth;
         _contentField.htmlText = param1.Content;
         _contentField.autoSize = "left";
         _contentField.mouseEnabled = true;
         _contentField.selectable = false;
         _contentTitle.x = _content.x + _content.width + 4;
         _contentTitle.y = _content.y;
         _hasKey = param1.HasKey;
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
         _timeField.text = param1.activeTime();
         _timeField.autoSize = "left";
         _time.y = _timeField.y - 2;
         _timeTitle.x = _time.x + _time.width + 4;
         _timeTitle.y = _time.y;
      }
      
      override public function get height() : Number
      {
         var _loc1_:int = 0;
         _loc1_ = _timeField.y + _timeField.height + 10;
         return _loc1_;
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
         var _loc1_:DisplayObject = _lines.shift();
         while(_loc1_ != null)
         {
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
            _loc1_ = _lines.shift();
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
