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
      
      private function __frameEventHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               SoundManager.instance.play("008");
               FeedbackManager.instance.closeFrame();
         }
      }
      
      private function __problemComboxChanged(param1:Event) : void
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
      
      private function fixFeedBackTopImg(param1:int) : void
      {
         switch(int(param1))
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
         var _loc1_:* = null;
         var _loc6_:* = 0;
         titleText = LanguageMgr.GetTranslation("feedback.view.FeedbackSubmitFrame.title");
         _feedbackSp = getFeedbackSp(0);
         addToContent(_feedbackSp as Sprite);
         _box = new Sprite();
         addToContent(_box);
         _problemTypesTextImg = ComponentFactory.Instance.creatComponentByStylename("ddtfeedback.typeText");
         _problemTypesTextImg.text = LanguageMgr.GetTranslation("feedback.view.Feedback.text");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("feedback.problemTypesTextImgRec");
         ObjectUtils.copyPropertyByRectangle(_problemTypesTextImg,_loc1_);
         _box.addChildAt(_problemTypesTextImg,0);
         _problemCombox = ComponentFactory.Instance.creatComponentByStylename("feedback.combox");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("feedback.comboxRec");
         ObjectUtils.copyPropertyByRectangle(_problemCombox,_loc1_);
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
         _loc1_ = ComponentFactory.Instance.creatCustomObject("feedback.problemTypesAsteriskTextRec");
         ObjectUtils.copyPropertyByRectangle(_problemTypesAsterisk,_loc1_);
         _box.addChildAt(_problemTypesAsterisk,0);
         _problemTitleTextImg = ComponentFactory.Instance.creatComponentByStylename("ddtfeedback.titleText");
         _problemTitleTextImg.text = LanguageMgr.GetTranslation("feedback.view.Feedback.text1");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("feedback.problemTitleTextImgRec");
         ObjectUtils.copyPropertyByRectangle(_problemTitleTextImg,_loc1_);
         _box.addChildAt(_problemTitleTextImg,0);
         _problemTitleInput = ComponentFactory.Instance.creatComponentByStylename("feedback.textInput");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("feedback.problemTitleInputRec");
         ObjectUtils.copyPropertyByRectangle(_problemTitleInput,_loc1_);
         _box.addChildAt(_problemTitleInput,0);
         _problemTitleAsterisk = ComponentFactory.Instance.creatBitmap("asset.feedback.asteriskImg");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("feedback.problemTitleAsteriskTextRec");
         ObjectUtils.copyPropertyByRectangle(_problemTitleAsterisk,_loc1_);
         _box.addChildAt(_problemTitleAsterisk,0);
         _occurrenceTimeTextImg = ComponentFactory.Instance.creatComponentByStylename("ddtfeedback.timerText");
         _occurrenceTimeTextImg.text = LanguageMgr.GetTranslation("feedback.view.Feedback.text2");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("feedback.occurrenceTimeTextImgRec");
         ObjectUtils.copyPropertyByRectangle(_occurrenceTimeTextImg,_loc1_);
         _box.addChildAt(_occurrenceTimeTextImg,0);
         _yearCombox = ComponentFactory.Instance.creatComponentByStylename("feedback.combox2");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("feedback.yearComboxRec");
         ObjectUtils.copyPropertyByRectangle(_yearCombox,_loc1_);
         _yearCombox.beginChanges();
         var _loc4_:Number = new Date().getFullYear();
         _yearCombox.textField.text = String(_loc4_);
         _yearCombox.snapItemHeight = true;
         _yearCombox.selctedPropName = "text";
         _loc6_ = uint(_loc4_);
         while(_loc6_ >= _loc4_ - 2)
         {
            _yearCombox.listPanel.vectorListModel.append(_loc6_);
            _loc6_--;
         }
         _yearCombox.commitChanges();
         _box.addChildAt(_yearCombox,0);
         _yearTextImg = ComponentFactory.Instance.creatComponentByStylename("ddtfeedback.yearText");
         _yearTextImg.text = LanguageMgr.GetTranslation("feedback.view.Feedback.text3");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("feedback.yearTextImgRec");
         ObjectUtils.copyPropertyByRectangle(_yearTextImg,_loc1_);
         _box.addChildAt(_yearTextImg,0);
         _monthCombox = ComponentFactory.Instance.creatComponentByStylename("feedback.combox3");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("feedback.monthComboxRec");
         ObjectUtils.copyPropertyByRectangle(_monthCombox,_loc1_);
         _monthCombox.beginChanges();
         var _loc2_:Number = new Date().getMonth() + 1;
         _monthCombox.textField.text = String(_loc2_);
         _monthCombox.selctedPropName = "text";
         _loc6_ = uint(1);
         while(_loc6_ <= 12)
         {
            _monthCombox.listPanel.vectorListModel.append(_loc6_);
            _loc6_++;
         }
         _monthCombox.commitChanges();
         _box.addChildAt(_monthCombox,0);
         _monthTextImg = ComponentFactory.Instance.creatComponentByStylename("ddtfeedback.monthText");
         _monthTextImg.text = LanguageMgr.GetTranslation("feedback.view.Feedback.text4");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("feedback.monthTextImgRec");
         ObjectUtils.copyPropertyByRectangle(_monthTextImg,_loc1_);
         _box.addChildAt(_monthTextImg,0);
         _dayCombox = ComponentFactory.Instance.creatComponentByStylename("feedback.combox4");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("feedback.dayComboxRec");
         ObjectUtils.copyPropertyByRectangle(_dayCombox,_loc1_);
         _dayCombox.beginChanges();
         var _loc5_:Number = new Date().getDate();
         _dayCombox.textField.text = String(_loc5_);
         _dayCombox.selctedPropName = "text";
         var _loc3_:Number = DateUtils.getDays(_loc4_,_loc2_);
         _loc6_ = uint(1);
         while(_loc6_ <= _loc3_)
         {
            _dayCombox.listPanel.vectorListModel.append(_loc6_);
            _loc6_++;
         }
         _dayCombox.commitChanges();
         _box.addChildAt(_dayCombox,0);
         _dayTextImg = ComponentFactory.Instance.creatComponentByStylename("ddtfeedback.dayText");
         _dayTextImg.text = LanguageMgr.GetTranslation("feedback.view.Feedback.text5");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("feedback.dayTextImgRec");
         ObjectUtils.copyPropertyByRectangle(_dayTextImg,_loc1_);
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
      
      private function __comboxClick(param1:Event) : void
      {
         SoundManager.instance.play("008");
      }
      
      private function _dateChanged(param1:InteractiveEvent) : void
      {
         var _loc3_:* = 0;
         SoundManager.instance.play("008");
         _dayCombox.textField.text = "1";
         var _loc2_:Number = DateUtils.getDays(Number(_yearCombox.textField.text),Number(_monthCombox.textField.text));
         _dayCombox.listPanel.vectorListModel.clear();
         _dayCombox.beginChanges();
         _loc3_ = uint(1);
         while(_loc3_ <= _loc2_)
         {
            _dayCombox.listPanel.vectorListModel.append(_loc3_);
            _loc3_++;
         }
         _dayCombox.commitChanges();
      }
      
      private function getFeedbackSp(param1:int) : Disposeable
      {
         var _loc2_:* = null;
         switch(int(param1))
         {
            case 0:
               _loc2_ = new FeedbackConsultingSp();
               this.height = 450;
               this.y = 75;
               break;
            case 1:
               _loc2_ = new FeedbackProblemsSp();
               this.height = 450;
               this.y = 75;
               break;
            case 2:
               _loc2_ = new FeedbackPrepaidCardSp();
               this.height = 450;
               this.y = 75;
               break;
            case 3:
               _loc2_ = new FeedbackPropsDisappearSp();
               this.height = 450;
               this.y = 75;
               break;
            case 4:
            case 5:
            case 6:
               _loc2_ = new FeedbackStealHandSp();
               PositionUtils.setPos(_loc2_,"feedback.FeedbackStealHandSp.pos");
               this.height = this.height + 40;
               this.y = 55;
               break;
            case 7:
               _loc2_ = new FeedbackComplaintSp();
               this.height = 450;
               this.y = 75;
               break;
            case 8:
            case 9:
               _loc2_ = new FeedbackReportSp();
               this.height = 450;
               this.y = 75;
         }
         _loc2_["submitFrame"] = this;
         return _loc2_;
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
