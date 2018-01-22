package com.pickgliss.geom
{
   public class IntDimension
   {
       
      
      public var width:int = 0;
      
      public var height:int = 0;
      
      public function IntDimension(param1:int = 0, param2:int = 0)
      {
         super();
         this.width = param1;
         this.height = param2;
      }
      
      public static function createBigDimension() : IntDimension
      {
         return new IntDimension(100000,100000);
      }
      
      public function setSize(param1:IntDimension) : void
      {
         this.width = param1.width;
         this.height = param1.height;
      }
      
      public function setSizeWH(param1:int, param2:int) : void
      {
         this.width = param1;
         this.height = param2;
      }
      
      public function increaseSize(param1:IntDimension) : IntDimension
      {
         width = width + param1.width;
         height = height + param1.height;
         return this;
      }
      
      public function decreaseSize(param1:IntDimension) : IntDimension
      {
         width = width - param1.width;
         height = height - param1.height;
         return this;
      }
      
      public function change(param1:int, param2:int) : IntDimension
      {
         width = width + param1;
         height = height + param2;
         return this;
      }
      
      public function changedSize(param1:int, param2:int) : IntDimension
      {
         var _loc3_:IntDimension = new IntDimension(param1,param2);
         return _loc3_;
      }
      
      public function combine(param1:IntDimension) : IntDimension
      {
         this.width = Math.max(this.width,param1.width);
         this.height = Math.max(this.height,param1.height);
         return this;
      }
      
      public function combineSize(param1:IntDimension) : IntDimension
      {
         return clone().combine(param1);
      }
      
      public function getBounds(param1:int = 0, param2:int = 0) : IntRectangle
      {
         var _loc4_:IntPoint = new IntPoint(param1,param2);
         var _loc3_:IntRectangle = new IntRectangle();
         _loc3_.setLocation(_loc4_);
         _loc3_.setSize(this);
         return _loc3_;
      }
      
      public function equals(param1:Object) : Boolean
      {
         var _loc2_:IntDimension = param1 as IntDimension;
         if(_loc2_ == null)
         {
            return false;
         }
         return width === _loc2_.width && height === _loc2_.height;
      }
      
      public function clone() : IntDimension
      {
         return new IntDimension(width,height);
      }
      
      public function toString() : String
      {
         return "IntDimension[" + width + "," + height + "]";
      }
   }
}
