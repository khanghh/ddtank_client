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
         var i:int = _slotDataList.length;
         while(true)
         {
            i--;
            if(!i)
            {
               break;
            }
            _slotDataList[i].dispose();
         }
         _slotDataList.fixed = false;
         _slotDataList.length = 0;
         _slotDataList = null;
      }
      
      public function getSlotData(slotName:String) : SlotData
      {
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
      
      public function get slotDataList() : Vector.<SlotData>
      {
         return _slotDataList;
      }
   }
}
