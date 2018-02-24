package phy.bombs
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import phy.object.PhysicalObj;
   
   public class BaseBomb extends PhysicalObj
   {
       
      
      protected var _movie:Sprite;
      
      protected var _shape:Bitmap;
      
      protected var _border:Bitmap;
      
      public function BaseBomb(param1:int, param2:Number = 10, param3:Number = 100, param4:Number = 1, param5:Number = 1){super(null,null,null,null,null,null);}
      
      public function setMovie(param1:Sprite, param2:Bitmap, param3:Bitmap) : void{}
      
      override public function update(param1:Number) : void{}
      
      public function get bombRectang() : Rectangle{return null;}
      
      override protected function collideGround() : void{}
      
      public function bomb() : void{}
      
      public function bombAtOnce() : void{}
      
      protected function DigMap() : void{}
      
      override public function die() : void{}
      
      override public function dispose() : void{}
   }
}
