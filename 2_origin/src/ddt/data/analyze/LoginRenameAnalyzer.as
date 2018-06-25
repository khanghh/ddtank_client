package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   
   public class LoginRenameAnalyzer extends DataAnalyzer
   {
       
      
      private var _result:XML;
      
      public var tempPassword:String;
      
      public function LoginRenameAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         _result = new XML(data);
         onAnalyzeComplete();
      }
      
      public function get result() : XML
      {
         return _result;
      }
   }
}
