package sanXiao.model
{
   public class SXStoreBoughtData
   {
       
      
      public var boughtTimes:int;
      
      public var id:int;
      
      public function SXStoreBoughtData($id:int, $boughtTimes:int)
      {
         super();
         id = $id;
         boughtTimes = $boughtTimes;
      }
   }
}
