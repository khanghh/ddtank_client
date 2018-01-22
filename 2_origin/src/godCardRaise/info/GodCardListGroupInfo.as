package godCardRaise.info
{
   import com.pickgliss.ui.controls.cell.INotSameHeightListCellData;
   
   public class GodCardListGroupInfo implements INotSameHeightListCellData
   {
       
      
      public var GroupID:int;
      
      public var GroupName:String;
      
      public var ExchangeTimes:int;
      
      public var Cards:Array;
      
      public var GiftID:int;
      
      public function GodCardListGroupInfo()
      {
         super();
      }
      
      public function getCellHeight() : Number
      {
         return 33;
      }
   }
}
