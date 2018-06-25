package dragonBones.objects
{
   import flash.utils.Dictionary;
   
   public class DragonBonesData
   {
       
      
      public var name:String;
      
      public var isGlobalData:Boolean;
      
      private var _armatureDataList:Vector.<ArmatureData>;
      
      private var _displayDataDictionary:Dictionary;
      
      public function DragonBonesData()
      {
         _armatureDataList = new Vector.<ArmatureData>(0,true);
         _displayDataDictionary = new Dictionary();
         super();
      }
      
      public function dispose() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _armatureDataList;
         for each(var armatureData in _armatureDataList)
         {
            armatureData.dispose();
         }
         _armatureDataList.fixed = false;
         _armatureDataList.length = 0;
         _armatureDataList = null;
         removeAllDisplayData();
         _displayDataDictionary = null;
      }
      
      public function get armatureDataList() : Vector.<ArmatureData>
      {
         return _armatureDataList;
      }
      
      public function getArmatureDataByName(armatureName:String) : ArmatureData
      {
         var i:int = _armatureDataList.length;
         while(true)
         {
            i--;
            if(!i)
            {
               break;
            }
            if(_armatureDataList[i].name == armatureName)
            {
               return _armatureDataList[i];
            }
         }
         return null;
      }
      
      public function addArmatureData(armatureData:ArmatureData) : void
      {
         if(!armatureData)
         {
            throw new ArgumentError();
         }
         if(_armatureDataList.indexOf(armatureData) < 0)
         {
            _armatureDataList.fixed = false;
            _armatureDataList[_armatureDataList.length] = armatureData;
            _armatureDataList.fixed = true;
            return;
         }
         throw new ArgumentError();
      }
      
      public function removeArmatureData(armatureData:ArmatureData) : void
      {
         var index:int = _armatureDataList.indexOf(armatureData);
         if(index >= 0)
         {
            _armatureDataList.fixed = false;
            _armatureDataList.splice(index,1);
            _armatureDataList.fixed = true;
         }
      }
      
      public function removeArmatureDataByName(armatureName:String) : void
      {
         var i:int = _armatureDataList.length;
         while(true)
         {
            i--;
            if(!i)
            {
               break;
            }
            if(_armatureDataList[i].name == armatureName)
            {
               _armatureDataList.fixed = false;
               _armatureDataList.splice(i,1);
               _armatureDataList.fixed = true;
            }
         }
      }
      
      public function getDisplayDataByName(name:String) : DisplayData
      {
         return _displayDataDictionary[name];
      }
      
      public function addDisplayData(displayData:DisplayData) : void
      {
         _displayDataDictionary[displayData.name] = displayData;
      }
      
      public function removeDisplayDataByName(name:String) : void
      {
      }
      
      public function removeAllDisplayData() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _displayDataDictionary;
         for(var name in _displayDataDictionary)
         {
            delete _displayDataDictionary[name];
         }
      }
   }
}
