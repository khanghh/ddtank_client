package BombTurnTable
{
   import BombTurnTable.view.quality.BaseTurnTable;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import road7th.data.DictionaryData;
   
   public class TurnTableHandlerControl
   {
      
      private static const FREQUENCY:int = 80;
       
      
      private var _timer:Timer;
      
      private var _turnTable:BaseTurnTable;
      
      private var _winName:String;
      
      private var _winIndex:int;
      
      private var _meedAngle:Number;
      
      private var _totalAngle:Number;
      
      private var _rounds:int = 4;
      
      private var _curTurnTableAngle:Number;
      
      private var _curSpeed:Number;
      
      private var _addSpeed:Number = 2;
      
      private var _maxSpeed:Number = 40;
      
      private var _obstruct:Number = 0.1;
      
      private var _accelerate:Boolean = true;
      
      private var _meedList:DictionaryData;
      
      public var _backFun:Function;
      
      public function TurnTableHandlerControl(param1:Function)
      {
         super();
         _backFun = param1;
         init();
      }
      
      public function setData(param1:BaseTurnTable, param2:int, param3:String = null, param4:DictionaryData = null) : void
      {
         _turnTable = param1;
         _winIndex = param2 - 1;
         _meedList = param4;
         _curTurnTableAngle = _turnTable.turnTable.rotation;
         _curSpeed = 0;
         _accelerate = true;
         _meedAngle = _winIndex * -1 * 45 - 22.5;
         _totalAngle = _meedAngle + _rounds * 360;
      }
      
      public function startLottery() : void
      {
         if(_turnTable && _turnTable.turnTable)
         {
            _timer.reset();
            _timer.start();
         }
      }
      
      private function init() : void
      {
         _timer = new Timer(80);
         _timer.addEventListener("timer",_frameRotation_Handler);
      }
      
      private function _frameRotation_Handler(param1:TimerEvent) : void
      {
         var _loc2_:Number = NaN;
         if(_accelerate)
         {
            if(_curSpeed < _maxSpeed)
            {
               _curSpeed = _curSpeed + _addSpeed;
            }
            else
            {
               _accelerate = false;
            }
         }
         else
         {
            _loc2_ = (_totalAngle - _curTurnTableAngle) * _obstruct;
            _curSpeed = _loc2_ > _maxSpeed?_maxSpeed:Number(_loc2_);
            if(_curSpeed < 0.1 || _curTurnTableAngle >= _totalAngle)
            {
               _timer.stop();
               lotteryComplate();
            }
         }
         _curTurnTableAngle = _curTurnTableAngle + _curSpeed;
         _turnTable.turnTable.rotation = Number(_curTurnTableAngle.toFixed(2));
      }
      
      private function lotteryComplate() : void
      {
         if(_backFun)
         {
            _backFun(_winIndex + 1);
         }
      }
      
      public function stop() : void
      {
         _timer.stop();
         _turnTable = null;
         if(_meedList)
         {
            _meedList.clear();
         }
         _meedList = null;
         _backFun = null;
      }
   }
}
