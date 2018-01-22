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
         for each(var _loc1_ in _armatureDataList)
         {
            _loc1_.dispose();
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
      
      public function getArmatureDataByName(param1:String) : ArmatureData
      {
         var _loc2_:int = _armatureDataList.length;
         while(true)
         {
            _loc2_--;
            if(!_loc2_)
            {
               break;
            }
            if(_armatureDataList[_loc2_].name == param1)
            {
               return _armatureDataList[_loc2_];
            }
         }
         return null;
      }
      
      public function addArmatureData(param1:ArmatureData) : void
      {
         if(!param1)
         {
            throw new ArgumentError();
         }
         if(_armatureDataList.indexOf(param1) < 0)
         {
            _armatureDataList.fixed = false;
            _armatureDataList[_armatureDataList.length] = param1;
            _armatureDataList.fixed = true;
            return;
         }
         throw new ArgumentError();
      }
      
      public function removeArmatureData(param1:ArmatureData) : void
      {
         var _loc2_:int = _armatureDataList.indexOf(param1);
         if(_loc2_ >= 0)
         {
            _armatureDataList.fixed = false;
            _armatureDataList.splice(_loc2_,1);
            _armatureDataList.fixed = true;
         }
      }
      
      public function removeArmatureDataByName(param1:String) : void
      {
         var _loc2_:int = _armatureDataList.length;
         while(true)
         {
            _loc2_--;
            if(!_loc2_)
            {
               break;
            }
            if(_armatureDataList[_loc2_].name == param1)
            {
               _armatureDataList.fixed = false;
               _armatureDataList.splice(_loc2_,1);
               _armatureDataList.fixed = true;
            }
         }
      }
      
      public function getDisplayDataByName(param1:String) : DisplayData
      {
         return _displayDataDictionary[param1];
      }
      
      public function addDisplayData(param1:DisplayData) : void
      {
         _displayDataDictionary[param1.name] = param1;
      }
      
      public function removeDisplayDataByName(param1:String) : void
      {
      }
      
      public function removeAllDisplayData() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _displayDataDictionary;
         for(var _loc1_ in _displayDataDictionary)
         {
            delete _displayDataDictionary[_loc1_];
         }
      }
   }
}
