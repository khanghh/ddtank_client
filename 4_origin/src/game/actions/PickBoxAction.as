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
      
      public function PickBoxAction(param1:int, param2:int)
      {
         super();
         _time = param2;
         _boxid = param1;
      }
      
      public function get time() : int
      {
         return _time;
      }
      
      public function execute(param1:GamePlayer) : void
      {
         executed = true;
         var _loc2_:PhysicalObj = param1.map.getPhysical(_boxid);
         if(_loc2_ is SimpleBox)
         {
            SimpleBox(_loc2_).pickByLiving(param1.info);
         }
      }
   }
}
