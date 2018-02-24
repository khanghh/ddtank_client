package com.pickgliss.geom
{
   import flash.geom.Rectangle;
   
   public class IntRectangle
   {
       
      
      public var x:int = 0;
      
      public var y:int = 0;
      
      public var width:int = 0;
      
      public var height:int = 0;
      
      public function IntRectangle(param1:int = 0, param2:int = 0, param3:int = 0, param4:int = 0){super();}
      
      public static function creatWithRectangle(param1:Rectangle) : IntRectangle{return null;}
      
      public function toRectangle() : Rectangle{return null;}
      
      public function setWithRectangle(param1:Rectangle) : void{}
      
      public function setRect(param1:IntRectangle) : void{}
      
      public function setRectXYWH(param1:int, param2:int, param3:int, param4:int) : void{}
      
      public function setLocation(param1:IntPoint) : void{}
      
      public function setSize(param1:IntDimension) : void{}
      
      public function getSize() : IntDimension{return null;}
      
      public function getLocation() : IntPoint{return null;}
      
      public function union(param1:IntRectangle) : IntRectangle{return null;}
      
      public function grow(param1:int, param2:int) : void{}
      
      public function move(param1:int, param2:int) : void{}
      
      public function resize(param1:int = 0, param2:int = 0) : void{}
      
      public function leftTop() : IntPoint{return null;}
      
      public function rightTop() : IntPoint{return null;}
      
      public function leftBottom() : IntPoint{return null;}
      
      public function rightBottom() : IntPoint{return null;}
      
      public function containsPoint(param1:IntPoint) : Boolean{return false;}
      
      public function equals(param1:Object) : Boolean{return false;}
      
      public function clone() : IntRectangle{return null;}
      
      public function toString() : String{return null;}
   }
}
