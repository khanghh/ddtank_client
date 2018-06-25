package ddt.view.roulette
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class TurnControl extends EventDispatcher
   {
      
      public static const TURNCOMPLETE:String = "turn_complete";
      
      public static const TYPE_SPEED_UP:int = 1;
      
      public static const TYPE_SPEED_UNCHANGE:int = 2;
      
      public static const TYPE_SPEED_DOWN:int = 3;
      
      public static const MINTIME_PLAY_SOUNDONESTEP:int = 30;
      
      public static const PLAY_SOUNDTHREESTEP_NUMBER:int = 14;
      
      public static const SHADOW_NUMBER:int = 3;
      
      public static const DOWN_SUB_SHADOW_BOL:int = 9;
      
      public static const SPEEDUP_RATE:int = -60;
      
      public static const SPEEDDOWN_RATE:int = 30;
       
      
      private var _goodsList:Vector.<RouletteGoodsCell>;
      
      private var _turnType:int = 1;
      
      private var _timer:Timer;
      
      private var _timerII:Timer;
      
      private var _isStopTurn:Boolean = false;
      
      private var _nowDelayTime:int = 1000;
      
      private var _sparkleNumber:int = 0;
      
      private var _delay:Array;
      
      private var _moveTime:Array;
      
      private var _selectedGoodsNumber:int = 0;
      
      private var _turnTypeTimeSum:int = 0;
      
      private var _stepTime:int = 0;
      
      private var _startModerationNumber:int = 0;
      
      private var _moderationNumber:int = 0;
      
      private var _sound:TurnSoundControl;
      
      public function TurnControl(target:IEventDispatcher = null)
      {
         _delay = [500,30,500];
         _moveTime = [2000,3000,2000];
         super(target);
         init();
         initEvent();
      }
      
      private function init() : void
      {
         _timer = new Timer(100,1);
         _timer.stop();
         _sound = new TurnSoundControl();
         _timerII = new Timer(600);
         _timerII.stop();
      }
      
      public function set autoMove(boo:Boolean) : void
      {
         if(boo)
         {
            _timerII.start();
         }
         else
         {
            _timerII.stop();
         }
      }
      
      private function initEvent() : void
      {
         _timer.addEventListener("timerComplete",_timeComplete);
         _timerII.addEventListener("timer",_timerIITimer);
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
      
      private function _nextNode() : void
      {
         if(!_isStopTurn)
         {
            sparkleNumber = sparkleNumber + 1;
            _goodsList[sparkleNumber].setSparkle();
            _clearPrevSelct(sparkleNumber,prevSelected);
            if(nowDelayTime > 30 && turnType == 1)
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
      
      private function _clearPrevSelct(now:int, prev:int) : void
      {
         var one:int = 0;
         var between:int = now - prev < 0?now - prev + _goodsList.length:Number(now - prev);
         if(between == 1)
         {
            _goodsList[prev].selected = false;
         }
         else
         {
            one = now - 1 < 0?now - 1 + _goodsList.length:Number(now - 1);
            _goodsList[one].setGreep();
            _goodsList[prev].selected = false;
         }
      }
      
      private function _timeComplete(e:TimerEvent) : void
      {
         _updateTurnType(nowDelayTime);
         nowDelayTime = nowDelayTime + _stepTime;
         _nextNode();
         _startTimer(nowDelayTime);
      }
      
      private function _timerIITimer(e:TimerEvent) : void
      {
         _goodsList[sparkleNumber].setGreep();
         _goodsList[sparkleNumber].selected = false;
         sparkleNumber = sparkleNumber + 1;
         if(sparkleNumber == _goodsList.length)
         {
            sparkleNumber = 0;
         }
         _goodsList[sparkleNumber].setSparkle();
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
                  stopTurn();
                  break;
               }
         }
      }
      
      public function startTurn() : void
      {
         _isStopTurn = false;
         sparkleNumber = Number(sparkleNumber) - 1;
         _timer.addEventListener("timerComplete",_timeComplete);
      }
      
      public function stopTurn() : void
      {
         _isStopTurn = true;
         _timer.stop();
         _timer.removeEventListener("timerComplete",_timeComplete);
         _turnComplete();
      }
      
      private function _turnComplete() : void
      {
         dispatchEvent(new Event("turn_complete"));
      }
      
      public function turnPlate(list:Vector.<RouletteGoodsCell>, _select:int) : void
      {
         turnType = 1;
         _goodsList = list;
         selectedGoodsNumber = _select;
         startTurn();
         _startTimer(nowDelayTime);
      }
      
      public function turnPlateII(list:Vector.<RouletteGoodsCell>) : void
      {
         _goodsList = list;
         autoMove = true;
      }
      
      public function set sparkleNumber(value:int) : void
      {
         _sparkleNumber = value;
         if(_sparkleNumber >= _goodsList.length)
         {
            _sparkleNumber = 0;
         }
      }
      
      public function get sparkleNumber() : int
      {
         return _sparkleNumber;
      }
      
      private function get prevSelected() : int
      {
         var step:int = 0;
         var prev:int = 0;
         switch(int(_turnType) - 1)
         {
            case 0:
               prev = sparkleNumber == 0?_goodsList.length - 1:Number(_sparkleNumber - 1);
               break;
            case 1:
               prev = sparkleNumber - 3 < 0?sparkleNumber - 3 + _goodsList.length:Number(sparkleNumber - 3);
               break;
            case 2:
               if(_moderationNumber > 9)
               {
                  prev = sparkleNumber - 3 < 0?sparkleNumber - 3 + _goodsList.length:Number(sparkleNumber - 3);
                  break;
               }
               step = _moderationNumber >= 7?_moderationNumber - 6:1;
               prev = sparkleNumber - step < 0?sparkleNumber - step + _goodsList.length:Number(_sparkleNumber - step);
               if(_moderationNumber >= 8)
               {
                  _goodsList[prev + 1 >= _goodsList.length?0:Number(prev + 1)].selected = false;
                  break;
               }
               break;
         }
         return prev;
      }
      
      public function set nowDelayTime(value:int) : void
      {
         _turnTypeTimeSum = _turnTypeTimeSum + _nowDelayTime;
         _nowDelayTime = value;
      }
      
      public function get nowDelayTime() : int
      {
         return _nowDelayTime;
      }
      
      public function set turnType(value:int) : void
      {
         _turnType = value;
         _turnTypeTimeSum = 0;
         switch(int(_turnType) - 1)
         {
            case 0:
               _nowDelayTime = _delay[0];
               _stepTime = -60;
               break;
            case 1:
               _nowDelayTime = _delay[1];
               _stepTime = 0;
               break;
            case 2:
               _nowDelayTime = _delay[1];
               _stepTime = 30;
         }
      }
      
      public function get turnType() : int
      {
         return _turnType;
      }
      
      public function set goodsList(list:Vector.<RouletteGoodsCell>) : void
      {
         _goodsList = list;
      }
      
      public function set selectedGoodsNumber(value:int) : void
      {
         _selectedGoodsNumber = value;
         _moderationNumber = (_delay[2] - _delay[1]) / 30;
         var m:int = _selectedGoodsNumber - _moderationNumber;
         while(m < 0)
         {
            m = m + _goodsList.length;
         }
         _startModerationNumber = m;
      }
      
      public function dispose() : void
      {
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timerComplete",_timeComplete);
            _timerII.removeEventListener("timer",_timerIITimer);
            _timer = null;
         }
         if(_sound)
         {
            _sound.stop();
            _sound.dispose();
            _sound = null;
         }
      }
   }
}
