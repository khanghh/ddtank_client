package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.Base64;
   import flash.utils.ByteArray;
   import road7th.comm.PackageIn;
   
   public class FightReportAnalyze extends DataAnalyzer
   {
       
      
      private var _pkgVec:Vector.<PackageIn>;
      
      public function FightReportAnalyze(param1:Function)
      {
         _pkgVec = new Vector.<PackageIn>();
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc6_:int = 0;
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc5_:XML = XML(param1);
         var _loc3_:int = _loc5_.Item.length();
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc2_ = Base64.decodeToByteArray(_loc5_.Item[_loc6_].@Buffer);
            _loc4_ = new PackageIn();
            _loc4_.loadFightByteInfo(_loc5_.Item[_loc6_].@Parameter1,_loc5_.Item[_loc6_].@Parameter2,_loc5_.Item[_loc6_].@Length,_loc2_,0);
            _pkgVec.push(_loc4_);
            _loc6_++;
         }
         onAnalyzeComplete();
      }
      
      public function get pkgVec() : Vector.<PackageIn>
      {
         return _pkgVec;
      }
   }
}
