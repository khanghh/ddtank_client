package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.Base64;
   import flash.utils.ByteArray;
   import road7th.comm.PackageIn;
   
   public class FightReportAnalyze extends DataAnalyzer
   {
       
      
      private var _pkgVec:Vector.<PackageIn>;
      
      public function FightReportAnalyze(onCompleteCall:Function)
      {
         _pkgVec = new Vector.<PackageIn>();
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var i:int = 0;
         var byte:* = null;
         var pkg:* = null;
         var xml:XML = XML(data);
         var length:int = xml.Item.length();
         for(i = 0; i < length; )
         {
            byte = Base64.decodeToByteArray(xml.Item[i].@Buffer);
            pkg = new PackageIn();
            pkg.loadFightByteInfo(xml.Item[i].@Parameter1,xml.Item[i].@Parameter2,xml.Item[i].@Length,byte,0);
            _pkgVec.push(pkg);
            i++;
         }
         onAnalyzeComplete();
      }
      
      public function get pkgVec() : Vector.<PackageIn>
      {
         return _pkgVec;
      }
   }
}
