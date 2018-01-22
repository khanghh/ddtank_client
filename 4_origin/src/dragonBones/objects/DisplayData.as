package dragonBones.objects
{
   import flash.geom.Point;
   
   public final class DisplayData
   {
      
      public static const ARMATURE:String = "armature";
      
      public static const IMAGE:String = "image";
       
      
      public var name:String;
      
      public var slotName:String;
      
      public var type:String;
      
      public var transform:DBTransform;
      
      public var pivot:Point;
      
      public function DisplayData()
      {
         super();
         transform = new DBTransform();
         pivot = new Point();
      }
      
      public function dispose() : void
      {
         transform = null;
         pivot = null;
      }
   }
}
