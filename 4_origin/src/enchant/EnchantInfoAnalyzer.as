package enchant
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import enchant.data.EnchantInfo;
   
   public class EnchantInfoAnalyzer extends DataAnalyzer
   {
       
      
      public var list:Vector.<EnchantInfo>;
      
      public function EnchantInfoAnalyzer(param1:Function)
      {
         list = new Vector.<EnchantInfo>();
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc2_:* = null;
         var _loc5_:XML = XML(param1);
         var _loc3_:XMLList = _loc5_.Item;
         var _loc7_:int = 0;
         var _loc6_:* = _loc3_;
         for each(var _loc4_ in _loc3_)
         {
            _loc2_ = new EnchantInfo();
            ObjectUtils.copyPorpertiesByXML(_loc2_,_loc4_);
            list.push(_loc2_);
         }
         onAnalyzeComplete();
      }
   }
}
