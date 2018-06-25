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
         var select:* = null;
         var i:int = 0;
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
         for(i = 0; i < SELECT_NUM; )
         {
            select = ComponentFactory.Instance.creatComponentByStylename("lantern.view.selectMovie");
            select.buttonMode = true;
            select.movie.gotoAndStop(1);
            select.addEventListener("click",__onSelectClick);
            PositionUtils.setPos(select,"lantern.view.selectPos" + i);
            addChild(select);
            _selectVec.push(select);
            i++;
         }
      }
      
      private function initEvent() : void
      {
         LanternRiddlesManager.instance.addEventListener("lanternRiddles_answer",__onAnswerResult);
      }
      
      protected function __onAnswerResult(event:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var correct:Boolean = pkg.readBoolean();
         var hitFlag:Boolean = pkg.readBoolean();
         var option:int = pkg.readInt();
         var msg:String = pkg.readUTF();
         if(hitFlag)
         {
            setAnswerFlag(option);
         }
         if(correct)
         {
            _resultMovie = ComponentFactory.Instance.creat("lantern.view.correctMovie");
         }
         else
         {
            _resultMovie = ComponentFactory.Instance.creat("lantern.view.errorMovie");
         }
         LayerManager.Instance.addToLayer(_resultMovie,0,false,1);
         _resultMovie.movie["result"]["awardText"].autoSize = "center";
         _resultMovie.movie["result"]["awardText"].text = msg;
         _resultMovie.x = (StageReferance.stage.stageWidth - _resultMovie.width) / 2;
         _resultMovie.y = 290;
         addEventListener("enterFrame",__onEnterFrame);
      }
      
      protected function __onEnterFrame(event:Event) : void
      {
         if(_resultMovie && _resultMovie.parent && _resultMovie.movie.currentFrame == 40)
         {
            _resultMovie.parent.removeChild(_resultMovie);
            _resultMovie.dispose();
            _resultMovie = null;
            removeEventListener("enterFrame",__onEnterFrame);
         }
      }
      
      public function set info(info:LanternInfo) : void
      {
         _info = info;
         setQuestionCount(_info.QuestionIndex);
         setQuestionInfo(info);
         setCDTime(_info.EndDate);
         setAnswerFlag(_info.Option);
      }
      
      private function setQuestionCount(index:int) : void
      {
         _questionCount.text = index.toString() + "/" + _count.toString();
      }
      
      private function setQuestionInfo(info:LanternInfo) : void
      {
         _question.text = info.QuestionContent;
         _question2.text = LanguageMgr.GetTranslation("lanternRiddles.view.questionText","\n",info.Option1,info.Option2,info.Option3,info.Option4);
      }
      
      private function setCDTime(date:Date) : void
      {
         _countDownTime = date.time - TimeManager.Instance.Now().time;
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
      
      protected function __onTimer(event:TimerEvent) : void
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
      
      private function transSecond(num:Number) : String
      {
         return (String("0" + Math.floor(num % 60))).substr(-2);
      }
      
      protected function __onSelectClick(event:MouseEvent) : void
      {
         var i:int = 0;
         SoundManager.instance.playButtonSound();
         var select:MovieImage = event.currentTarget as MovieImage;
         for(i = 0; i < _selectVec.length; )
         {
            if(select == _selectVec[i])
            {
               _selectVec[i].movie.gotoAndStop(2);
               _info.Option = i + 1;
               SocketManager.Instance.out.sendLanternRiddlesAnswer(_info.QuestionID,_info.QuestionIndex,_info.Option);
            }
            _selectVec[i].filters = _grayFilters;
            _selectVec[i].removeEventListener("click",__onSelectClick);
            i++;
         }
      }
      
      private function setAnswerFlag(option:int) : void
      {
         if(option > 0)
         {
            setSelectBtnEnable(false);
            _selectVec[option - 1].movie.gotoAndStop(2);
         }
      }
      
      public function setSelectBtnEnable(flag:Boolean) : void
      {
         var i:int = 0;
         for(i = 0; i < _selectVec.length; )
         {
            _selectVec[i].movie.gotoAndStop(1);
            if(flag)
            {
               _selectVec[i].filters = null;
               _selectVec[i].addEventListener("click",__onSelectClick);
            }
            else
            {
               _selectVec[i].filters = _grayFilters;
               _selectVec[i].removeEventListener("click",__onSelectClick);
            }
            i++;
         }
      }
      
      private function removeEvent() : void
      {
         LanternRiddlesManager.instance.removeEventListener("lanternRiddles_answer",__onAnswerResult);
      }
      
      public function dispose() : void
      {
         var i:int = 0;
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
            for(i = 0; i < _selectVec.length; )
            {
               _selectVec[i].removeEventListener("click",__onSelectClick);
               _selectVec[i].dispose();
               _selectVec[i] = null;
               i++;
            }
            _selectVec.length = 0;
            _selectVec = null;
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      public function set count(value:int) : void
      {
         _count = value;
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
