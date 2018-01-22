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
      
      public function TurnControl(param1:IEventDispatcher = null)
      {
         _delay = [500,30,500];
         _moveTime = [2000,3000,2000];
         super(param1);
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
      
      public function set autoMove(param1:Boolean) : void
      {
         if(param1)
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
      
      private function _startTimer(param1:int) : void
      {
         if(!_isStopTurn)
         {
            _timer.delay = param1;
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
      
      private function _clearPrevSelct(param1:int, param2:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = param1 - param2 < 0?param1 - param2 + _goodsList.length:Number(param1 - param2);
         if(_loc4_ == 1)
         {
            _goodsList[param2].selected = false;
         }
         else
         {
            _loc3_ = param1 - 1 < 0?param1 - 1 + _goodsList.length:Number(param1 - 1);
            _goodsList[_loc3_].setGreep();
            _goodsList[param2].selected = false;
         }
      }
      
      private function _timeComplete(param1:TimerEvent) : void
      {
         _updateTurnType(nowDelayTime);
         nowDelayTime = nowDelayTime + _stepTime;
         _nextNode();
         _startTimer(nowDelayTime);
      }
      
      private function _timerIITimer(param1:TimerEvent) : void
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
      
      private function _updateTurnType(param1:int) : void
      {
         switch(int(turnType) - 1)
         {
            case 0:
               if(param1 <= _delay[1])
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
      
      public function turnPlate(param1:Vector.<RouletteGoodsCell>, param2:int) : void
      {
         turnType = 1;
         _goodsList = param1;
         selectedGoodsNumber = param2;
         startTurn();
         _startTimer(nowDelayTime);
      }
      
      public function turnPlateII(param1:Vector.<RouletteGoodsCell>) : void
      {
         _goodsList = param1;
         autoMove = true;
      }
      
      public function set sparkleNumber(param1:int) : void
      {
         _sparkleNumber = param1;
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
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         switch(int(_turnType) - 1)
         {
            case 0:
               _loc2_ = sparkleNumber == 0?_goodsList.length - 1:Number(_sparkleNumber - 1);
               break;
            case 1:
               _loc2_ = sparkleNumber - 3 < 0?sparkleNumber - 3 + _goodsList.length:Number(sparkleNumber - 3);
               break;
            case 2:
               if(_moderationNumber > 9)
               {
                  _loc2_ = sparkleNumber - 3 < 0?sparkleNumber - 3 + _goodsList.length:Number(sparkleNumber - 3);
                  break;
               }
               _loc1_ = _moderationNumber >= 7?_moderationNumber - 6:1;
               _loc2_ = sparkleNumber - _loc1_ < 0?sparkleNumber - _loc1_ + _goodsList.length:Number(_sparkleNumber - _loc1_);
               if(_moderationNumber >= 8)
               {
                  _goodsList[_loc2_ + 1 >= _goodsList.length?0:Number(_loc2_ + 1)].selected = false;
                  break;
               }
               break;
         }
         return _loc2_;
      }
      
      public function set nowDelayTime(param1:int) : void
      {
         _turnTypeTimeSum = _turnTypeTimeSum + _nowDelayTime;
         _nowDelayTime = param1;
      }
      
      public function get nowDelayTime() : int
      {
         return _nowDelayTime;
      }
      
      public function set turnType(param1:int) : void
      {
         _turnType = param1;
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
      
      public function set goodsList(param1:Vector.<RouletteGoodsCell>) : void
      {
         _goodsList = param1;
      }
      
      public function set selectedGoodsNumber(param1:int) : void
      {
         _selectedGoodsNumber = param1;
         _moderationNumber = (_delay[2] - _delay[1]) / 30;
         var _loc2_:int = _selectedGoodsNumber - _moderationNumber;
         while(_loc2_ < 0)
         {
            _loc2_ = _loc2_ + _goodsList.length;
         }
         _startModerationNumber = _loc2_;
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
