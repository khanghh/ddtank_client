package baglocked.data
{
   public class NeedPSWCellInfo
   {
       
      
      public var index:int;
      
      public var lanID:String;
      
      public function NeedPSWCellInfo(param1:int, param2:String)
      {
         super();
         index = param1;
         if(param2 == "")
         {
            lanID = "test测试";
         }
         else
         {
            lanID = param2;
         }
      }
   }
}
