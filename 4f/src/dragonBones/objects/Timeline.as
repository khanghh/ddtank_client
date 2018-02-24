package dragonBones.objects
{
   public class Timeline
   {
       
      
      public var duration:int;
      
      public var scale:Number;
      
      private var _frameList:Vector.<Frame>;
      
      public function Timeline(){super();}
      
      public function dispose() : void{}
      
      public function addFrame(param1:Frame) : void{}
      
      public function get frameList() : Vector.<Frame>{return null;}
   }
}
