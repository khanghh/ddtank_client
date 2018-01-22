package starling.display.player
{
   import flash.events.IEventDispatcher;
   import hall.player.vo.PlayerVO;
   
   public class FightPlayerVo extends PlayerVO
   {
       
      
      private var _isFight:Boolean;
      
      private var _isDie:Boolean;
      
      private var _state:int;
      
      private var _reviveTime:Date;
      
      public var stateType:String;
      
      public function FightPlayerVo(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public function get isFight() : Boolean
      {
         return _isFight;
      }
      
      public function set isFight(param1:Boolean) : void
      {
         _isFight = param1;
      }
      
      public function get isDie() : Boolean
      {
         return _isDie;
      }
      
      public function set isDie(param1:Boolean) : void
      {
         _isDie = param1;
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      public function set state(param1:int) : void
      {
         _state = param1;
         _isFight = false;
         _isDie = false;
         if(_state != 0)
         {
            if(_state == 1)
            {
               _isDie = true;
            }
            else if(_state == 2)
            {
               _isFight = true;
            }
         }
      }
      
      public function get reviveTime() : Date
      {
         return _reviveTime;
      }
      
      public function set reviveTime(param1:Date) : void
      {
         _reviveTime = param1;
      }
   }
}
