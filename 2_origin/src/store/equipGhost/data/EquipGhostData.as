package store.equipGhost.data
{
   import ddt.data.BagInfo;
   
   public class EquipGhostData
   {
       
      
      private var _bagType:uint;
      
      private var _place:uint;
      
      private var _categoryID:uint;
      
      public var level:uint;
      
      public var totalGhost:uint;
      
      public function EquipGhostData(param1:uint, param2:uint)
      {
         super();
         _bagType = param1;
         _place = param2;
         _categoryID = BagInfo.parseCategoryID(_bagType,_place);
      }
      
      public function get categoryID() : uint
      {
         return _categoryID;
      }
      
      public function get place() : uint
      {
         return _place;
      }
      
      public function get bagType() : uint
      {
         return _bagType;
      }
   }
}
