package AvatarCollection.data
{
   import AvatarCollection.AvatarCollectionManager;
   import com.pickgliss.ui.controls.cell.INotSameHeightListCellData;
   
   public class AvatarCollectionUnitVo implements INotSameHeightListCellData
   {
       
      
      private var _selected:Boolean = false;
      
      private var _id:int;
      
      public var sex:int;
      
      public var name:String;
      
      public var Attack:int;
      
      public var Defence:int;
      
      public var Agility:int;
      
      public var Luck:int;
      
      public var Blood:int;
      
      public var Damage:int;
      
      public var Guard:int;
      
      public var needHonor:int;
      
      public var endTime:Date;
      
      public var Type:int = 1;
      
      public function AvatarCollectionUnitVo()
      {
         super();
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         var _loc2_:int = totalItemList.length / 2;
         if(totalActivityItemCount >= _loc2_)
         {
            _selected = param1;
         }
         else
         {
            _selected = false;
         }
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function set id(param1:int) : void
      {
         _id = param1;
      }
      
      public function get totalItemList() : Array
      {
         return AvatarCollectionManager.instance.getItemListById(sex,id,Type);
      }
      
      public function get totalActivityItemCount() : int
      {
         var _loc2_:Array = totalItemList;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:* = _loc2_;
         for each(var _loc1_ in _loc2_)
         {
            if(_loc1_.isActivity)
            {
               _loc3_++;
            }
         }
         return _loc3_;
      }
      
      public function get canActivityCount() : int
      {
         var _loc2_:Array = totalItemList;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:* = _loc2_;
         for each(var _loc1_ in _loc2_)
         {
            if(!_loc1_.isActivity && _loc1_.isHas)
            {
               _loc3_++;
            }
         }
         return _loc3_;
      }
      
      public function get canBuyCount() : int
      {
         var _loc2_:Array = totalItemList;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:* = _loc2_;
         for each(var _loc1_ in _loc2_)
         {
            if(!_loc1_.isActivity && !_loc1_.isHas && _loc1_.canBuyStatus == 1)
            {
               _loc3_++;
            }
         }
         return _loc3_;
      }
      
      public function getCellHeight() : Number
      {
         return 37;
      }
   }
}
