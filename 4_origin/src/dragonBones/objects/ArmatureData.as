package dragonBones.objects
{
   public final class ArmatureData
   {
       
      
      public var name:String;
      
      private var _boneDataList:Vector.<BoneData>;
      
      private var _skinDataList:Vector.<SkinData>;
      
      private var _slotDataList:Vector.<SlotData>;
      
      private var _animationDataList:Vector.<AnimationData>;
      
      public function ArmatureData()
      {
         super();
         _boneDataList = new Vector.<BoneData>(0,true);
         _skinDataList = new Vector.<SkinData>(0,true);
         _slotDataList = new Vector.<SlotData>(0,true);
         _animationDataList = new Vector.<AnimationData>(0,true);
      }
      
      public function setSkinData(param1:String) : void
      {
         var _loc7_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         _loc7_ = 0;
         _loc4_ = _slotDataList.length;
         while(_loc7_ < _loc4_)
         {
            _slotDataList[_loc7_].dispose();
            _loc7_++;
         }
         if(!param1 && _skinDataList.length > 0)
         {
            _loc3_ = _skinDataList[0];
         }
         else
         {
            _loc7_ = 0;
            _loc4_ = _skinDataList.length;
            _skinDataList.length;
            while(_loc7_ < _loc4_)
            {
               if(_skinDataList[_loc7_].name == param1)
               {
                  _loc3_ = _skinDataList[_loc7_];
                  break;
               }
               _loc7_++;
            }
         }
         if(_loc3_)
         {
            _loc7_ = 0;
            _loc4_ = _loc3_.slotDataList.length;
            _loc3_.slotDataList.length;
            while(_loc7_ < _loc4_)
            {
               _loc2_ = getSlotData(_loc3_.slotDataList[_loc7_].name);
               if(_loc2_)
               {
                  _loc6_ = 0;
                  _loc5_ = _loc3_.slotDataList[_loc7_].displayDataList.length;
                  while(_loc6_ < _loc5_)
                  {
                     _loc2_.addDisplayData(_loc3_.slotDataList[_loc7_].displayDataList[_loc6_]);
                     _loc6_++;
                  }
               }
               _loc7_++;
            }
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:int = _boneDataList.length;
         while(true)
         {
            _loc1_--;
            if(!_loc1_)
            {
               break;
            }
            _boneDataList[_loc1_].dispose();
         }
         _loc1_ = _skinDataList.length;
         while(true)
         {
            _loc1_--;
            if(!_loc1_)
            {
               break;
            }
            _skinDataList[_loc1_].dispose();
         }
         _loc1_ = _slotDataList.length;
         while(true)
         {
            _loc1_--;
            if(!_loc1_)
            {
               break;
            }
            _slotDataList[_loc1_].dispose();
         }
         _loc1_ = _animationDataList.length;
         while(true)
         {
            _loc1_--;
            if(!_loc1_)
            {
               break;
            }
            _animationDataList[_loc1_].dispose();
         }
         _boneDataList.fixed = false;
         _boneDataList.length = 0;
         _skinDataList.fixed = false;
         _skinDataList.length = 0;
         _slotDataList.fixed = false;
         _slotDataList.length = 0;
         _animationDataList.fixed = false;
         _animationDataList.length = 0;
         _boneDataList = null;
         _skinDataList = null;
         _slotDataList = null;
         _animationDataList = null;
      }
      
      public function getBoneData(param1:String) : BoneData
      {
         var _loc2_:int = _boneDataList.length;
         while(true)
         {
            _loc2_--;
            if(!_loc2_)
            {
               break;
            }
            if(_boneDataList[_loc2_].name == param1)
            {
               return _boneDataList[_loc2_];
            }
         }
         return null;
      }
      
      public function getSlotData(param1:String) : SlotData
      {
         if(!param1 && _slotDataList.length > 0)
         {
            return _slotDataList[0];
         }
         var _loc2_:int = _slotDataList.length;
         while(true)
         {
            _loc2_--;
            if(!_loc2_)
            {
               break;
            }
            if(_slotDataList[_loc2_].name == param1)
            {
               return _slotDataList[_loc2_];
            }
         }
         return null;
      }
      
      public function getSkinData(param1:String) : SkinData
      {
         if(!param1 && _skinDataList.length > 0)
         {
            return _skinDataList[0];
         }
         var _loc2_:int = _skinDataList.length;
         while(true)
         {
            _loc2_--;
            if(!_loc2_)
            {
               break;
            }
            if(_skinDataList[_loc2_].name == param1)
            {
               return _skinDataList[_loc2_];
            }
         }
         return null;
      }
      
      public function getAnimationData(param1:String) : AnimationData
      {
         var _loc2_:int = _animationDataList.length;
         while(true)
         {
            _loc2_--;
            if(!_loc2_)
            {
               break;
            }
            if(_animationDataList[_loc2_].name == param1)
            {
               return _animationDataList[_loc2_];
            }
         }
         return null;
      }
      
      public function addBoneData(param1:BoneData) : void
      {
         if(!param1)
         {
            throw new ArgumentError();
         }
         if(_boneDataList.indexOf(param1) < 0)
         {
            _boneDataList.fixed = false;
            _boneDataList[_boneDataList.length] = param1;
            _boneDataList.fixed = true;
            return;
         }
         throw new ArgumentError();
      }
      
      public function addSlotData(param1:SlotData) : void
      {
         if(!param1)
         {
            throw new ArgumentError();
         }
         if(_slotDataList.indexOf(param1) < 0)
         {
            _slotDataList.fixed = false;
            _slotDataList[_slotDataList.length] = param1;
            _slotDataList.fixed = true;
            return;
         }
         throw new ArgumentError();
      }
      
      public function addSkinData(param1:SkinData) : void
      {
         if(!param1)
         {
            throw new ArgumentError();
         }
         if(_skinDataList.indexOf(param1) < 0)
         {
            _skinDataList.fixed = false;
            _skinDataList[_skinDataList.length] = param1;
            _skinDataList.fixed = true;
            return;
         }
         throw new ArgumentError();
      }
      
      public function addAnimationData(param1:AnimationData) : void
      {
         if(!param1)
         {
            throw new ArgumentError();
         }
         if(_animationDataList.indexOf(param1) < 0)
         {
            _animationDataList.fixed = false;
            _animationDataList[_animationDataList.length] = param1;
            _animationDataList.fixed = true;
         }
      }
      
      public function sortBoneDataList() : void
      {
         var _loc4_:* = null;
         var _loc1_:int = 0;
         var _loc3_:* = null;
         var _loc5_:int = _boneDataList.length;
         if(_loc5_ == 0)
         {
            return;
         }
         var _loc2_:Array = [];
         while(true)
         {
            _loc5_--;
            if(!_loc5_)
            {
               break;
            }
            _loc4_ = _boneDataList[_loc5_];
            _loc1_ = 0;
            _loc3_ = _loc4_;
            while(_loc3_)
            {
               _loc1_++;
               _loc3_ = getBoneData(_loc3_.parent);
            }
            _loc2_[_loc5_] = [_loc1_,_loc4_];
         }
         _loc2_.sortOn("0",16);
         _loc5_ = _loc2_.length;
         while(true)
         {
            _loc5_--;
            if(!_loc5_)
            {
               break;
            }
            _boneDataList[_loc5_] = _loc2_[_loc5_][1];
         }
      }
      
      public function get boneDataList() : Vector.<BoneData>
      {
         return _boneDataList;
      }
      
      public function get skinDataList() : Vector.<SkinData>
      {
         return _skinDataList;
      }
      
      public function get animationDataList() : Vector.<AnimationData>
      {
         return _animationDataList;
      }
      
      public function get slotDataList() : Vector.<SlotData>
      {
         return _slotDataList;
      }
   }
}
