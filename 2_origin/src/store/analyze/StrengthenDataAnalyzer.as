package store.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import flash.utils.Dictionary;
   
   public class StrengthenDataAnalyzer extends DataAnalyzer
   {
       
      
      public var _strengthData:Vector.<Dictionary>;
      
      private var _xml:XML;
      
      public function StrengthenDataAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         _xml = new XML(param1);
         initData();
         var _loc5_:XMLList = _xml.Item;
         if(_xml.@value == "true")
         {
            _loc6_ = 0;
            while(_loc6_ < _loc5_.length())
            {
               _loc4_ = _loc5_[_loc6_].@TemplateID;
               _loc3_ = _loc5_[_loc6_].@StrengthenLevel;
               _loc2_ = _loc5_[_loc6_].@Data;
               _strengthData[_loc3_][_loc4_] = _loc2_;
               _loc6_++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _xml.@message;
            onAnalyzeError();
            onAnalyzeComplete();
         }
      }
      
      private function initData() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _strengthData = new Vector.<Dictionary>();
         _loc2_ = 0;
         while(_loc2_ <= 12)
         {
            _loc1_ = new Dictionary();
            _strengthData.push(_loc1_);
            _loc2_++;
         }
      }
   }
}
