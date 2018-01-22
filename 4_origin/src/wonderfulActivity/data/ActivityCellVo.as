package wonderfulActivity.data
{
   import com.pickgliss.ui.controls.cell.INotSameHeightListCellData;
   
   public class ActivityCellVo implements INotSameHeightListCellData
   {
       
      
      public var id:String;
      
      public var activityName:String;
      
      public var viewType:int;
      
      public function ActivityCellVo()
      {
         super();
      }
      
      public function getCellHeight() : Number
      {
         return 33;
      }
   }
}
