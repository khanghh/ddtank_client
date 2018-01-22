package com.pickgliss.geom
{
   import flash.geom.Rectangle;
   
   public class InnerRectangle
   {
       
      
      public var lockDirection:int;
      
      public var para1:int;
      
      public var para2:int;
      
      public var para3:int;
      
      public var para4:int;
      
      private var _outerHeight:int;
      
      private var _outerWidth:int;
      
      private var _resultRect:Rectangle;
      
      public function InnerRectangle(param1:int, param2:int, param3:int, param4:int, param5:int = 0){super();}
      
      public function equals(param1:InnerRectangle) : Boolean{return false;}
      
      public function getInnerRect(param1:int, param2:int) : Rectangle{return null;}
      
      private function calculateCurrent() : Rectangle{return null;}
   }
}
