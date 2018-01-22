package dragonBones.objects
{
   public class Frame
   {
       
      
      public var position:int;
      
      public var duration:int;
      
      public var action:String;
      
      public var event:String;
      
      public var eventParameters:String;
      
      public var sound:String;
      
      public var curve:CurveData;
      
      public function Frame()
      {
         super();
         position = 0;
         duration = 0;
      }
      
      public function dispose() : void
      {
      }
   }
}
