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
      
      public function SmallObject()
      {
         _pos = new Point();
         super();
         draw();
      }
      
      override public function set visible(param1:Boolean) : void
      {
         .super.visible = param1;
      }
      
      public function get color() : int
      {
         return _color;
      }
      
      public function set color(param1:int) : void
      {
         _color = param1;
         draw();
      }
      
      public function get onMap() : Boolean
      {
         return parent != null;
      }
      
      protected function draw() : void
      {
      }
      
      public function onFrame(param1:int) : void
      {
      }
      
      public function dispose() : void
      {
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get pos() : Point
      {
         return _pos;
      }
      
      public function set isAttacking(param1:Boolean) : void
      {
         _isAttacking = param1;
      }
      
      public function get isAttacking() : Boolean
      {
         return _isAttacking;
      }
   }
}
