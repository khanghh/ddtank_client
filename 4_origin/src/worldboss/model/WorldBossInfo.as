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
      
      public function set total_Blood(value:Number) : void
      {
         _total_Blood = value;
      }
      
      public function get total_Blood() : Number
      {
         return _total_Blood;
      }
      
      public function set current_Blood(value:Number) : void
      {
         if(_current_Blood == value)
         {
            _cutValue = -1;
            return;
         }
         _cutValue = _current_Blood - value;
         _current_Blood = value;
         dispatchEvent(new Event("change"));
      }
      
      public function get current_Blood() : Number
      {
         return _current_Blood;
      }
      
      public function set isLiving(value:Boolean) : void
      {
         _isLiving = value;
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
      
      public function set begin_time(value:Date) : void
      {
         _begin_time = value;
      }
      
      public function get end_time() : Date
      {
         return _end_time;
      }
      
      public function set end_time(value:Date) : void
      {
         _end_time = value;
      }
      
      public function get fight_time() : int
      {
         return _fight_time;
      }
      
      public function set fight_time(value:int) : void
      {
         _fight_time = value;
      }
      
      public function getLeftTime() : int
      {
         var left_time:Number = TimeManager.Instance.TotalSecondToNow(begin_time);
         if(left_time > 0 && left_time < fight_time * 60)
         {
            return fight_time * 60 - left_time;
         }
         return 0;
      }
      
      public function get fightOver() : Boolean
      {
         return _fightOver;
      }
      
      public function set fightOver(value:Boolean) : void
      {
         _fightOver = value;
      }
      
      public function get roomClose() : Boolean
      {
         return _room_close;
      }
      
      public function set roomClose(value:Boolean) : void
      {
         _room_close = value;
      }
      
      public function get currentState() : int
      {
         return _currentState;
      }
      
      public function set currentState(value:int) : void
      {
         _currentState = value;
      }
      
      public function set ticketID(value:int) : void
      {
         _ticketID = value;
      }
      
      public function get ticketID() : int
      {
         return _ticketID;
      }
      
      public function set need_ticket_count(value:int) : void
      {
         _need_ticket_count = value;
      }
      
      public function get need_ticket_count() : int
      {
         return _need_ticket_count;
      }
      
      public function get cutValue() : Number
      {
         return _cutValue;
      }
      
      public function set name(value:String) : void
      {
         _name = value;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set timeCD(value:int) : void
      {
         _timeCD = value;
      }
      
      public function get timeCD() : int
      {
         return _timeCD;
      }
      
      public function set reviveMoney(value:int) : void
      {
         _reviveMoney = value;
      }
      
      public function get reviveMoney() : int
      {
         return _reviveMoney;
      }
      
      public function get buffArray() : Array
      {
         return _buffArray;
      }
      
      public function getbuffInfoByID(id:int) : WorldBossBuffInfo
      {
         var i:int = 0;
         for(i = 0; i < _buffArray.length; )
         {
            if(id == (_buffArray[i] as WorldBossBuffInfo).ID)
            {
               return _buffArray[i];
            }
            i++;
         }
         return new WorldBossBuffInfo();
      }
      
      public function set myPlayerVO(value:PlayerVO) : void
      {
         _myPlayerVO = value;
      }
      
      public function get myPlayerVO() : PlayerVO
      {
         return _myPlayerVO;
      }
      
      public function set playerDefaultPos(value:Point) : void
      {
         _playerDefaultPos = value;
      }
      
      public function get playerDefaultPos() : Point
      {
         return _playerDefaultPos;
      }
      
      public function get reFightMoney() : int
      {
         return _reFightMoney;
      }
      
      public function set reFightMoney(value:int) : void
      {
         _reFightMoney = value;
      }
      
      public function get addInjureBuffMoney() : int
      {
         return _addInjureBuffMoney;
      }
      
      public function set addInjureBuffMoney(value:int) : void
      {
         _addInjureBuffMoney = value;
      }
      
      public function get addInjureValue() : int
      {
         return _addInjureValue;
      }
      
      public function set addInjureValue(value:int) : void
      {
         _addInjureValue = value;
      }
   }
}
