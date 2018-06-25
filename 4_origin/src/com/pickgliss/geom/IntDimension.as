package com.pickgliss.geom
{
   public class IntDimension
   {
       
      
      public var width:int = 0;
      
      public var height:int = 0;
      
      public function IntDimension(width:int = 0, height:int = 0)
      {
         super();
         this.width = width;
         this.height = height;
      }
      
      public static function createBigDimension() : IntDimension
      {
         return new IntDimension(100000,100000);
      }
      
      public function setSize(dim:IntDimension) : void
      {
         this.width = dim.width;
         this.height = dim.height;
      }
      
      public function setSizeWH(width:int, height:int) : void
      {
         this.width = width;
         this.height = height;
      }
      
      public function increaseSize(s:IntDimension) : IntDimension
      {
         width = width + s.width;
         height = height + s.height;
         return this;
      }
      
      public function decreaseSize(s:IntDimension) : IntDimension
      {
         width = width - s.width;
         height = height - s.height;
         return this;
      }
      
      public function change(deltaW:int, deltaH:int) : IntDimension
      {
         width = width + deltaW;
         height = height + deltaH;
         return this;
      }
      
      public function changedSize(deltaW:int, deltaH:int) : IntDimension
      {
         var s:IntDimension = new IntDimension(deltaW,deltaH);
         return s;
      }
      
      public function combine(d:IntDimension) : IntDimension
      {
         this.width = Math.max(this.width,d.width);
         this.height = Math.max(this.height,d.height);
         return this;
      }
      
      public function combineSize(d:IntDimension) : IntDimension
      {
         return clone().combine(d);
      }
      
      public function getBounds(x:int = 0, y:int = 0) : IntRectangle
      {
         var p:IntPoint = new IntPoint(x,y);
         var r:IntRectangle = new IntRectangle();
         r.setLocation(p);
         r.setSize(this);
         return r;
      }
      
      public function equals(o:Object) : Boolean
      {
         var d:IntDimension = o as IntDimension;
         if(d == null)
         {
            return false;
         }
         return width === d.width && height === d.height;
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
