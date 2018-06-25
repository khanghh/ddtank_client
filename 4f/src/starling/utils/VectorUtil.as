package starling.utils{   import starling.errors.AbstractClassError;      public class VectorUtil   {                   public function VectorUtil() { super(); }
            public static function insertIntAt(vector:Vector.<int>, index:int, value:uint) : void { }
            public static function removeIntAt(vector:Vector.<int>, index:int) : int { return 0; }
            public static function insertUnsignedIntAt(vector:Vector.<uint>, index:int, value:uint) : void { }
            public static function removeUnsignedIntAt(vector:Vector.<uint>, index:int) : uint { return null; }
            public static function insertNumberAt(vector:Vector.<Number>, index:int, value:Number) : void { }
            public static function removeNumberAt(vector:Vector.<Number>, index:int) : Number { return 0; }
   }}