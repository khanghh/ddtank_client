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
      
      public function set rotation(value:Number) : void
      {
         skewY = value;
         skewX = value;
      }
      
      public function copy(transform:DBTransform) : void
      {
         x = transform.x;
         y = transform.y;
         skewX = transform.skewX;
         skewY = transform.skewY;
         scaleX = transform.scaleX;
         scaleY = transform.scaleY;
      }
      
      public function add(transform:DBTransform) : void
      {
         x = x + transform.x;
         y = y + transform.y;
         skewX = skewX + transform.skewX;
         skewY = skewY + transform.skewY;
         scaleX = scaleX * transform.scaleX;
         scaleY = scaleY * transform.scaleY;
      }
      
      public function minus(transform:DBTransform) : void
      {
         x = x - transform.x;
         y = y - transform.y;
         skewX = skewX - transform.skewX;
         skewY = skewY - transform.skewY;
         scaleX = scaleX / transform.scaleX;
         scaleY = scaleY / transform.scaleY;
      }
      
      public function divParent(transform:DBTransform, createNew:Boolean = false) : DBTransform
      {
         var output:DBTransform = !!createNew?new DBTransform():this;
         var parentMatrix:Matrix = new Matrix();
         TransformUtil.transformToMatrix(transform,parentMatrix);
         var xtx:Number = x - parentMatrix.tx;
         var yty:Number = y - parentMatrix.ty;
         var adcb:Number = parentMatrix.a * parentMatrix.d - parentMatrix.c * parentMatrix.b;
         output.x = (xtx * parentMatrix.d - yty * parentMatrix.c) / adcb;
         output.y = (yty * parentMatrix.a - xtx * parentMatrix.b) / adcb;
         output.scaleX = scaleX / transform.scaleX;
         output.scaleY = scaleY / transform.scaleY;
         output.skewX = skewX - transform.skewX;
         output.skewY = skewY - transform.skewY;
         return output;
      }
      
      public function normalizeRotation() : void
      {
         skewX = TransformUtil.normalizeRotation(skewX);
         skewY = TransformUtil.normalizeRotation(skewY);
      }
      
      public function toString() : String
      {
         var string:String = "x:" + x + " y:" + y + " skewX:" + skewX + " skewY:" + skewY + " scaleX:" + scaleX + " scaleY:" + scaleY;
         return string;
      }
   }
}
