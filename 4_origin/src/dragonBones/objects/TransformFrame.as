package dragonBones.objects
{
   import flash.geom.Point;
   
   public final class TransformFrame extends Frame
   {
       
      
      public var tweenEasing:Number;
      
      public var tweenRotate:int;
      
      public var tweenScale:Boolean;
      
      public var visible:Boolean;
      
      public var global:DBTransform;
      
      public var transform:DBTransform;
      
      public var pivot:Point;
      
      public var scaleOffset:Point;
      
      public function TransformFrame()
      {
         super();
         tweenEasing = 10;
         tweenRotate = 0;
         visible = true;
         global = new DBTransform();
         transform = new DBTransform();
         pivot = new Point();
         scaleOffset = new Point();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         global = null;
         transform = null;
         pivot = null;
         scaleOffset = null;
      }
   }
}
