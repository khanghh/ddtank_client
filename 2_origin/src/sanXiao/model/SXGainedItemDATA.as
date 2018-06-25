package sanXiao.model
{
   public class SXGainedItemDATA
   {
       
      
      public var templeteID:int;
      
      public var count:int;
      
      public function SXGainedItemDATA($templeteID:int, $count:int)
      {
         super();
         templeteID = $templeteID;
         count = $count;
      }
   }
}
