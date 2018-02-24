package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.email.EmailInfoOfSended;
   import flash.utils.describeType;
   
   public class SendedEmailAnalyze extends DataAnalyzer
   {
       
      
      private var _list:Array;
      
      public function SendedEmailAnalyze(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
      
      public function get list() : Array{return null;}
   }
}
