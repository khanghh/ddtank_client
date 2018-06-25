package mark.data
{
   public class MarkHammerTemplateData
   {
       
      
      public var Level:int;
      
      public var Character:int;
      
      public var Currency:int;
      
      public var Expend:int;
      
      public var SuccessRate:int;
      
      public function MarkHammerTemplateData()
      {
         super();
      }
      
      public function get rate() : int
      {
         var rateNum:int = SuccessRate / 1000 * 100;
         return rateNum <= 0?1:rateNum;
      }
   }
}
