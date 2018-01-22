package phy.object
{
   import com.pickgliss.ui.core.Disposeable;
   import flash.display.Shape;
   import flash.geom.Point;
   
   public class SmallObject extends Shape implements Disposeable
   {
      
      protected static const MovieTime:Number = 0.6;
       
      
      protected var _elapsed:int = 0;
      
      protected var _color:int = 16711680;
      
      protected var _radius:int = 4;
      
      private var _pos:Point;
      
      protected var _isAttacking:Boolean = false;
      
      public var onProcess:Boolean = false;
      
      public function SmallObject(){super();}
      
      override public function set visible(param1:Boolean) : void{}
      
      public function get color() : int{return 0;}
      
      public function set color(param1:int) : void{}
      
      public function get onMap() : Boolean{return false;}
      
      protected function draw() : void{}
      
      public function onFrame(param1:int) : void{}
      
      public function dispose() : void{}
      
      public function get pos() : Point{return null;}
      
      public function set isAttacking(param1:Boolean) : void{}
      
      public function get isAttacking() : Boolean{return false;}
   }
}
