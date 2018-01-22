package game.view
{
   import flash.geom.Point;
   import gameCommon.GameControl;
   import phy.maps.Map;
   import phy.object.PhysicalObj;
   
   public class RouteComputer
   {
      
      private static var DELAY_TIME:Number = 0.04;
       
      
      private var _map:Map;
      
      public function RouteComputer(param1:Map)
      {
         super();
         _map = param1;
      }
      
      public function getPath(param1:int, param2:int) : Array
      {
         var _loc4_:PhysicalObj = new PhysicalObj(0,1,10,70,240,1);
         _loc4_.x = GameControl.Instance.Current.selfGamePlayer.pos.x;
         _loc4_.y = GameControl.Instance.Current.selfGamePlayer.pos.y;
         _loc4_.setSpeedXY(new Point(getVx(param1,param2),getVy(param1,param2)));
         _loc4_.setCollideRect(-3,-3,6,6);
         _map.addPhysical(_loc4_);
         _loc4_.startMoving();
         var _loc3_:Array = [];
         while(_loc4_.isMoving())
         {
            _loc3_.push(new Point(_loc4_.x,_loc4_.y));
            _loc4_.update(DELAY_TIME);
         }
         return _loc3_;
      }
      
      private function getVx(param1:int, param2:int) : Number
      {
         var _loc3_:Number = param2 * Math.cos(param1 / 180 * 3.14159265358979);
         return _loc3_;
      }
      
      private function getVy(param1:int, param2:int) : Number
      {
         var _loc3_:Number = param2 * Math.sin(param1 / 180 * 3.14159265358979);
         return _loc3_;
      }
   }
}
