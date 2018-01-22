package luckStar.manager
{
   import ddt.view.roulette.TurnSoundControl;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import luckStar.cell.LuckStarCell;
   
   public class LuckStarTurnControl extends EventDispatcher
   {
      
      public static const SPEEDUP_RATE:int = -60;
      
      public static const SPEEDDOWN_RATE:int = 40;
      
      public static const PLAY_SOUNDTHREESTEP_NUMBER:int = 14;
      
      public static const TURNCOMPLETE:String = "turn_complete";
      
      public static const TYPE_SPEED_UP:int = 1;
      
      public static const TYPE_SPEED_UNCHANGE:int = 2;
      
      public static const TYPE_SPEED_DOWN:int = 3;
      
      public static const SHADOW_NUMBER:int = 3;
      
      public static const DOWN_SUB_SHADOW_BOL:int = 9;
       
      
      private var _goodsList:Vector.<LuckStarCell>;
      
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
      
      public function LuckStarTurnControl(param1:IEventDispatcher = null)
      {
         _delay = [200,20,300];
         _moveTime = [1000,2000];
         super(param1);
         init();
      }
      
      private function init() : void
      {
         _timer = new Timer(100,1);
         _timer.stop();
         _sound = new TurnSoundControl();
      }
      
      private function __onTimerComplete(param1:TimerEvent) : void
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
            _goodsList[sparkleNumber].setSparkle();
            _clearPrevSelct(sparkleNumber,prevSelected);
            if(nowDelayTime > 40 && turnType == 1)
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
               if(_turnTypeTimeSum >= _moveTime[0] && _sparkleNumber == _startModerationNumber)
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
      
      public function turn(param1:Vector.<LuckStarCell>, param2:int) : void
      {
         turnType = 1;
         _goodsList = param1;
         selectedGoodsNumber = param2;
         startTurn();
         _startTimer(nowDelayTime);
      }
      
      public function set turnContinue(param1:Boolean) : void
      {
         _turnContinue = param1;
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
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _goodsList.length)
         {
            _goodsList[_loc1_].selected = false;
            _loc1_++;
         }
         _isStopTurn = true;
         _timer.stop();
         _timer.removeEventListener("timerComplete",__onTimerComplete);
         dispatchEvent(new Event("turn_complete"));
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
      
      public function set nowDelayTime(param1:int) : void
      {
         _turnTypeTimeSum = _turnTypeTimeSum + _nowDelayTime;
         _nowDelayTime = param1;
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
               _stepTime = 40;
         }
      }
      
      public function set selectedGoodsNumber(param1:int) : void
      {
         _selectedGoodsNumber = param1;
         _moderationNumber = (_delay[2] - _delay[1]) / 40;
         var _loc2_:int = _selectedGoodsNumber - _moderationNumber;
         while(_loc2_ < 0)
         {
            _loc2_ = _loc2_ + _goodsList.length;
         }
         _startModerationNumber = _loc2_;
      }
      
      public function set sparkleNumber(param1:int) : void
      {
         _sparkleNumber = param1;
         if(_sparkleNumber >= _goodsList.length)
         {
            _sparkleNumber = 0;
         }
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
