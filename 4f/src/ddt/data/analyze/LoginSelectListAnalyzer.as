package ddt.data.analyze{   import com.pickgliss.loader.DataAnalyzer;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.Role;   import road7th.utils.DateUtils;      public class LoginSelectListAnalyzer extends DataAnalyzer   {                   public var list:Vector.<Role>;            public var totalCount:int;            public function LoginSelectListAnalyzer(onCompleteCall:Function) { super(null); }
            override public function analyze(data:*) : void { }
            private function sortLastDate(a:Role, b:Role) : int { return 0; }
            private function sortLoginState(a:Role, b:Role) : int { return 0; }
   }}