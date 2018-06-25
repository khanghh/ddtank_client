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
      
      public function setSkinData(skinName:String) : void
      {
         var i:int = 0;
         var len:int = 0;
         var skinData:* = null;
         var slotData:* = null;
         var j:int = 0;
         var jLen:int = 0;
         for(i = 0,len = _slotDataList.length; i < len; )
         {
            _slotDataList[i].dispose();
            i++;
         }
         if(!skinName && _skinDataList.length > 0)
         {
            skinData = _skinDataList[0];
         }
         else
         {
            i = 0;
            for(len = _skinDataList.length,_skinDataList.length; i < len; )
            {
               if(_skinDataList[i].name == skinName)
               {
                  skinData = _skinDataList[i];
                  break;
               }
               i++;
            }
         }
         if(skinData)
         {
            i = 0;
            for(len = skinData.slotDataList.length,skinData.slotDataList.length; i < len; )
            {
               slotData = getSlotData(skinData.slotDataList[i].name);
               if(slotData)
               {
                  for(j = 0,jLen = skinData.slotDataList[i].displayDataList.length; j < jLen; )
                  {
                     slotData.addDisplayData(skinData.slotDataList[i].displayDataList[j]);
                     j++;
                  }
               }
               i++;
            }
         }
      }
      
      public function dispose() : void
      {
         var i:int = _boneDataList.length;
         while(true)
         {
            i--;
            if(!i)
            {
               break;
            }
            _boneDataList[i].dispose();
         }
         i = _skinDataList.length;
         while(true)
         {
            i--;
            if(!i)
            {
               break;
            }
            _skinDataList[i].dispose();
         }
         i = _slotDataList.length;
         while(true)
         {
            i--;
            if(!i)
            {
               break;
            }
            _slotDataList[i].dispose();
         }
         i = _animationDataList.length;
         while(true)
         {
            i--;
            if(!i)
            {
               break;
            }
            _animationDataList[i].dispose();
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
      
      public function getBoneData(boneName:String) : BoneData
      {
         var i:int = _boneDataList.length;
         while(true)
         {
            i--;
            if(!i)
            {
               break;
            }
            if(_boneDataList[i].name == boneName)
            {
               return _boneDataList[i];
            }
         }
         return null;
      }
      
      public function getSlotData(slotName:String) : SlotData
      {
         if(!slotName && _slotDataList.length > 0)
         {
            return _slotDataList[0];
         }
         var i:int = _slotDataList.length;
         while(true)
         {
            i--;
            if(!i)
            {
               break;
            }
            if(_slotDataList[i].name == slotName)
            {
               return _slotDataList[i];
            }
         }
         return null;
      }
      
      public function getSkinData(skinName:String) : SkinData
      {
         if(!skinName && _skinDataList.length > 0)
         {
            return _skinDataList[0];
         }
         var i:int = _skinDataList.length;
         while(true)
         {
            i--;
            if(!i)
            {
               break;
            }
            if(_skinDataList[i].name == skinName)
            {
               return _skinDataList[i];
            }
         }
         return null;
      }
      
      public function getAnimationData(animationName:String) : AnimationData
      {
         var i:int = _animationDataList.length;
         while(true)
         {
            i--;
            if(!i)
            {
               break;
            }
            if(_animationDataList[i].name == animationName)
            {
               return _animationDataList[i];
            }
         }
         return null;
      }
      
      public function addBoneData(boneData:BoneData) : void
      {
         if(!boneData)
         {
            throw new ArgumentError();
         }
         if(_boneDataList.indexOf(boneData) < 0)
         {
            _boneDataList.fixed = false;
            _boneDataList[_boneDataList.length] = boneData;
            _boneDataList.fixed = true;
            return;
         }
         throw new ArgumentError();
      }
      
      public function addSlotData(slotData:SlotData) : void
      {
         if(!slotData)
         {
            throw new ArgumentError();
         }
         if(_slotDataList.indexOf(slotData) < 0)
         {
            _slotDataList.fixed = false;
            _slotDataList[_slotDataList.length] = slotData;
            _slotDataList.fixed = true;
            return;
         }
         throw new ArgumentError();
      }
      
      public function addSkinData(skinData:SkinData) : void
      {
         if(!skinData)
         {
            throw new ArgumentError();
         }
         if(_skinDataList.indexOf(skinData) < 0)
         {
            _skinDataList.fixed = false;
            _skinDataList[_skinDataList.length] = skinData;
            _skinDataList.fixed = true;
            return;
         }
         throw new ArgumentError();
      }
      
      public function addAnimationData(animationData:AnimationData) : void
      {
         if(!animationData)
         {
            throw new ArgumentError();
         }
         if(_animationDataList.indexOf(animationData) < 0)
         {
            _animationDataList.fixed = false;
            _animationDataList[_animationDataList.length] = animationData;
            _animationDataList.fixed = true;
         }
      }
      
      public function sortBoneDataList() : void
      {
         var boneData:* = null;
         var level:int = 0;
         var parentData:* = null;
         var i:int = _boneDataList.length;
         if(i == 0)
         {
            return;
         }
         var helpArray:Array = [];
         while(true)
         {
            i--;
            if(!i)
            {
               break;
            }
            boneData = _boneDataList[i];
            level = 0;
            parentData = boneData;
            while(parentData)
            {
               level++;
               parentData = getBoneData(parentData.parent);
            }
            helpArray[i] = [level,boneData];
         }
         helpArray.sortOn("0",16);
         i = helpArray.length;
         while(true)
         {
            i--;
            if(!i)
            {
               break;
            }
            _boneDataList[i] = helpArray[i][1];
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
