package game.actions
{
   import game.objects.GamePlayer;
   import game.objects.SimpleBox;
   import phy.object.PhysicalObj;
   
   public class PickBoxAction
   {
       
      
      public var executed:Boolean = false;
      
      private var _time:int;
      
      private var _boxid:int;
      
      public function PickBoxAction(boxid:int, time:int)
      {
         super();
         _time = time;
         _boxid = boxid;
      }
      
      public function get time() : int
      {
         return _time;
      }
      
      public function execute(player:GamePlayer) : void
      {
         executed = true;
         var obj:PhysicalObj = player.map.getPhysical(_boxid);
         if(obj is SimpleBox)
         {
            SimpleBox(obj).pickByLiving(player.info);
         }
      }
   }
}
