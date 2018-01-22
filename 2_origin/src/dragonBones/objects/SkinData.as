package dragonBones.objects
{
   public final class SkinData
   {
       
      
      public var name:String;
      
      private var _slotDataList:Vector.<SlotData>;
      
      public function SkinData()
      {
         super();
         _slotDataList = new Vector.<SlotData>(0,true);
      }
      
      public function dispose() : void
      {
         var _loc1_:int = _slotDataList.length;
         while(true)
         {
            _loc1_--;
            if(!_loc1_)
            {
               break;
            }
            _slotDataList[_loc1_].dispose();
         }
         _slotDataList.fixed = false;
         _slotDataList.length = 0;
         _slotDataList = null;
      }
      
      public function getSlotData(param1:String) : SlotData
      {
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
      
      public function get slotDataList() : Vector.<SlotData>
      {
         return _slotDataList;
      }
   }
}
