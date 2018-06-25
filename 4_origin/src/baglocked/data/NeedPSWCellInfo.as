package baglocked.data
{
   public class NeedPSWCellInfo
   {
       
      
      public var index:int;
      
      public var lanID:String;
      
      public function NeedPSWCellInfo($index:int, $lanID:String)
      {
         super();
         index = $index;
         if($lanID == "")
         {
            lanID = "test测试";
         }
         else
         {
            lanID = $lanID;
         }
      }
   }
}
