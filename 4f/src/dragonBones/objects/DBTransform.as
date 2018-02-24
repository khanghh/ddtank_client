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
      
      public function DBTransform(){super();}
      
      public function get rotation() : Number{return 0;}
      
      public function set rotation(param1:Number) : void{}
      
      public function copy(param1:DBTransform) : void{}
      
      public function add(param1:DBTransform) : void{}
      
      public function minus(param1:DBTransform) : void{}
      
      public function divParent(param1:DBTransform, param2:Boolean = false) : DBTransform{return null;}
      
      public function normalizeRotation() : void{}
      
      public function toString() : String{return null;}
   }
}
