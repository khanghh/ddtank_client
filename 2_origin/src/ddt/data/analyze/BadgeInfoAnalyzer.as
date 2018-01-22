package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.data.BadgeInfo;
   import flash.utils.Dictionary;
   
   public class BadgeInfoAnalyzer extends DataAnalyzer
   {
       
      
      public var list:Dictionary;
      
      public function BadgeInfoAnalyzer(param1:Function)
      {
         list = new Dictionary();
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = null;
         var _loc2_:XML = new XML(param1);
         var _loc4_:XMLList = _loc2_..item;
         var _loc3_:int = _loc4_.length();
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc5_ = new BadgeInfo();
            ObjectUtils.copyPorpertiesByXML(_loc5_,_loc4_[_loc6_]);
            list[_loc5_.BadgeID] = _loc5_;
            _loc6_++;
         }
         onAnalyzeComplete();
      }
   }
}
