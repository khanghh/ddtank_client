package ddt.data.analyze{   import com.pickgliss.loader.DataAnalyzer;      public class LoginRenameAnalyzer extends DataAnalyzer   {                   private var _result:XML;            public var tempPassword:String;            public function LoginRenameAnalyzer(onCompleteCall:Function) { super(null); }
            override public function analyze(data:*) : void { }
            public function get result() : XML { return null; }
   }}