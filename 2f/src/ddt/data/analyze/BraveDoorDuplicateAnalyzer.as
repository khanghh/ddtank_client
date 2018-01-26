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
      
      public function BraveDoorDuplicateAnalyzer(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
      
      protected function initMap(param1:BraveDoorDuplicateInfo, param2:XML) : void{}
   }
}
