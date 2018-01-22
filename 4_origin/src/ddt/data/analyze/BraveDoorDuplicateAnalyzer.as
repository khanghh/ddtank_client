package ddt.data.analyze
{
   import BraveDoor.data.BraveDoorDuplicateInfo;
   import BraveDoor.data.DuplicateInfo;
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   
   public class BraveDoorDuplicateAnalyzer extends DataAnalyzer
   {
       
      
      public var list:Vector.<BraveDoorDuplicateInfo>;
      
      private var _maps:XML;
      
      private var _xml:XML;
      
      public function BraveDoorDuplicateAnalyzer(param1:Function)
      {
         list = new Vector.<BraveDoorDuplicateInfo>();
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc2_:* = null;
         var _loc8_:* = null;
         var _loc4_:* = null;
         var _loc7_:int = 0;
         _xml = new XML(param1);
         var _loc6_:XMLList = _xml..map;
         var _loc5_:int = _loc6_.length();
         var _loc10_:int = 0;
         var _loc9_:* = _loc6_;
         for each(var _loc3_ in _loc6_)
         {
            _loc8_ = new BraveDoorDuplicateInfo();
            initMap(_loc8_,_loc3_);
            _loc2_ = _loc3_..item;
            _loc7_ = 0;
            while(_loc7_ < _loc2_.length())
            {
               _loc4_ = new DuplicateInfo();
               ObjectUtils.copyPorpertiesByXML(_loc4_,_loc2_[_loc7_]);
               _loc8_.addDuplicateInfo(_loc4_);
               _loc7_++;
            }
            list[_loc8_.page] = _loc8_;
         }
         onAnalyzeComplete();
      }
      
      protected function initMap(param1:BraveDoorDuplicateInfo, param2:XML) : void
      {
         ObjectUtils.copyPorpertiesByXML(param1,param2);
      }
   }
}
