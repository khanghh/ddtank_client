package dragonBones.objects
{
   public final class SlotData
   {
       
      
      public var name:String;
      
      public var parent:String;
      
      public var zOrder:Number;
      
      public var blendMode:String;
      
      public var displayIndex:int;
      
      private var _displayDataList:Vector.<DisplayData>;
      
      public function SlotData()
      {
         super();
         _displayDataList = new Vector.<DisplayData>(0,true);
         zOrder = 0;
      }
      
      public function dispose() : void
      {
         _displayDataList.fixed = false;
         _displayDataList.length = 0;
      }
      
      public function addDisplayData(param1:DisplayData) : void
      {
         if(!param1)
         {
            throw new ArgumentError();
         }
         if(_displayDataList.indexOf(param1) < 0)
         {
            _displayDataList.fixed = false;
            _displayDataList[_displayDataList.length] = param1;
            _displayDataList.fixed = true;
            return;
         }
         throw new ArgumentError();
      }
      
      public function getDisplayData(param1:String) : DisplayData
      {
         var _loc2_:int = _displayDataList.length;
         while(true)
         {
            _loc2_--;
            if(!_loc2_)
            {
               break;
            }
            if(_displayDataList[_loc2_].name == param1)
            {
               return _displayDataList[_loc2_];
            }
         }
         return null;
      }
      
      public function get displayDataList() : Vector.<DisplayData>
      {
         return _displayDataList;
      }
   }
}
