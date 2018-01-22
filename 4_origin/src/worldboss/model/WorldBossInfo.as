package worldboss.model
{
   import ddt.manager.TimeManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.geom.Point;
   import worldboss.player.PlayerVO;
   
   public class WorldBossInfo extends EventDispatcher
   {
       
      
      private var _total_Blood:Number;
      
      private var _current_Blood:Number;
      
      private var _isLiving:Boolean;
      
      private var _begin_time:Date;
      
      private var _fight_time:int;
      
      private var _end_time:Date;
      
      private var _fightOver:Boolean;
      
      private var _room_close:Boolean;
      
      private var _currentState:int = 0;
      
      private var _ticketID:int;
      
      private var _need_ticket_count:int;
      
      private var _cutValue:Number;
      
      private var _name:String;
      
      private var _timeCD:int;
      
      private var _reviveMoney:int;
      
      private var _reFightMoney:int;
      
      private var _addInjureBuffMoney:int;
      
      private var _addInjureValue:int;
      
      private var _myPlayerVO:PlayerVO;
      
      private var _playerDefaultPos:Point;
      
      private var _buffArray:Array;
      
      public function WorldBossInfo()
      {
         _buffArray = [];
         super();
      }
      
      public function set total_Blood(param1:Number) : void
      {
         _total_Blood = param1;
      }
      
      public function get total_Blood() : Number
      {
         return _total_Blood;
      }
      
      public function set current_Blood(param1:Number) : void
      {
         if(_current_Blood == param1)
         {
            _cutValue = -1;
            return;
         }
         _cutValue = _current_Blood - param1;
         _current_Blood = param1;
         dispatchEvent(new Event("change"));
      }
      
      public function get current_Blood() : Number
      {
         return _current_Blood;
      }
      
      public function set isLiving(param1:Boolean) : void
      {
         _isLiving = param1;
         if(!_isLiving)
         {
            current_Blood = 0;
         }
      }
      
      public function get isLiving() : Boolean
      {
         return _isLiving;
      }
      
      public function get begin_time() : Date
      {
         return _begin_time;
      }
      
      public function set begin_time(param1:Date) : void
      {
         _begin_time = param1;
      }
      
      public function get end_time() : Date
      {
         return _end_time;
      }
      
      public function set end_time(param1:Date) : void
      {
         _end_time = param1;
      }
      
      public function get fight_time() : int
      {
         return _fight_time;
      }
      
      public function set fight_time(param1:int) : void
      {
         _fight_time = param1;
      }
      
      public function getLeftTime() : int
      {
         var _loc1_:Number = TimeManager.Instance.TotalSecondToNow(begin_time);
         if(_loc1_ > 0 && _loc1_ < fight_time * 60)
         {
            return fight_time * 60 - _loc1_;
         }
         return 0;
      }
      
      public function get fightOver() : Boolean
      {
         return _fightOver;
      }
      
      public function set fightOver(param1:Boolean) : void
      {
         _fightOver = param1;
      }
      
      public function get roomClose() : Boolean
      {
         return _room_close;
      }
      
      public function set roomClose(param1:Boolean) : void
      {
         _room_close = param1;
      }
      
      public function get currentState() : int
      {
         return _currentState;
      }
      
      public function set currentState(param1:int) : void
      {
         _currentState = param1;
      }
      
      public function set ticketID(param1:int) : void
      {
         _ticketID = param1;
      }
      
      public function get ticketID() : int
      {
         return _ticketID;
      }
      
      public function set need_ticket_count(param1:int) : void
      {
         _need_ticket_count = param1;
      }
      
      public function get need_ticket_count() : int
      {
         return _need_ticket_count;
      }
      
      public function get cutValue() : Number
      {
         return _cutValue;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set timeCD(param1:int) : void
      {
         _timeCD = param1;
      }
      
      public function get timeCD() : int
      {
         return _timeCD;
      }
      
      public function set reviveMoney(param1:int) : void
      {
         _reviveMoney = param1;
      }
      
      public function get reviveMoney() : int
      {
         return _reviveMoney;
      }
      
      public function get buffArray() : Array
      {
         return _buffArray;
      }
      
      public function getbuffInfoByID(param1:int) : WorldBossBuffInfo
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _buffArray.length)
         {
            if(param1 == (_buffArray[_loc2_] as WorldBossBuffInfo).ID)
            {
               return _buffArray[_loc2_];
            }
            _loc2_++;
         }
         return new WorldBossBuffInfo();
      }
      
      public function set myPlayerVO(param1:PlayerVO) : void
      {
         _myPlayerVO = param1;
      }
      
      public function get myPlayerVO() : PlayerVO
      {
         return _myPlayerVO;
      }
      
      public function set playerDefaultPos(param1:Point) : void
      {
         _playerDefaultPos = param1;
      }
      
      public function get playerDefaultPos() : Point
      {
         return _playerDefaultPos;
      }
      
      public function get reFightMoney() : int
      {
         return _reFightMoney;
      }
      
      public function set reFightMoney(param1:int) : void
      {
         _reFightMoney = param1;
      }
      
      public function get addInjureBuffMoney() : int
      {
         return _addInjureBuffMoney;
      }
      
      public function set addInjureBuffMoney(param1:int) : void
      {
         _addInjureBuffMoney = param1;
      }
      
      public function get addInjureValue() : int
      {
         return _addInjureValue;
      }
      
      public function set addInjureValue(param1:int) : void
      {
         _addInjureValue = param1;
      }
   }
}
