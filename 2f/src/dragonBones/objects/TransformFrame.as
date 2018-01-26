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
      
      public function TransformFrame(){super();}
      
      override public function dispose() : void{}
   }
}
