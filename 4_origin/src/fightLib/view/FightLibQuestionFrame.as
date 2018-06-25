package fightLib.view
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import fightLib.FightLibControl;
   import fightLib.FightLibManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.getTimer;
   
   public class FightLibQuestionFrame extends Frame
   {
      
      private static const MarkRate:int = 1000;
       
      
      private var _reAnswerBtn:TextButton;
      
      private var _rightBottomBg:ScaleBitmapImage;
      
      private var _viewTutorialBtn:TextButton;
      
      private var _answerBtn1:BaseButton;
      
      private var _answerBtn2:BaseButton;
      
      private var _answerBtn3:BaseButton;
      
      private var _hasAnswered:int;
      
      private var _needAnswer:int;
      
      private var _totalQuestion:int;
      
      private var _question:String;
      
      private var _answer1:String;
      
      private var _answer2:String;
      
      private var _answer3:String;
      
      private var _timeLimit:int;
      
      private var _questionInfoField:FilterFrameText;
      
      private var _questionField:FilterFrameText;
      
      private var _timeField:FilterFrameText;
      
      private var _answerBack:MutipleImage;
      
      private var _answerField1:FilterFrameText;
      
      private var _answerField2:FilterFrameText;
      
      private var _answerField3:FilterFrameText;
      
      private var _answerPosField1:FilterFrameText;
      
      private var _answerPosField2:FilterFrameText;
      
      private var _answerPosField3:FilterFrameText;
      
      private var _markStart:Boolean = false;
      
      private var _elapsed:int = 0;
      
      private var _markBlank:int = 0;
      
      private var _startTime:int = 0;
      
      public function FightLibQuestionFrame(id:int, title:String = "", hasAnswered:int = 0, needAnswer:int = 0, totalQuestion:int = 0, question:String = "", answer1:String = "", answer2:String = "", answer3:String = "", timeLimit:int = 30)
      {
         super();
         _id = id;
         titleText = title;
         _hasAnswered = hasAnswered;
         _needAnswer = needAnswer;
         _totalQuestion = totalQuestion;
         _question = question;
         _answer1 = answer1;
         _answer2 = answer2;
         _answer3 = answer3;
         _timeLimit = timeLimit + 1;
         updateInfo();
      }
      
      private function updateInfo() : void
      {
         _questionInfoField.text = LanguageMgr.GetTranslation("tank.fightLib.questionInfo",_totalQuestion,_needAnswer,_hasAnswered,_totalQuestion - id);
         _questionField.text = _question;
         _answerField1.text = _answer1;
         _answerField2.text = _answer2;
         _answerField3.text = _answer3;
         var postion:Point = ComponentFactory.Instance.creatCustomObject("fightLib.Question.Time.TopRight");
         _timeField.text = String(_timeLimit) + LanguageMgr.GetTranslation("second");
         _timeField.x = postion.x - _timeField.width;
         _timeField.y = postion.y;
      }
      
      private function configUI() : void
      {
         _answerBack = ComponentFactory.Instance.creatComponentByStylename("tank.view.fightLib.AnswerBack");
         _container.addChild(_answerBack);
         _rightBottomBg = ComponentFactory.Instance.creatComponentByStylename("fightlib.questFrame.rightBottomBgImg");
         _container.addChild(_rightBottomBg);
         _questionInfoField = ComponentFactory.Instance.creatComponentByStylename("fightLib.Question.InfoField");
         _container.addChild(_questionInfoField);
         _questionField = ComponentFactory.Instance.creatComponentByStylename("fightLib.Question.QuestionField");
         _container.addChild(_questionField);
         _timeField = ComponentFactory.Instance.creatComponentByStylename("fightLib.Question.TimeField");
         _container.addChild(_timeField);
         _reAnswerBtn = ComponentFactory.Instance.creatComponentByStylename("fightLib.Question.ReAnswerButton");
         _reAnswerBtn.text = LanguageMgr.GetTranslation("tank.fightLib.FightLibQuestionFrame.reAnswer");
         _container.addChild(_reAnswerBtn);
         _viewTutorialBtn = ComponentFactory.Instance.creatComponentByStylename("fightLib.Question.ViewTutorialButton");
         _viewTutorialBtn.text = LanguageMgr.GetTranslation("tank.fightLib.FightLibQuestionFrame.viewTutorial");
         _container.addChild(_viewTutorialBtn);
         _answerBtn1 = ComponentFactory.Instance.creatComponentByStylename("fightLib.Question.Answer1");
         _container.addChild(_answerBtn1);
         _answerPosField1 = ComponentFactory.Instance.creatComponentByStylename("fightLib.Question.Answer.PositionField");
         _answerPosField1.text = "A";
         _answerBtn1.addChild(_answerPosField1);
         _answerField1 = ComponentFactory.Instance.creatComponentByStylename("fightLib.Question.AnswerField");
         _answerBtn1.addChild(_answerField1);
         _answerBtn2 = ComponentFactory.Instance.creatComponentByStylename("fightLib.Question.Answer2");
         _container.addChild(_answerBtn2);
         _answerPosField2 = ComponentFactory.Instance.creatComponentByStylename("fightLib.Question.Answer.PositionField");
         _answerPosField2.text = "B";
         _answerBtn2.addChild(_answerPosField2);
         _answerField2 = ComponentFactory.Instance.creatComponentByStylename("fightLib.Question.AnswerField");
         _answerBtn2.addChild(_answerField2);
         _answerBtn3 = ComponentFactory.Instance.creatComponentByStylename("fightLib.Question.Answer3");
         _container.addChild(_answerBtn3);
         _answerPosField3 = ComponentFactory.Instance.creatComponentByStylename("fightLib.Question.Answer.PositionField");
         _answerPosField3.text = "C";
         _answerBtn3.addChild(_answerPosField3);
         _answerField3 = ComponentFactory.Instance.creatComponentByStylename("fightLib.Question.AnswerField");
         _answerBtn3.addChild(_answerField3);
      }
      
      override protected function init() : void
      {
         super.init();
         configUI();
         addEvent();
      }
      
      private function addEvent() : void
      {
         addEventListener("addedToStage",__addedToStage);
         _answerBtn1.addEventListener("click",__selectAnswer);
         _answerBtn2.addEventListener("click",__selectAnswer);
         _answerBtn3.addEventListener("click",__selectAnswer);
         _reAnswerBtn.addEventListener("click",__reAnswer);
         _viewTutorialBtn.addEventListener("click",__viewTutorial);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("addedToStage",__addedToStage);
         if(_answerBtn1)
         {
            _answerBtn1.removeEventListener("click",__selectAnswer);
         }
         if(_answerBtn2)
         {
            _answerBtn2.removeEventListener("click",__selectAnswer);
         }
         if(_answerBtn3)
         {
            _answerBtn3.removeEventListener("click",__selectAnswer);
         }
         if(_reAnswerBtn)
         {
            _reAnswerBtn.removeEventListener("click",__reAnswer);
         }
         if(_viewTutorialBtn)
         {
            _viewTutorialBtn.removeEventListener("click",__viewTutorial);
         }
      }
      
      private function __addedToStage(evt:Event) : void
      {
         removeEventListener("addedToStage",__addedToStage);
         startupMark();
      }
      
      private function startupMark() : void
      {
         if(!_markStart)
         {
            _startTime = getTimer();
            _elapsed = 0;
            _markBlank = 0;
            StageReferance.stage.addEventListener("enterFrame",__enterFrame);
            _markStart = true;
         }
      }
      
      private function shutdownMark() : void
      {
         StageReferance.stage.removeEventListener("enterFrame",__enterFrame);
         _markStart = false;
      }
      
      private function __enterFrame(evt:Event) : void
      {
         var now:int = getTimer();
         var markRate:int = now - _elapsed;
         _elapsed = now - _startTime;
         if(_elapsed >= _timeLimit * 1000)
         {
            shutdownMark();
            markComplete();
         }
         else
         {
            _markBlank = _markBlank + markRate;
            if(_markBlank >= 1000)
            {
               if(_timeField)
               {
                  _timeField.text = String(int(_timeLimit - _elapsed / 1000)) + LanguageMgr.GetTranslation("second");
               }
               _markBlank = 0;
            }
         }
      }
      
      private function markComplete() : void
      {
         GameInSocketOut.sendFightLibAnswer(_id,-1);
         GameInSocketOut.sendGameSkipNext(int(_elapsed / 1000));
         close();
      }
      
      private function __selectAnswer(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:* = false;
         _answerBtn3.enable = _loc2_;
         _loc2_ = _loc2_;
         _answerBtn2.enable = _loc2_;
         _answerBtn1.enable = _loc2_;
         if(evt.currentTarget == _answerBtn1)
         {
            GameInSocketOut.sendFightLibAnswer(_id,0);
         }
         else if(evt.currentTarget == _answerBtn2)
         {
            GameInSocketOut.sendFightLibAnswer(_id,1);
         }
         else
         {
            GameInSocketOut.sendFightLibAnswer(_id,2);
         }
         GameInSocketOut.sendGameSkipNext(int(_elapsed / 1000));
         close();
      }
      
      private function __reAnswer(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         GameInSocketOut.sendFightLibReanswer();
         FightLibManager.Instance.reAnswerNum--;
      }
      
      private function __viewTutorial(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         FightLibControl.Instance.script.restart();
         GameInSocketOut.sendClientScriptStart();
         close();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_rightBottomBg);
         _rightBottomBg = null;
         if(_reAnswerBtn)
         {
            _reAnswerBtn.dispose();
            _reAnswerBtn = null;
         }
         if(_viewTutorialBtn)
         {
            _viewTutorialBtn.dispose();
            _viewTutorialBtn = null;
         }
         if(_answerField1)
         {
            ObjectUtils.disposeObject(_answerField1);
         }
         _answerField1 = null;
         if(_answerField2)
         {
            ObjectUtils.disposeObject(_answerField2);
         }
         _answerField2 = null;
         if(_answerField3)
         {
            ObjectUtils.disposeObject(_answerField3);
         }
         _answerField3 = null;
         if(_answerPosField1)
         {
            ObjectUtils.disposeObject(_answerPosField1);
         }
         _answerPosField1 = null;
         if(_answerPosField2)
         {
            ObjectUtils.disposeObject(_answerPosField2);
         }
         _answerPosField2 = null;
         if(_answerPosField3)
         {
            ObjectUtils.disposeObject(_answerPosField3);
         }
         _answerPosField3 = null;
         if(_answerBack)
         {
            ObjectUtils.disposeObject(_answerBack);
         }
         _answerBack = null;
         if(_timeField)
         {
            ObjectUtils.disposeObject(_timeField);
         }
         _timeField = null;
         super.dispose();
      }
      
      public function close() : void
      {
         if(_markStart)
         {
            shutdownMark();
         }
         ObjectUtils.disposeObject(this);
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,4,true);
      }
   }
}
