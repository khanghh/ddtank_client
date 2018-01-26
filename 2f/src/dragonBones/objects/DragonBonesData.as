package dragonBones.objects
{
   import flash.utils.Dictionary;
   
   public class DragonBonesData
   {
       
      
      public var name:String;
      
      public var isGlobalData:Boolean;
      
      private var _armatureDataList:Vector.<ArmatureData>;
      
      private var _displayDataDictionary:Dictionary;
      
      public function DragonBonesData(){super();}
      
      public function dispose() : void{}
      
      public function get armatureDataList() : Vector.<ArmatureData>{return null;}
      
      public function getArmatureDataByName(param1:String) : ArmatureData{return null;}
      
      public function addArmatureData(param1:ArmatureData) : void{}
      
      public function removeArmatureData(param1:ArmatureData) : void{}
      
      public function removeArmatureDataByName(param1:String) : void{}
      
      public function getDisplayDataByName(param1:String) : DisplayData{return null;}
      
      public function addDisplayData(param1:DisplayData) : void{}
      
      public function removeDisplayDataByName(param1:String) : void{}
      
      public function removeAllDisplayData() : void{}
   }
}
