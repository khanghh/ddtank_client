package wonderfulActivity.data
{
   public class LeftViewInfoVo
   {
       
      
      public var viewType:int;
      
      public var label:String;
      
      public var unitIndex:int;
      
      public function LeftViewInfoVo(param1:int, param2:String = "", param3:int = 1)
      {
         super();
         this.viewType = param1;
         this.label = param2;
         this.unitIndex = param3;
      }
   }
}
