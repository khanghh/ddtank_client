package dragonBones.objects{   public final class SlotData   {                   public var name:String;            public var parent:String;            public var zOrder:Number;            public var blendMode:String;            public var displayIndex:int;            private var _displayDataList:Vector.<DisplayData>;            public function SlotData() { super(); }
            public function dispose() : void { }
            public function addDisplayData(displayData:DisplayData) : void { }
            public function getDisplayData(displayName:String) : DisplayData { return null; }
            public function get displayDataList() : Vector.<DisplayData> { return null; }
   }}