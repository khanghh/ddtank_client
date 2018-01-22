package dragonBones.objects
{
   public final class SlotData
   {
       
      
      public var name:String;
      
      public var parent:String;
      
      public var zOrder:Number;
      
      public var blendMode:String;
      
      public var displayIndex:int;
      
      private var _displayDataList:Vector.<DisplayData>;
      
      public function SlotData(){super();}
      
      public function dispose() : void{}
      
      public function addDisplayData(param1:DisplayData) : void{}
      
      public function getDisplayData(param1:String) : DisplayData{return null;}
      
      public function get displayDataList() : Vector.<DisplayData>{return null;}
   }
}
