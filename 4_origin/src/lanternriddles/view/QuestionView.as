package lanternriddles.view
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import lanternriddles.LanternRiddlesManager;
   import lanternriddles.data.LanternInfo;
   import road7th.comm.PackageIn;
   
   public class QuestionView extends Sprite
   {
      
      private static var SELECT_NUM:int = 4;
       
      
      private var _questionTitle:FilterFrameText;
      
      private var _questionCount:FilterFrameText;
      
      private var _cdTime:FilterFrameText;
      
      private var _question:FilterFrameText;
      
      private var _question2:FilterFrameText;
      
      private var _selectVec:Vector.<MovieImage>;
      
      private var _grayFilters:Array;
      
      private var _countDownTime:Number;
      
      private var _timer:Timer;
      
      private var _count:int;
      
      private var _info:LanternInfo;
      
      private var _resultMovie:MovieImage;
      
      public function QuestionView()
      {
         super();
         initData();
         initView();
         initEvent();
      }
      
      private function initData() : void
      {
         _selectVec = new Vector.<MovieImage>();
         _grayFilters = ComponentFactory.Instance.creatFilters("grayFilter");
      }
      
      private function initView() : void
      {
         var _loc1_:* = null;
         var _loc2_:int = 0;
         _questionTitle = ComponentFactory.Instance.creatComponentByStylename("lantern.view.questionTitle");
         _questionTitle.text = LanguageMgr.GetTranslation("lanternRiddles.view.questionTitleText");
         addChild(_questionTitle);
         _questionCount = ComponentFactory.Instance.creatComponentByStylename("lantern.view.questionCount");
         addChild(_questionCount);
         _cdTime = ComponentFactory.Instance.creatComponentByStylename("lantern.view.questionCDTime");
         _cdTime.text = LanguageMgr.GetTranslation("lanternRiddles.view.cdTime",9);
         addChild(_cdTime);
         _question = ComponentFactory.Instance.creatComponentByStylename("lantern.view.question");
         addChild(_question);
         _question2 = ComponentFactory.Instance.creatComponentByStylename("lantern.view.question2");
         addChild(_question2);
         _loc2_ = 0;
         while(_loc2_ < SELECT_NUM)
         {
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("lantern.view.selectMovie");
            _loc1_.buttonMode = true;
            _loc1_.movie.gotoAndStop(1);
            _loc1_.addEventListener("click",__onSelectClick);
            PositionUtils.setPos(_loc1_,"lantern.view.selectPos" + _loc2_);
            addChild(_loc1_);
            _selectVec.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function initEvent() : void
      {
         LanternRiddlesManager.instance.addEventListener("lanternRiddles_answer",__onAnswerResult);
      }
      
      protected function __onAnswerResult(param1:CrazyTankSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.pkg;
         var _loc3_:Boolean = _loc4_.readBoolean();
         var _loc2_:Boolean = _loc4_.readBoolean();
         var _loc6_:int = _loc4_.readInt();
         var _loc5_:String = _loc4_.readUTF();
         if(_loc2_)
         {
            setAnswerFlag(_loc6_);
         }
         if(_loc3_)
         {
            _resultMovie = ComponentFactory.Instance.creat("lantern.view.correctMovie");
         }
         else
         {
            _resultMovie = ComponentFactory.Instance.creat("lantern.view.errorMovie");
         }
         LayerManager.Instance.addToLayer(_resultMovie,0,false,1);
         _resultMovie.movie["result"]["awardText"].autoSize = "center";
         _resultMovie.movie["result"]["awardText"].text = _loc5_;
         _resultMovie.x = (StageReferance.stage.stageWidth - _resultMovie.width) / 2;
         _resultMovie.y = 290;
         addEventListener("enterFrame",__onEnterFrame);
      }
      
      protected function __onEnterFrame(param1:Event) : void
      {
         if(_resultMovie && _resultMovie.parent && _resultMovie.movie.currentFrame == 40)
         {
            _resultMovie.parent.removeChild(_resultMovie);
            _resultMovie.dispose();
            _resultMovie = null;
            removeEventListener("enterFrame",__onEnterFrame);
         }
      }
      
      public function set info(param1:LanternInfo) : void
      {
         _info = param1;
         setQuestionCount(_info.QuestionIndex);
         setQuestionInfo(param1);
         setCDTime(_info.EndDate);
         setAnswerFlag(_info.Option);
      }
      
      private function setQuestionCount(param1:int) : void
      {
         _questionCount.text = param1.toString() + "/" + _count.toString();
      }
      
      private function setQuestionInfo(param1:LanternInfo) : void
      {
         _question.text = param1.QuestionContent;
         _question2.text = LanguageMgr.GetTranslation("lanternRiddles.view.questionText","\n",param1.Option1,param1.Option2,param1.Option3,param1.Option4);
      }
      
      private function setCDTime(param1:Date) : void
      {
         _countDownTime = param1.time - TimeManager.Instance.Now().time;
         if(_countDownTime > 0)
         {
            _countDownTime = _countDownTime / 1000;
            _cdTime.visible = true;
            _cdTime.text = LanguageMgr.GetTranslation("lanternRiddles.view.cdTime",transSecond(_countDownTime));
            if(!_timer)
            {
               _timer = new Timer(1000);
               _timer.addEventListener("timer",__onTimer);
            }
            _timer.start();
         }
         else
         {
            _cdTime.visible = false;
            if(_timer)
            {
               _timer.stop();
               _timer.reset();
            }
         }
      }
      
      protected function __onTimer(param1:TimerEvent) : void
      {
         _countDownTime = Number(_countDownTime) - 1;
         if(_countDownTime < 0)
         {
            _timer.stop();
            _timer.reset();
            _timer.removeEventListener("timer",__onTimer);
            _timer = null;
         }
         else if(_cdTime)
         {
            _cdTime.text = LanguageMgr.GetTranslation("lanternRiddles.view.cdTime",transSecond(_countDownTime));
         }
      }
      
      private function transSecond(param1:Number) : String
      {
         return (String("0" + Math.floor(param1 % 60))).substr(-2);
      }
      
      protected function __onSelectClick(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         SoundManager.instance.playButtonSound();
         var _loc2_:MovieImage = param1.currentTarget as MovieImage;
         _loc3_ = 0;
         while(_loc3_ < _selectVec.length)
         {
            if(_loc2_ == _selectVec[_loc3_])
            {
               _selectVec[_loc3_].movie.gotoAndStop(2);
               _info.Option = _loc3_ + 1;
               SocketManager.Instance.out.sendLanternRiddlesAnswer(_info.QuestionID,_info.QuestionIndex,_info.Option);
            }
            _selectVec[_loc3_].filters = _grayFilters;
            _selectVec[_loc3_].removeEventListener("click",__onSelectClick);
            _loc3_++;
         }
      }
      
      private function setAnswerFlag(param1:int) : void
      {
         if(param1 > 0)
         {
            setSelectBtnEnable(false);
            _selectVec[param1 - 1].movie.gotoAndStop(2);
         }
      }
      
      public function setSelectBtnEnable(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _selectVec.length)
         {
            _selectVec[_loc2_].movie.gotoAndStop(1);
            if(param1)
            {
               _selectVec[_loc2_].filters = null;
               _selectVec[_loc2_].addEventListener("click",__onSelectClick);
            }
            else
            {
               _selectVec[_loc2_].filters = _grayFilters;
               _selectVec[_loc2_].removeEventListener("click",__onSelectClick);
            }
            _loc2_++;
         }
      }
      
      private function removeEvent() : void
      {
         LanternRiddlesManager.instance.removeEventListener("lanternRiddles_answer",__onAnswerResult);
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         removeEvent();
         if(_questionTitle)
         {
            _questionTitle.dispose();
            _questionTitle = null;
         }
         if(_questionCount)
         {
            _questionCount.dispose();
            _questionCount = null;
         }
         if(_question)
         {
            _question.dispose();
            _question = null;
         }
         if(_question2)
         {
            _question2.dispose();
            _question2 = null;
         }
         if(_cdTime)
         {
            _cdTime.dispose();
            _cdTime = null;
         }
         if(_timer)
         {
            _timer.stop();
            _timer.reset();
            _timer.removeEventListener("timer",__onTimer);
            _timer = null;
         }
         if(_selectVec)
         {
            _loc1_ = 0;
            while(_loc1_ < _selectVec.length)
            {
               _selectVec[_loc1_].removeEventListener("click",__onSelectClick);
               _selectVec[_loc1_].dispose();
               _selectVec[_loc1_] = null;
               _loc1_++;
            }
            _selectVec.length = 0;
            _selectVec = null;
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      public function set count(param1:int) : void
      {
         _count = param1;
      }
      
      public function get info() : LanternInfo
      {
         return _info;
      }
      
      public function get countDownTime() : Number
      {
         return _countDownTime;
      }
   }
}
