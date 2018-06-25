package dragonBones.objects{   import flash.utils.Dictionary;      public class DragonBonesData   {                   public var name:String;            public var isGlobalData:Boolean;            private var _armatureDataList:Vector.<ArmatureData>;            private var _displayDataDictionary:Dictionary;            public function DragonBonesData() { super(); }
            public function dispose() : void { }
            public function get armatureDataList() : Vector.<ArmatureData> { return null; }
            public function getArmatureDataByName(armatureName:String) : ArmatureData { return null; }
            public function addArmatureData(armatureData:ArmatureData) : void { }
            public function removeArmatureData(armatureData:ArmatureData) : void { }
            public function removeArmatureDataByName(armatureName:String) : void { }
            public function getDisplayDataByName(name:String) : DisplayData { return null; }
            public function addDisplayData(displayData:DisplayData) : void { }
            public function removeDisplayDataByName(name:String) : void { }
            public function removeAllDisplayData() : void { }
   }}