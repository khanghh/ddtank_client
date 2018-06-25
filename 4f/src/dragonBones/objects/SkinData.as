package dragonBones.objects{   public final class SkinData   {                   public var name:String;            private var _slotDataList:Vector.<SlotData>;            public function SkinData() { super(); }
            public function dispose() : void { }
            public function getSlotData(slotName:String) : SlotData { return null; }
            public function addSlotData(slotData:SlotData) : void { }
            public function get slotDataList() : Vector.<SlotData> { return null; }
   }}