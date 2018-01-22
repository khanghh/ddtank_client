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
      
      public function execute(param1:GamePlayer3D) : void
      {
         executed = true;
         var _loc2_:PhysicalObj3D = param1.map.getPhysical(_boxid);
         if(_loc2_ is SimpleBox3D)
         {
            SimpleBox3D(_loc2_).pickByLiving(param1.info);
         }
      }
   }
}
