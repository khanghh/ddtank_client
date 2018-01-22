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
      
      public function FeedbackReplyFrame(){super();}
      
      override public function dispose() : void{}
      
      public function setup(param1:FeedbackReplyInfo) : void{}
      
      public function show() : void{}
      
      private function ___submitAssessmentBtnClick(param1:MouseEvent) : void{}
      
      private function __backBtnClick(param1:MouseEvent) : void{}
      
      private function __continueSubmitBtnClick(param1:MouseEvent) : void{}
      
      private function __delPostsBtnClick(param1:MouseEvent) : void{}
      
      private function __frameEventHandler(param1:FrameEvent) : void{}
      
      private function __submitBtnClick(param1:MouseEvent) : void{}
      
      private function __textInput(param1:Event) : void{}
      
      private function _init() : void{}
      
      private function changereplyEvaluationTex(param1:String) : void{}
      
      private function feedbackStopReplyEvt(param1:FeedbackEvent) : void{}
      
      private function addEvent() : void{}
      
      private function remvoeEvent() : void{}
   }
}
