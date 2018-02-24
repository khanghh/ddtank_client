package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.Role;
   import road7th.utils.DateUtils;
   
   public class LoginSelectListAnalyzer extends DataAnalyzer
   {
       
      
      public var list:Vector.<Role>;
      
      public var totalCount:int;
      
      public function LoginSelectListAnalyzer(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
      
      private function sortLastDate(param1:Role, param2:Role) : int{return 0;}
      
      private function sortLoginState(param1:Role, param2:Role) : int{return 0;}
   }
}
