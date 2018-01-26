package com.pickgliss.geom
{
   public class IntDimension
   {
       
      
      public var width:int = 0;
      
      public var height:int = 0;
      
      public function IntDimension(param1:int = 0, param2:int = 0){super();}
      
      public static function createBigDimension() : IntDimension{return null;}
      
      public function setSize(param1:IntDimension) : void{}
      
      public function setSizeWH(param1:int, param2:int) : void{}
      
      public function increaseSize(param1:IntDimension) : IntDimension{return null;}
      
      public function decreaseSize(param1:IntDimension) : IntDimension{return null;}
      
      public function change(param1:int, param2:int) : IntDimension{return null;}
      
      public function changedSize(param1:int, param2:int) : IntDimension{return null;}
      
      public function combine(param1:IntDimension) : IntDimension{return null;}
      
      public function combineSize(param1:IntDimension) : IntDimension{return null;}
      
      public function getBounds(param1:int = 0, param2:int = 0) : IntRectangle{return null;}
      
      public function equals(param1:Object) : Boolean{return false;}
      
      public function clone() : IntDimension{return null;}
      
      public function toString() : String{return null;}
   }
}
