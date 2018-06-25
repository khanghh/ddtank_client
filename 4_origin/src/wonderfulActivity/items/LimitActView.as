package wonderfulActivity.items
{
   import activeEvents.data.ActiveEventsInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class LimitActView extends Sprite implements Disposeable
   {
       
      
      private var _info:ActiveEventsInfo;
      
      private var _time:Bitmap;
      
      private var _award:Bitmap;
      
      private var _content:Bitmap;
      
      private var _input:Bitmap;
      
      private var _titleBack:Bitmap;
      
      private var _inputField:TextInput;
      
      private var _timeTitle:FilterFrameText;
      
      private var _awardTitle:FilterFrameText;
      
      private var _contentTitle:FilterFrameText;
      
      private var _timeField:FilterFrameText;
      
      private var _timeWidth:int;
      
      private var _back:MutipleImage;
      
      private var _titleField:FilterFrameText;
      
      private var _line1:Bitmap;
      
      private var _line2:Bitmap;
      
      private var _line3:Bitmap;
      
      private var _awardField:FilterFrameText;
      
      private var _awardWidth:int;
      
      private var _contentField:FilterFrameText;
      
      private var _contentWidth:int;
      
      public function LimitActView(info:ActiveEventsInfo)
      {
         _info = info;
         super();
         initView();
      }
      
      private function initView() : void
      {
         _award = ComponentFactory.Instance.creatBitmap("asset.wonderful.ActivityState.AwardIcon");
         _award.x = 30;
         _award.y = 3;
         addChild(_award);
         _awardTitle = ComponentFactory.Instance.creatComponentByStylename("wonderful.ActivityState.AwardFieldTitle");
         _awardTitle.text = LanguageMgr.GetTranslation("tank.calendar.ActivityDetail.AwardFieldTitle");
         _awardTitle.x = _award.x + _award.width + 10;
         _awardTitle.y = _award.y;
         addChild(_awardTitle);
         _awardField = ComponentFactory.Instance.creatComponentByStylename("wonderful.ActivityState.AwardField");
         _awardWidth = _awardField.width;
         _awardField.x = _awardTitle.x;
         _awardField.y = _awardTitle.y + _awardTitle.height + 5;
         _awardField.autoSize = "none";
         _awardField.width = _awardWidth;
         _awardField.autoSize = "left";
         _awardField.htmlText = _info.AwardContent;
         _awardField.mouseEnabled = true;
         _awardField.selectable = false;
         addChild(_awardField);
         _line1 = ComponentFactory.Instance.creat("asset.wonderful.ActivityState.SeparatorLine");
         _line1.x = 10;
         _line1.y = _awardField.y + _awardField.height + 5;
         addChild(_line1);
         _content = ComponentFactory.Instance.creatBitmap("asset.wonderful.ActivityState.ContentIcon");
         _content.x = 30;
         _content.y = _line1.y + _line1.height + 10;
         addChild(_content);
         _contentTitle = ComponentFactory.Instance.creatComponentByStylename("wonderful.ActivityState.ContentFieldTitle");
         _contentTitle.text = LanguageMgr.GetTranslation("tank.calendar.ActivityDetail.ContentFieldTitle");
         _contentTitle.x = _content.x + _content.width + 10;
         _contentTitle.y = _content.y;
         addChild(_contentTitle);
         _contentField = ComponentFactory.Instance.creatComponentByStylename("wonderful.ActivityState.StateContentField");
         _contentWidth = _contentField.width;
         _contentField.x = _contentTitle.x;
         _contentField.y = _contentTitle.y + _contentTitle.height + 5;
         _contentField.autoSize = "none";
         _contentField.width = _contentWidth;
         _contentField.autoSize = "left";
         _contentField.htmlText = _info.Content;
         _contentField.mouseEnabled = true;
         _contentField.selectable = false;
         addChild(_contentField);
         _line2 = ComponentFactory.Instance.creat("asset.wonderful.ActivityState.SeparatorLine");
         if(_info.HasKey == 1)
         {
            _input = ComponentFactory.Instance.creatBitmap("aaset.wonderful.ActivityState.Pwd");
            _input.x = _contentTitle.x;
            _input.y = _contentField.y + _contentField.height + 10;
            addChild(_input);
            _inputField = ComponentFactory.Instance.creatComponentByStylename("wonderful.ActivityState.InputField");
            _inputField.x = _input.x + _input.width + 5;
            _inputField.y = _input.y - 5;
            addChild(_inputField);
            _line2.x = _line1.x;
            _line2.y = _inputField.y + _inputField.height + 5;
         }
         else
         {
            _line2.x = _line1.x;
            _line2.y = _contentField.y + _contentField.height + 5;
         }
         addChild(_line2);
         _time = ComponentFactory.Instance.creatBitmap("asset.wonderful.ActivityState.TimeIcon");
         _time.x = 30;
         _time.y = _line2.y + _line2.height + 10;
         addChild(_time);
         _timeTitle = ComponentFactory.Instance.creatComponentByStylename("wonderful.ActivityState.TimeFieldTitle");
         _timeTitle.x = _time.x + _time.width + 10;
         _timeTitle.y = _time.y;
         _timeTitle.text = LanguageMgr.GetTranslation("tank.calendar.ActivityDetail.TimeFieldTitle");
         addChild(_timeTitle);
         _timeField = ComponentFactory.Instance.creatComponentByStylename("wonderful.ActivityState.TimeField");
         _timeWidth = _timeField.width;
         _timeField.x = _timeTitle.x;
         _timeField.y = _timeTitle.y + _timeTitle.height + 5;
         _timeField.autoSize = "none";
         _timeField.width = _timeWidth;
         _timeField.text = _info.activeTime();
         addChild(_timeField);
         _line3 = ComponentFactory.Instance.creat("asset.wonderful.ActivityState.SeparatorLine");
         _line3.x = _line1.x;
         _line3.y = _timeField.y + _timeField.height + 5;
         addChild(_line3);
      }
      
      public function getInputField() : TextInput
      {
         return _inputField;
      }
      
      public function dispose() : void
      {
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
      }
   }
}
