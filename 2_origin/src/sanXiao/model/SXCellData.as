package sanXiao.model
{
   public class SXCellData
   {
       
      
      public var row:Number;
      
      public var column:Number;
      
      public var type:int;
      
      public var isLocked:Boolean = false;
      
      public function SXCellData($row:Number, $column:Number, $type:int = 0)
      {
         super();
         row = $row;
         column = $column;
         type = $type;
      }
   }
}
