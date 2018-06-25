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
      
      public function set selected(value:Boolean) : void
      {
         var half:int = totalItemList.length / 2;
         if(totalActivityItemCount >= half)
         {
            _selected = value;
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
      
      public function set id(value:int) : void
      {
         _id = value;
      }
      
      public function get totalItemList() : Array
      {
         return AvatarCollectionManager.instance.getItemListById(sex,id,Type);
      }
      
      public function get totalActivityItemCount() : int
      {
         var tmpList:Array = totalItemList;
         var tmpCount:int = 0;
         var _loc5_:int = 0;
         var _loc4_:* = tmpList;
         for each(var tmp in tmpList)
         {
            if(tmp.isActivity)
            {
               tmpCount++;
            }
         }
         return tmpCount;
      }
      
      public function get canActivityCount() : int
      {
         var tmpList:Array = totalItemList;
         var tmpCount:int = 0;
         var _loc5_:int = 0;
         var _loc4_:* = tmpList;
         for each(var tmp in tmpList)
         {
            if(!tmp.isActivity && tmp.isHas)
            {
               tmpCount++;
            }
         }
         return tmpCount;
      }
      
      public function get canBuyCount() : int
      {
         var tmpList:Array = totalItemList;
         var tmpCount:int = 0;
         var _loc5_:int = 0;
         var _loc4_:* = tmpList;
         for each(var tmp in tmpList)
         {
            if(!tmp.isActivity && !tmp.isHas && tmp.canBuyStatus == 1)
            {
               tmpCount++;
            }
         }
         return tmpCount;
      }
      
      public function getCellHeight() : Number
      {
         return 37;
      }
   }
}
