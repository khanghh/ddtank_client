package feedback.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.TextArea;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SoundManager;
   import feedback.FeedbackEvent;
   import feedback.FeedbackManager;
   import feedback.data.FeedbackReplyInfo;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import road7th.utils.StringHelper;
   
   public class FeedbackReplyFrame extends Frame
   {
       
      
      private var _box:Sprite;
      
      private var _continueSubmitBox:Sprite;
      
      private var _delPostsBox:Sprite;
      
      private var _customerTextImg:FilterFrameText;
      
      private var _dateInput:TextInput;
      
      private var _continueSubmitBtn:TextButton;
      
      private var _backBtn:TextButton;
      
      private var _delPostsBtn:TextButton;
      
      private var _detailTextArea:TextArea;
      
      private var _detailTextArea2:TextArea;
      
      private var _detailTextArea3:TextArea;
      
      private var _detailTextArea4:TextArea;
      
      private var _detailTextImg:FilterFrameText;
      
      private var _detailTextImg3:FilterFrameText;
      
      private var _detailTextImg4:FilterFrameText;
      
      private var _infoText:FilterFrameText;
      
      private var _feedbackReplyInfo:FeedbackReplyInfo;
      
      private var _generalCheckButton:SelectedCheckButton;
      
      private var _occurrenceTimeTextImg:FilterFrameText;
      
      private var _playerEvaluationTextImg:Bitmap;
      
      private var _poorCheckButton:SelectedCheckButton;
      
      private var _problemTitleInput:TextInput;
      
      private var _problemTitleInput4:TextInput;
      
      private var _problemTitleTextImg:FilterFrameText;
      
      private var _problemTitleTextImg4:FilterFrameText;
      
      private var _replyEvaluationTextImg:Bitmap;
      
      private var _satisfactoryCheckButton:SelectedCheckButton;
      
      private var _selectedButtonGroup:SelectedButtonGroup;
      
      private var _submitAssessmentBtn:TextButton;
      
      private var _submitBtn:TextButton;
      
      private var _titleTextBgImg:Bitmap;
      
      private var _verySatisfiedCheckButton:SelectedCheckButton;
      
      public function FeedbackReplyFrame()
      {
         super();
         _init();
      }
      
      override public function dispose() : void
      {
         remvoeEvent();
         ObjectUtils.disposeAllChildren(_box);
         _box = null;
         ObjectUtils.disposeAllChildren(_delPostsBox);
         _delPostsBox = null;
         ObjectUtils.disposeAllChildren(_continueSubmitBox);
         _continueSubmitBox = null;
         ObjectUtils.disposeAllChildren(this);
         _customerTextImg = null;
         _dateInput = null;
         _continueSubmitBtn = null;
         _backBtn = null;
         _delPostsBtn = null;
         _detailTextArea = null;
         _detailTextArea2 = null;
         _detailTextArea3 = null;
         _detailTextArea4 = null;
         _detailTextImg = null;
         _detailTextImg3 = null;
         _detailTextImg4 = null;
         _infoText = null;
         _feedbackReplyInfo = null;
         _generalCheckButton = null;
         _occurrenceTimeTextImg = null;
         _playerEvaluationTextImg = null;
         _poorCheckButton = null;
         _problemTitleInput = null;
         _problemTitleInput4 = null;
         _problemTitleTextImg = null;
         _problemTitleTextImg4 = null;
         _replyEvaluationTextImg = null;
         _satisfactoryCheckButton = null;
         _selectedButtonGroup = null;
         _submitAssessmentBtn = null;
         _submitBtn = null;
         _titleTextBgImg = null;
         _verySatisfiedCheckButton = null;
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      public function setup(feedbackReplyInfo:FeedbackReplyInfo) : void
      {
         _feedbackReplyInfo = feedbackReplyInfo;
         _problemTitleInput.text = feedbackReplyInfo.questionTitle;
         var dateArr:Array = feedbackReplyInfo.occurrenceDate.split("-");
         _dateInput.text = LanguageMgr.GetTranslation("tank.data.MovementInfo.date",dateArr[0],dateArr[1],dateArr[2]);
         _detailTextArea.text = feedbackReplyInfo.questionContent;
         _detailTextArea2.text = feedbackReplyInfo.replyContent;
         _problemTitleInput4.text = feedbackReplyInfo.questionTitle;
         changereplyEvaluationTex(feedbackReplyInfo.stopReply);
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      private function ___submitAssessmentBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         FeedbackManager.instance.delPosts(_feedbackReplyInfo.questionId,_feedbackReplyInfo.replyId,_selectedButtonGroup.selectIndex + 1,_detailTextArea3.text);
      }
      
      private function __backBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _continueSubmitBox.visible = false;
         _box.visible = true;
      }
      
      private function __continueSubmitBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _box.visible = false;
         _continueSubmitBox.visible = true;
      }
      
      private function __delPostsBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _box.visible = false;
         _delPostsBox.visible = true;
      }
      
      private function __frameEventHandler(event:FrameEvent) : void
      {
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               FeedbackManager.instance.closeFrame();
         }
      }
      
      private function __submitBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(StringHelper.isNullOrEmpty(_detailTextArea4.text))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("feedback.view.question_content"));
            return;
         }
         if(_detailTextArea4.text.length < 8)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("feedback.view.question_LessThanEight"));
            return;
         }
         FeedbackManager.instance.continueSubmit(_feedbackReplyInfo.questionId,_feedbackReplyInfo.replyId,_detailTextArea4.text);
      }
      
      private function __textInput(event:Event) : void
      {
         _infoText.text = LanguageMgr.GetTranslation("feedback.view.infoText",_detailTextArea4.maxChars - _detailTextArea4.textField.length);
      }
      
      private function _init() : void
      {
         var rec:* = null;
         titleText = LanguageMgr.GetTranslation("feedback.view.FeedbackSubmitFrame.title");
         _box = new Sprite();
         addToContent(_box);
         _problemTitleTextImg = ComponentFactory.Instance.creatComponentByStylename("ddtfeedback.titleText");
         _problemTitleTextImg.text = LanguageMgr.GetTranslation("feedback.view.Feedback.text1");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.problemTitleTextImg1Rec");
         ObjectUtils.copyPropertyByRectangle(_problemTitleTextImg,rec);
         _box.addChildAt(_problemTitleTextImg,0);
         _problemTitleInput = ComponentFactory.Instance.creatComponentByStylename("feedback.textInput");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.problemTitleInput1Rec");
         ObjectUtils.copyPropertyByRectangle(_problemTitleInput,rec);
         _problemTitleInput.enable = false;
         _box.addChildAt(_problemTitleInput,0);
         _occurrenceTimeTextImg = ComponentFactory.Instance.creatComponentByStylename("ddtfeedback.timerText");
         _occurrenceTimeTextImg.text = LanguageMgr.GetTranslation("feedback.view.Feedback.text2");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.occurrenceTimeTextImgRec2");
         ObjectUtils.copyPropertyByRectangle(_occurrenceTimeTextImg,rec);
         _box.addChildAt(_occurrenceTimeTextImg,0);
         _dateInput = ComponentFactory.Instance.creatComponentByStylename("feedback.textInput");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.dateInputRec");
         ObjectUtils.copyPropertyByRectangle(_dateInput,rec);
         _dateInput.enable = false;
         _box.addChildAt(_dateInput,0);
         _detailTextImg = ComponentFactory.Instance.creatComponentByStylename("ddtfeedback.descriptionText");
         _detailTextImg.text = LanguageMgr.GetTranslation("feedback.view.Feedback.text6");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.detailTextImg1Rec");
         ObjectUtils.copyPropertyByRectangle(_detailTextImg,rec);
         _box.addChildAt(_detailTextImg,0);
         _detailTextArea = ComponentFactory.Instance.creatComponentByStylename("feedback.simpleTextArea");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.detailSimpleTextArea1Rec");
         ObjectUtils.copyPropertyByRectangle(_detailTextArea,rec);
         _detailTextArea.textField.type = "dynamic";
         _box.addChildAt(_detailTextArea,0);
         _customerTextImg = ComponentFactory.Instance.creatComponentByStylename("ddtfeedback.descriptionText");
         _customerTextImg.text = LanguageMgr.GetTranslation("feedback.view.problemCombox_text10");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.customerTextImgRec");
         ObjectUtils.copyPropertyByRectangle(_customerTextImg,rec);
         _box.addChildAt(_customerTextImg,0);
         _detailTextArea2 = ComponentFactory.Instance.creatComponentByStylename("feedback.simpleTextArea");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.detailSimpleTextArea2Rec");
         ObjectUtils.copyPropertyByRectangle(_detailTextArea2,rec);
         _detailTextArea2.textField.type = "dynamic";
         _box.addChildAt(_detailTextArea2,0);
         _delPostsBtn = ComponentFactory.Instance.creatComponentByStylename("feedback.btn");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.submitBtnRec");
         ObjectUtils.copyPropertyByRectangle(_delPostsBtn,rec);
         _delPostsBtn.text = LanguageMgr.GetTranslation("feedback.view.delPostsBtnText");
         _box.addChildAt(_delPostsBtn,0);
         _continueSubmitBtn = ComponentFactory.Instance.creatComponentByStylename("feedback.btn");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.continueSubmitBtnRec");
         ObjectUtils.copyPropertyByRectangle(_continueSubmitBtn,rec);
         _continueSubmitBtn.text = LanguageMgr.GetTranslation("feedback.view.continueSubmitBtnText");
         _box.addChildAt(_continueSubmitBtn,0);
         _delPostsBox = new Sprite();
         addToContent(_delPostsBox);
         _delPostsBox.visible = false;
         _titleTextBgImg = ComponentFactory.Instance.creatBitmap("asset.feedback.titleTextBgImg");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.titleTextBgImgRec");
         ObjectUtils.copyPropertyByRectangle(_titleTextBgImg,rec);
         _delPostsBox.addChildAt(_titleTextBgImg,0);
         _playerEvaluationTextImg = ComponentFactory.Instance.creatBitmap("asset.feedback.playerEvaluationTextImg");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.playerEvaluationTextImgRec");
         ObjectUtils.copyPropertyByRectangle(_playerEvaluationTextImg,rec);
         _delPostsBox.addChildAt(_playerEvaluationTextImg,0);
         _replyEvaluationTextImg = ComponentFactory.Instance.creatBitmap("asset.feedback.replyEvaluationTextImg");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.replyEvaluationTextImgRec");
         ObjectUtils.copyPropertyByRectangle(_replyEvaluationTextImg,rec);
         _delPostsBox.addChildAt(_replyEvaluationTextImg,0);
         _poorCheckButton = ComponentFactory.Instance.creatComponentByStylename("feedback.poorCheckButton");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.poorCheckButtonRec");
         ObjectUtils.copyPropertyByRectangle(_poorCheckButton,rec);
         _delPostsBox.addChildAt(_poorCheckButton,0);
         _generalCheckButton = ComponentFactory.Instance.creatComponentByStylename("feedback.generalCheckButton");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.generalCheckButtonRec");
         ObjectUtils.copyPropertyByRectangle(_generalCheckButton,rec);
         _delPostsBox.addChildAt(_generalCheckButton,0);
         _satisfactoryCheckButton = ComponentFactory.Instance.creatComponentByStylename("feedback.satisfactoryCheckButton");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.satisfactoryCheckButtonRec");
         ObjectUtils.copyPropertyByRectangle(_satisfactoryCheckButton,rec);
         _delPostsBox.addChildAt(_satisfactoryCheckButton,0);
         _verySatisfiedCheckButton = ComponentFactory.Instance.creatComponentByStylename("feedback.verySatisfiedCheckButton");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.verySatisfiedCheckButtonRec");
         ObjectUtils.copyPropertyByRectangle(_verySatisfiedCheckButton,rec);
         _delPostsBox.addChildAt(_verySatisfiedCheckButton,0);
         _selectedButtonGroup = new SelectedButtonGroup(false,1);
         _selectedButtonGroup.addSelectItem(_poorCheckButton);
         _selectedButtonGroup.addSelectItem(_generalCheckButton);
         _selectedButtonGroup.addSelectItem(_satisfactoryCheckButton);
         _selectedButtonGroup.addSelectItem(_verySatisfiedCheckButton);
         _selectedButtonGroup.selectIndex = 3;
         _detailTextImg3 = ComponentFactory.Instance.creatComponentByStylename("ddtfeedback.descriptionText");
         _detailTextImg3.text = LanguageMgr.GetTranslation("feedback.view.Feedback.text6");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.detailTextImg3Rec");
         ObjectUtils.copyPropertyByRectangle(_detailTextImg3,rec);
         _delPostsBox.addChildAt(_detailTextImg3,0);
         _detailTextArea3 = ComponentFactory.Instance.creatComponentByStylename("feedback.simpleTextArea");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.detailSimpleTextArea3Rec");
         ObjectUtils.copyPropertyByRectangle(_detailTextArea3,rec);
         _delPostsBox.addChildAt(_detailTextArea3,0);
         _submitAssessmentBtn = ComponentFactory.Instance.creatComponentByStylename("feedback.btn");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.submitAssessmentBtnRec");
         ObjectUtils.copyPropertyByRectangle(_submitAssessmentBtn,rec);
         _submitAssessmentBtn.text = LanguageMgr.GetTranslation("feedback.view.submitAssessmentBtnText");
         _delPostsBox.addChildAt(_submitAssessmentBtn,0);
         _continueSubmitBox = new Sprite();
         addToContent(_continueSubmitBox);
         _continueSubmitBox.visible = false;
         _problemTitleTextImg4 = ComponentFactory.Instance.creatComponentByStylename("ddtfeedback.titleText");
         _problemTitleTextImg4.text = LanguageMgr.GetTranslation("feedback.view.Feedback.text1");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.problemTitleTextImg1Rec");
         ObjectUtils.copyPropertyByRectangle(_problemTitleTextImg4,rec);
         _continueSubmitBox.addChildAt(_problemTitleTextImg4,0);
         _problemTitleInput4 = ComponentFactory.Instance.creatComponentByStylename("feedback.textInput");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.problemTitleInput1Rec");
         ObjectUtils.copyPropertyByRectangle(_problemTitleInput4,rec);
         _problemTitleInput4.enable = false;
         _continueSubmitBox.addChildAt(_problemTitleInput4,0);
         _detailTextImg4 = ComponentFactory.Instance.creatComponentByStylename("ddtfeedback.descriptionText");
         _detailTextImg4.text = LanguageMgr.GetTranslation("feedback.view.Feedback.text6");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.detailTextImg4Rec");
         ObjectUtils.copyPropertyByRectangle(_detailTextImg4,rec);
         _continueSubmitBox.addChildAt(_detailTextImg4,0);
         _detailTextArea4 = ComponentFactory.Instance.creatComponentByStylename("feedback.simpleTextArea");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.detailSimpleTextArea4Rec");
         ObjectUtils.copyPropertyByRectangle(_detailTextArea4,rec);
         _continueSubmitBox.addChildAt(_detailTextArea4,0);
         _infoText = ComponentFactory.Instance.creatComponentByStylename("feedback.infoText");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.detailTextInfoText4Rec");
         ObjectUtils.copyPropertyByRectangle(_infoText,rec);
         _infoText.text = LanguageMgr.GetTranslation("feedback.view.infoText",_detailTextArea4.maxChars);
         _continueSubmitBox.addChildAt(_infoText,0);
         _backBtn = ComponentFactory.Instance.creatComponentByStylename("feedback.btn");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.stealHandBackBtnRec");
         ObjectUtils.copyPropertyByRectangle(_backBtn,rec);
         _backBtn.text = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.preview");
         _continueSubmitBox.addChildAt(_backBtn,0);
         _submitBtn = ComponentFactory.Instance.creatComponentByStylename("feedback.btn");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.stealHandSubmitBtnRec");
         ObjectUtils.copyPropertyByRectangle(_submitBtn,rec);
         _submitBtn.text = LanguageMgr.GetTranslation("feedback.view.FeedbackSubmitSp.submitBtnText");
         _continueSubmitBox.addChildAt(_submitBtn,0);
         addEvent();
      }
      
      private function changereplyEvaluationTex(str:String) : void
      {
         var _loc2_:* = str;
         if("0" !== _loc2_)
         {
            if("1" === _loc2_)
            {
               if(_continueSubmitBtn)
               {
                  _continueSubmitBtn.visible = false;
               }
            }
         }
         else if(_continueSubmitBtn)
         {
            _continueSubmitBtn.visible = true;
         }
      }
      
      private function feedbackStopReplyEvt(e:FeedbackEvent) : void
      {
         changereplyEvaluationTex(e.data.stopReply);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameEventHandler);
         _delPostsBtn.addEventListener("click",__delPostsBtnClick);
         _continueSubmitBtn.addEventListener("click",__continueSubmitBtnClick);
         _backBtn.addEventListener("click",__backBtnClick);
         _submitBtn.addEventListener("click",__submitBtnClick);
         _submitAssessmentBtn.addEventListener("click",___submitAssessmentBtnClick);
         FeedbackManager.instance.addEventListener("feedbackStopReply",feedbackStopReplyEvt);
         _detailTextArea4.textField.addEventListener("change",__textInput);
      }
      
      private function remvoeEvent() : void
      {
         removeEventListener("response",__frameEventHandler);
         _delPostsBtn.removeEventListener("click",__delPostsBtnClick);
         _continueSubmitBtn.removeEventListener("click",__continueSubmitBtnClick);
         _backBtn.removeEventListener("click",__backBtnClick);
         _detailTextArea4.textField.removeEventListener("change",__textInput);
         _submitBtn.removeEventListener("click",__submitBtnClick);
         _submitAssessmentBtn.removeEventListener("click",___submitAssessmentBtnClick);
      }
   }
}
