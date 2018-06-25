package gameStarling.actions
{
   import gameStarling.objects.GamePlayer3D;
   import gameStarling.objects.SimpleBox3D;
   import starlingPhy.object.PhysicalObj3D;
   
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
      
      public function execute(player:GamePlayer3D) : void
      {
         executed = true;
         var obj:PhysicalObj3D = player.map.getPhysical(_boxid);
         if(obj is SimpleBox3D)
         {
            SimpleBox3D(obj).pickByLiving(player.info);
         }
      }
   }
}
