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
      
      public function FightLibQuestionFrame(param1:int, param2:String = "", param3:int = 0, param4:int = 0, param5:int = 0, param6:String = "", param7:String = "", param8:String = "", param9:String = "", param10:int = 30){super();}
      
      private function updateInfo() : void{}
      
      private function configUI() : void{}
      
      override protected function init() : void{}
      
      private function addEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __addedToStage(param1:Event) : void{}
      
      private function startupMark() : void{}
      
      private function shutdownMark() : void{}
      
      private function __enterFrame(param1:Event) : void{}
      
      private function markComplete() : void{}
      
      private function __selectAnswer(param1:MouseEvent) : void{}
      
      private function __reAnswer(param1:MouseEvent) : void{}
      
      private function __viewTutorial(param1:MouseEvent) : void{}
      
      override public function dispose() : void{}
      
      public function close() : void{}
      
      public function show() : void{}
   }
}
