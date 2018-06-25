package feedback.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.ComboBox;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import feedback.FeedbackManager;
   import feedback.data.FeedbackInfo;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import road7th.utils.DateUtils;
   
   public class FeedbackSubmitFrame extends BaseAlerFrame
   {
       
      
      private var _box:Sprite;
      
      private var _dayCombox:ComboBox;
      
      private var _dayTextImg:FilterFrameText;
      
      private var _feedbackSp:Disposeable;
      
      private var _monthCombox:ComboBox;
      
      private var _monthTextImg:FilterFrameText;
      
      private var _occurrenceTimeTextImg:FilterFrameText;
      
      private var _problemCombox:ComboBox;
      
      private var _problemTitleAsterisk:Bitmap;
      
      private var _problemTitleInput:TextInput;
      
      private var _problemTitleTextImg:FilterFrameText;
      
      private var _problemTypesAsterisk:Bitmap;
      
      private var _problemTypesTextImg:FilterFrameText;
      
      private var _yearCombox:ComboBox;
      
      private var _yearTextImg:FilterFrameText;
      
      private var _feedbackBg:ScaleBitmapImage;
      
      public function FeedbackSubmitFrame()
      {
         super();
         _init();
      }
      
      public function get problemCombox() : ComboBox
      {
         return _problemCombox;
      }
      
      public function get problemTitleInput() : TextInput
      {
         return _problemTitleInput;
      }
      
      override public function dispose() : void
      {
         remvoeEvent();
         if(_feedbackSp)
         {
            _feedbackSp.dispose();
         }
         ObjectUtils.disposeAllChildren(_box);
         ObjectUtils.disposeObject(_box);
         _box = null;
         ObjectUtils.disposeAllChildren(_feedbackSp as Sprite);
         _feedbackSp = null;
         ObjectUtils.disposeAllChildren(this);
         _problemTypesTextImg = null;
         _problemCombox = null;
         _problemTitleTextImg = null;
         _problemTypesAsterisk = null;
         _problemTitleInput = null;
         _problemTitleAsterisk = null;
         _occurrenceTimeTextImg = null;
         _yearCombox = null;
         _yearTextImg = null;
         _monthCombox = null;
         _monthTextImg = null;
         _dayCombox = null;
         _dayTextImg = null;
         _feedbackBg = null;
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      public function get feedbackInfo() : FeedbackInfo
      {
         FeedbackManager.instance.feedbackInfo.user_id = PlayerManager.Instance.Self.ID;
         FeedbackManager.instance.feedbackInfo.user_name = PlayerManager.Instance.Self.LoginName;
         FeedbackManager.instance.feedbackInfo.user_nick_name = PlayerManager.Instance.Self.NickName;
         if(_problemCombox)
         {
            FeedbackManager.instance.feedbackInfo.question_type = _problemCombox.currentSelectedIndex + 1;
            FeedbackManager.instance.feedbackInfo.question_title = _problemTitleInput.text;
            FeedbackManager.instance.feedbackInfo.occurrence_date = _yearCombox.textField.text + "-" + _monthCombox.textField.text + "-" + _dayCombox.textField.text;
         }
         return FeedbackManager.instance.feedbackInfo;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      private function __frameEventHandler(event:FrameEvent) : void
      {
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               SoundManager.instance.play("008");
               FeedbackManager.instance.closeFrame();
         }
      }
      
      private function __problemComboxChanged(event:Event) : void
      {
         SoundManager.instance.play("008");
         if(_feedbackSp)
         {
            _feedbackSp["setFeedbackInfo"]();
            _feedbackSp.dispose();
         }
         _feedbackSp = getFeedbackSp(_problemCombox.currentSelectedIndex);
         if(_feedbackSp)
         {
            addToContent(_box);
            addToContent(_feedbackSp as Sprite);
            fixFeedBackTopImg(_problemCombox.currentSelectedIndex);
         }
      }
      
      private function fixFeedBackTopImg($type:int) : void
      {
         switch(int($type))
         {
            case 0:
               _feedbackBg.height = 120;
               break;
            case 1:
               _feedbackBg.height = 158;
               break;
            case 2:
               _feedbackBg.height = 190;
               break;
            case 3:
               _feedbackBg.height = 196;
               break;
            case 4:
            case 5:
            case 6:
               _feedbackBg.height = 120;
               break;
            case 7:
               _feedbackBg.height = 203;
               break;
            case 8:
            case 9:
               _feedbackBg.height = 188;
         }
      }
      
      private function _init() : void
      {
         var rec:* = null;
         var i:* = 0;
         titleText = LanguageMgr.GetTranslation("feedback.view.FeedbackSubmitFrame.title");
         _feedbackSp = getFeedbackSp(0);
         addToContent(_feedbackSp as Sprite);
         _box = new Sprite();
         addToContent(_box);
         _problemTypesTextImg = ComponentFactory.Instance.creatComponentByStylename("ddtfeedback.typeText");
         _problemTypesTextImg.text = LanguageMgr.GetTranslation("feedback.view.Feedback.text");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.problemTypesTextImgRec");
         ObjectUtils.copyPropertyByRectangle(_problemTypesTextImg,rec);
         _box.addChildAt(_problemTypesTextImg,0);
         _problemCombox = ComponentFactory.Instance.creatComponentByStylename("feedback.combox");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.comboxRec");
         ObjectUtils.copyPropertyByRectangle(_problemCombox,rec);
         _problemCombox.beginChanges();
         _problemCombox.selctedPropName = "text";
         _problemCombox.listPanel.vectorListModel.append(LanguageMgr.GetTranslation("feedback.view.problemCombox_text0"));
         _problemCombox.listPanel.vectorListModel.append(LanguageMgr.GetTranslation("feedback.view.problemCombox_text1"));
         _problemCombox.listPanel.vectorListModel.append(LanguageMgr.GetTranslation("feedback.view.problemCombox_text2"));
         _problemCombox.listPanel.vectorListModel.append(LanguageMgr.GetTranslation("feedback.view.problemCombox_text3"));
         _problemCombox.listPanel.vectorListModel.append(LanguageMgr.GetTranslation("feedback.view.problemCombox_text4"));
         _problemCombox.listPanel.vectorListModel.append(LanguageMgr.GetTranslation("feedback.view.problemCombox_text5"));
         _problemCombox.listPanel.vectorListModel.append(LanguageMgr.GetTranslation("feedback.view.problemCombox_text6"));
         _problemCombox.listPanel.vectorListModel.append(LanguageMgr.GetTranslation("feedback.view.problemCombox_text7"));
         _problemCombox.listPanel.vectorListModel.append(LanguageMgr.GetTranslation("feedback.view.problemCombox_text8"));
         _problemCombox.listPanel.vectorListModel.append(LanguageMgr.GetTranslation("feedback.view.problemCombox_text9"));
         _problemCombox.commitChanges();
         _problemCombox.textField.text = LanguageMgr.GetTranslation("feedback.view.FeedbackSubmitSp.comBoxText");
         _box.addChildAt(_problemCombox,0);
         _problemTypesAsterisk = ComponentFactory.Instance.creatBitmap("asset.feedback.asteriskImg");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.problemTypesAsteriskTextRec");
         ObjectUtils.copyPropertyByRectangle(_problemTypesAsterisk,rec);
         _box.addChildAt(_problemTypesAsterisk,0);
         _problemTitleTextImg = ComponentFactory.Instance.creatComponentByStylename("ddtfeedback.titleText");
         _problemTitleTextImg.text = LanguageMgr.GetTranslation("feedback.view.Feedback.text1");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.problemTitleTextImgRec");
         ObjectUtils.copyPropertyByRectangle(_problemTitleTextImg,rec);
         _box.addChildAt(_problemTitleTextImg,0);
         _problemTitleInput = ComponentFactory.Instance.creatComponentByStylename("feedback.textInput");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.problemTitleInputRec");
         ObjectUtils.copyPropertyByRectangle(_problemTitleInput,rec);
         _box.addChildAt(_problemTitleInput,0);
         _problemTitleAsterisk = ComponentFactory.Instance.creatBitmap("asset.feedback.asteriskImg");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.problemTitleAsteriskTextRec");
         ObjectUtils.copyPropertyByRectangle(_problemTitleAsterisk,rec);
         _box.addChildAt(_problemTitleAsterisk,0);
         _occurrenceTimeTextImg = ComponentFactory.Instance.creatComponentByStylename("ddtfeedback.timerText");
         _occurrenceTimeTextImg.text = LanguageMgr.GetTranslation("feedback.view.Feedback.text2");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.occurrenceTimeTextImgRec");
         ObjectUtils.copyPropertyByRectangle(_occurrenceTimeTextImg,rec);
         _box.addChildAt(_occurrenceTimeTextImg,0);
         _yearCombox = ComponentFactory.Instance.creatComponentByStylename("feedback.combox2");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.yearComboxRec");
         ObjectUtils.copyPropertyByRectangle(_yearCombox,rec);
         _yearCombox.beginChanges();
         var year:Number = new Date().getFullYear();
         _yearCombox.textField.text = String(year);
         _yearCombox.snapItemHeight = true;
         _yearCombox.selctedPropName = "text";
         for(i = uint(year); i >= year - 2; )
         {
            _yearCombox.listPanel.vectorListModel.append(i);
            i--;
         }
         _yearCombox.commitChanges();
         _box.addChildAt(_yearCombox,0);
         _yearTextImg = ComponentFactory.Instance.creatComponentByStylename("ddtfeedback.yearText");
         _yearTextImg.text = LanguageMgr.GetTranslation("feedback.view.Feedback.text3");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.yearTextImgRec");
         ObjectUtils.copyPropertyByRectangle(_yearTextImg,rec);
         _box.addChildAt(_yearTextImg,0);
         _monthCombox = ComponentFactory.Instance.creatComponentByStylename("feedback.combox3");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.monthComboxRec");
         ObjectUtils.copyPropertyByRectangle(_monthCombox,rec);
         _monthCombox.beginChanges();
         var month:Number = new Date().getMonth() + 1;
         _monthCombox.textField.text = String(month);
         _monthCombox.selctedPropName = "text";
         for(i = uint(1); i <= 12; )
         {
            _monthCombox.listPanel.vectorListModel.append(i);
            i++;
         }
         _monthCombox.commitChanges();
         _box.addChildAt(_monthCombox,0);
         _monthTextImg = ComponentFactory.Instance.creatComponentByStylename("ddtfeedback.monthText");
         _monthTextImg.text = LanguageMgr.GetTranslation("feedback.view.Feedback.text4");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.monthTextImgRec");
         ObjectUtils.copyPropertyByRectangle(_monthTextImg,rec);
         _box.addChildAt(_monthTextImg,0);
         _dayCombox = ComponentFactory.Instance.creatComponentByStylename("feedback.combox4");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.dayComboxRec");
         ObjectUtils.copyPropertyByRectangle(_dayCombox,rec);
         _dayCombox.beginChanges();
         var day:Number = new Date().getDate();
         _dayCombox.textField.text = String(day);
         _dayCombox.selctedPropName = "text";
         var dayTotal:Number = DateUtils.getDays(year,month);
         for(i = uint(1); i <= dayTotal; )
         {
            _dayCombox.listPanel.vectorListModel.append(i);
            i++;
         }
         _dayCombox.commitChanges();
         _box.addChildAt(_dayCombox,0);
         _dayTextImg = ComponentFactory.Instance.creatComponentByStylename("ddtfeedback.dayText");
         _dayTextImg.text = LanguageMgr.GetTranslation("feedback.view.Feedback.text5");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.dayTextImgRec");
         ObjectUtils.copyPropertyByRectangle(_dayTextImg,rec);
         _box.addChildAt(_dayTextImg,0);
         _feedbackBg = ComponentFactory.Instance.creatComponentByStylename("feedback.textBgImg_style1");
         _box.addChildAt(_feedbackBg,0);
         addEvent();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameEventHandler);
         _problemCombox.addEventListener("stateChange",__problemComboxChanged);
         _yearCombox.addEventListener("stateChange",_dateChanged);
         _monthCombox.addEventListener("stateChange",_dateChanged);
         _dayCombox.addEventListener("stateChange",__comboxClick);
         _problemCombox.addEventListener("click",__comboxClick);
         _yearCombox.addEventListener("click",__comboxClick);
         _monthCombox.addEventListener("click",__comboxClick);
         _dayCombox.addEventListener("click",__comboxClick);
      }
      
      private function __comboxClick(event:Event) : void
      {
         SoundManager.instance.play("008");
      }
      
      private function _dateChanged(event:InteractiveEvent) : void
      {
         var i:* = 0;
         SoundManager.instance.play("008");
         _dayCombox.textField.text = "1";
         var dayTotal:Number = DateUtils.getDays(Number(_yearCombox.textField.text),Number(_monthCombox.textField.text));
         _dayCombox.listPanel.vectorListModel.clear();
         _dayCombox.beginChanges();
         for(i = uint(1); i <= dayTotal; )
         {
            _dayCombox.listPanel.vectorListModel.append(i);
            i++;
         }
         _dayCombox.commitChanges();
      }
      
      private function getFeedbackSp($type:int) : Disposeable
      {
         var sp:* = null;
         switch(int($type))
         {
            case 0:
               sp = new FeedbackConsultingSp();
               this.height = 450;
               this.y = 75;
               break;
            case 1:
               sp = new FeedbackProblemsSp();
               this.height = 450;
               this.y = 75;
               break;
            case 2:
               sp = new FeedbackPrepaidCardSp();
               this.height = 450;
               this.y = 75;
               break;
            case 3:
               sp = new FeedbackPropsDisappearSp();
               this.height = 450;
               this.y = 75;
               break;
            case 4:
            case 5:
            case 6:
               sp = new FeedbackStealHandSp();
               PositionUtils.setPos(sp,"feedback.FeedbackStealHandSp.pos");
               this.height = this.height + 40;
               this.y = 55;
               break;
            case 7:
               sp = new FeedbackComplaintSp();
               this.height = 450;
               this.y = 75;
               break;
            case 8:
            case 9:
               sp = new FeedbackReportSp();
               this.height = 450;
               this.y = 75;
         }
         sp["submitFrame"] = this;
         return sp;
      }
      
      private function remvoeEvent() : void
      {
         removeEventListener("response",__frameEventHandler);
         _problemCombox.removeEventListener("stateChange",__problemComboxChanged);
         _yearCombox.removeEventListener("stateChange",_dateChanged);
         _monthCombox.removeEventListener("stateChange",_dateChanged);
         _dayCombox.removeEventListener("stateChange",__comboxClick);
         _problemCombox.removeEventListener("click",__comboxClick);
         _yearCombox.removeEventListener("click",__comboxClick);
         _monthCombox.removeEventListener("click",__comboxClick);
         _dayCombox.removeEventListener("click",__comboxClick);
      }
   }
}
