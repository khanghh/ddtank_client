package vipIntegralShop.data
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   
   public class VipIntegralShopDataAnalyzer extends DataAnalyzer
   {
       
      
      private var _shopInfoVec:Vector.<VipIntegralShopInfo>;
      
      public function VipIntegralShopDataAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc6_:int = 0;
         var _loc2_:* = null;
         _shopInfoVec = new Vector.<VipIntegralShopInfo>();
         var _loc3_:XML = new XML(param1);
         var _loc5_:int = _loc3_.Item.length();
         var _loc4_:XMLList = _loc3_.Item;
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc2_ = new VipIntegralShopInfo();
            ObjectUtils.copyPorpertiesByXML(_loc2_,_loc4_[_loc6_]);
            _shopInfoVec.push(_loc2_);
            _loc6_++;
         }
         onAnalyzeComplete();
      }
      
      public function get shopInfoVec() : Vector.<VipIntegralShopInfo>
      {
         return _shopInfoVec;
      }
   }
}
