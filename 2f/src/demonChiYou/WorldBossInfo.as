package demonChiYou
{
   import ddt.manager.TimeManager;
   import flash.geom.Point;
   
   public class WorldBossInfo
   {
       
      
      private var _total_Blood:Number = 99999;
      
      private var _current_Blood:Number = 9999;
      
      private var _isLiving:Boolean;
      
      private var _begin_time:Date;
      
      private var _fight_time:int;
      
      private var _end_time:Date;
      
      private var _fightOver:Boolean;
      
      private var _room_close:Boolean;
      
      private var _currentState:int = 0;
      
      private var _ticketID:int;
      
      private var _need_ticket_count:int;
      
      private var _cutValue:Number = 2;
      
      private var _name:String = "魔神蚩尤";
      
      private var _timeCD:int;
      
      private var _reviveMoney:int;
      
      private var _reFightMoney:int;
      
      private var _addInjureBuffMoney:int;
      
      private var _addInjureValue:int;
      
      private var _playerDefaultPos:Point;
      
      public function WorldBossInfo(){super();}
      
      public function set total_Blood(param1:Number) : void{}
      
      public function get total_Blood() : Number{return 0;}
      
      public function set current_Blood(param1:Number) : void{}
      
      public function get current_Blood() : Number{return 0;}
      
      public function set isLiving(param1:Boolean) : void{}
      
      public function get isLiving() : Boolean{return false;}
      
      public function get begin_time() : Date{return null;}
      
      public function set begin_time(param1:Date) : void{}
      
      public function get end_time() : Date{return null;}
      
      public function set end_time(param1:Date) : void{}
      
      public function get fight_time() : int{return 0;}
      
      public function set fight_time(param1:int) : void{}
      
      public function getLeftTime() : int{return 0;}
      
      public function get fightOver() : Boolean{return false;}
      
      public function set fightOver(param1:Boolean) : void{}
      
      public function get roomClose() : Boolean{return false;}
      
      public function set roomClose(param1:Boolean) : void{}
      
      public function get currentState() : int{return 0;}
      
      public function set currentState(param1:int) : void{}
      
      public function set ticketID(param1:int) : void{}
      
      public function get ticketID() : int{return 0;}
      
      public function set need_ticket_count(param1:int) : void{}
      
      public function get need_ticket_count() : int{return 0;}
      
      public function get cutValue() : Number{return 0;}
      
      public function set name(param1:String) : void{}
      
      public function get name() : String{return null;}
      
      public function set timeCD(param1:int) : void{}
      
      public function get timeCD() : int{return 0;}
      
      public function set reviveMoney(param1:int) : void{}
      
      public function get reviveMoney() : int{return 0;}
      
      public function set playerDefaultPos(param1:Point) : void{}
      
      public function get playerDefaultPos() : Point{return null;}
      
      public function get reFightMoney() : int{return 0;}
      
      public function set reFightMoney(param1:int) : void{}
      
      public function get addInjureBuffMoney() : int{return 0;}
      
      public function set addInjureBuffMoney(param1:int) : void{}
      
      public function get addInjureValue() : int{return 0;}
      
      public function set addInjureValue(param1:int) : void{}
   }
}
