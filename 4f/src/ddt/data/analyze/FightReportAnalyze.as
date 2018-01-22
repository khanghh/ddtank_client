package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.Base64;
   import flash.utils.ByteArray;
   import road7th.comm.PackageIn;
   
   public class FightReportAnalyze extends DataAnalyzer
   {
       
      
      private var _pkgVec:Vector.<PackageIn>;
      
      public function FightReportAnalyze(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
      
      public function get pkgVec() : Vector.<PackageIn>{return null;}
   }
}
