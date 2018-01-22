package dragonBones.objects
{
   import dragonBones.utils.TransformUtil;
   import flash.geom.Matrix;
   
   public class DBTransform
   {
       
      
      public var x:Number;
      
      public var y:Number;
      
      public var skewX:Number;
      
      public var skewY:Number;
      
      public var scaleX:Number;
      
      public var scaleY:Number;
      
      public function DBTransform()
      {
         super();
         x = 0;
         y = 0;
         skewX = 0;
         skewY = 0;
         scaleX = 1;
         scaleY = 1;
      }
      
      public function get rotation() : Number
      {
         return skewX;
      }
      
      public function set rotation(param1:Number) : void
      {
         skewY = param1;
         skewX = param1;
      }
      
      public function copy(param1:DBTransform) : void
      {
         x = param1.x;
         y = param1.y;
         skewX = param1.skewX;
         skewY = param1.skewY;
         scaleX = param1.scaleX;
         scaleY = param1.scaleY;
      }
      
      public function add(param1:DBTransform) : void
      {
         x = x + param1.x;
         y = y + param1.y;
         skewX = skewX + param1.skewX;
         skewY = skewY + param1.skewY;
         scaleX = scaleX * param1.scaleX;
         scaleY = scaleY * param1.scaleY;
      }
      
      public function minus(param1:DBTransform) : void
      {
         x = x - param1.x;
         y = y - param1.y;
         skewX = skewX - param1.skewX;
         skewY = skewY - param1.skewY;
         scaleX = scaleX / param1.scaleX;
         scaleY = scaleY / param1.scaleY;
      }
      
      public function divParent(param1:DBTransform, param2:Boolean = false) : DBTransform
      {
         var _loc6_:DBTransform = !!param2?new DBTransform():this;
         var _loc4_:Matrix = new Matrix();
         TransformUtil.transformToMatrix(param1,_loc4_);
         var _loc7_:Number = x - _loc4_.tx;
         var _loc3_:Number = y - _loc4_.ty;
         var _loc5_:Number = _loc4_.a * _loc4_.d - _loc4_.c * _loc4_.b;
         _loc6_.x = (_loc7_ * _loc4_.d - _loc3_ * _loc4_.c) / _loc5_;
         _loc6_.y = (_loc3_ * _loc4_.a - _loc7_ * _loc4_.b) / _loc5_;
         _loc6_.scaleX = scaleX / param1.scaleX;
         _loc6_.scaleY = scaleY / param1.scaleY;
         _loc6_.skewX = skewX - param1.skewX;
         _loc6_.skewY = skewY - param1.skewY;
         return _loc6_;
      }
      
      public function normalizeRotation() : void
      {
         skewX = TransformUtil.normalizeRotation(skewX);
         skewY = TransformUtil.normalizeRotation(skewY);
      }
      
      public function toString() : String
      {
         var _loc1_:String = "x:" + x + " y:" + y + " skewX:" + skewX + " skewY:" + skewY + " scaleX:" + scaleX + " scaleY:" + scaleY;
         return _loc1_;
      }
   }
}
