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
      
      public function FightPlayerVo(target:IEventDispatcher = null)
      {
         super(target);
      }
      
      public function get isFight() : Boolean
      {
         return _isFight;
      }
      
      public function set isFight(value:Boolean) : void
      {
         _isFight = value;
      }
      
      public function get isDie() : Boolean
      {
         return _isDie;
      }
      
      public function set isDie(value:Boolean) : void
      {
         _isDie = value;
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      public function set state(value:int) : void
      {
         _state = value;
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
      
      public function set reviveTime(value:Date) : void
      {
         _reviveTime = value;
      }
   }
}
