package devilTurn.control
{
   import ddt.view.roulette.TurnSoundControl;
   import devilTurn.view.DevilTurnCell;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class DevilTurnControl extends EventDispatcher
   {
      
      public static const SPEEDUP_RATE:int = -80;
      
      public static const SPEEDDOWN_RATE:int = 80;
      
      public static const PLAY_SOUNDTHREESTEP_NUMBER:int = 14;
      
      public static const TYPE_SPEED_UP:int = 1;
      
      public static const TYPE_SPEED_UNCHANGE:int = 2;
      
      public static const TYPE_SPEED_DOWN:int = 3;
       
      
      private var _goodsList:Vector.<DevilTurnCell>;
      
      private var _sound:TurnSoundControl;
      
      private var _delay:Array;
      
      private var _moveTime:Array;
      
      private var _nowDelayTime:int = 1000;
      
      private var _turnTypeTimeSum:int = 0;
      
      private var _timer:Timer;
      
      private var _turnType:int = 0;
      
      private var _stepTime:int;
      
      private var _isStopTurn:Boolean = true;
      
      private var _selectedGoodsNumber:Number;
      
      private var _moderationNumber:Number;
      
      private var _startModerationNumber:Number;
      
      private var _turnStop:Boolean;
      
      private var _sparkleNumber:Number;
      
      private var _turnContinue:Boolean;
      
      public function DevilTurnControl()
      {
         _delay = [400,80,400];
         _moveTime = [400,1000,400];
         super();
         init();
      }
      
      private function init() : void
      {
         _timer = new Timer(100,1);
         _timer.stop();
         _sound = new TurnSoundControl();
      }
      
      public function turn(list:Vector.<DevilTurnCell>, _select:int) : void
      {
         _goodsList = list;
         turnType = 1;
         clearListSelect();
         selectedGoodsNumber = _select;
         startTurn();
         _startTimer(nowDelayTime);
      }
      
      private function clearListSelect() : void
      {
         var i:int = 0;
         for(i = 0; i < _goodsList.length; )
         {
            _goodsList[i].selected = false;
            i++;
         }
      }
      
      private function __onTimerComplete(e:TimerEvent) : void
      {
         _updateTurnType(nowDelayTime);
         nowDelayTime = nowDelayTime + _stepTime;
         _nextNode();
         _startTimer(nowDelayTime);
      }
      
      private function _nextNode() : void
      {
         if(!_isStopTurn)
         {
            sparkleNumber = sparkleNumber + 1;
            _goodsList[sparkleNumber].selected = true;
            _goodsList[prevSelected].selected = false;
            if(nowDelayTime > 80 && turnType == 1)
            {
               _sound.stop();
               _sound.playOneStep();
            }
            else if(turnType == 3 && _moderationNumber <= 14)
            {
               _sound.stop();
               _sound.playThreeStep(_moderationNumber);
            }
            else
            {
               _sound.playSound();
            }
         }
      }
      
      private function _updateTurnType(value:int) : void
      {
         switch(int(turnType) - 1)
         {
            case 0:
               if(value <= _delay[1])
               {
                  turnType = 2;
               }
               break;
            case 1:
               if(_turnTypeTimeSum >= _moveTime[1] && _sparkleNumber == _startModerationNumber)
               {
                  turnType = 3;
               }
               break;
            case 2:
               _moderationNumber = Number(_moderationNumber) - 1;
               if(_moderationNumber <= 0)
               {
                  turnComplete();
                  break;
               }
         }
      }
      
      public function set turnContinue(value:Boolean) : void
      {
         _turnContinue = value;
      }
      
      public function get turnContinue() : Boolean
      {
         return _turnContinue;
      }
      
      private function startTurn() : void
      {
         _isStopTurn = false;
         _turnStop = false;
         sparkleNumber = Number(sparkleNumber) - 1;
         _timer.addEventListener("timerComplete",__onTimerComplete);
      }
      
      public function stopTurn() : void
      {
         _turnStop = true;
         _turnContinue = false;
      }
      
      private function turnComplete() : void
      {
         clearListSelect();
         _isStopTurn = true;
         _timer.stop();
         _timer.removeEventListener("timerComplete",__onTimerComplete);
         dispatchEvent(new Event("complete"));
      }
      
      private function _startTimer(time:int) : void
      {
         if(!_isStopTurn)
         {
            _timer.delay = time;
            _timer.reset();
            _timer.start();
         }
      }
      
      public function set nowDelayTime(value:int) : void
      {
         _turnTypeTimeSum = _turnTypeTimeSum + _nowDelayTime;
         _nowDelayTime = value;
      }
      
      public function set turnType(value:int) : void
      {
         _turnType = value;
         _turnTypeTimeSum = 0;
         switch(int(_turnType) - 1)
         {
            case 0:
               _nowDelayTime = _delay[0];
               _stepTime = -80;
               break;
            case 1:
               _nowDelayTime = _delay[1];
               _stepTime = 0;
               break;
            case 2:
               _nowDelayTime = _delay[1];
               _stepTime = 80;
         }
      }
      
      public function set selectedGoodsNumber(value:int) : void
      {
         _selectedGoodsNumber = value;
         _moderationNumber = (_delay[2] - _delay[1]) / 80;
         var m:int = _selectedGoodsNumber - _moderationNumber;
         while(m < 0)
         {
            m = m + _goodsList.length;
         }
         _startModerationNumber = m;
      }
      
      public function set sparkleNumber(value:int) : void
      {
         _sparkleNumber = value;
         if(_sparkleNumber >= _goodsList.length)
         {
            _sparkleNumber = 0;
         }
      }
      
      private function get prevSelected() : int
      {
         var prev:int = sparkleNumber == 0?_goodsList.length - 1:Number(_sparkleNumber - 1);
         return prev;
      }
      
      public function get turnType() : int
      {
         return _turnType;
      }
      
      public function get nowDelayTime() : int
      {
         return _nowDelayTime;
      }
      
      public function get sparkleNumber() : int
      {
         return _sparkleNumber;
      }
      
      public function get isTurn() : Boolean
      {
         return !_isStopTurn;
      }
      
      public function dispose() : void
      {
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timerComplete",__onTimerComplete);
            _timer = null;
         }
         if(_sound)
         {
            _sound.dispose();
            _sound = null;
         }
      }
   }
}
