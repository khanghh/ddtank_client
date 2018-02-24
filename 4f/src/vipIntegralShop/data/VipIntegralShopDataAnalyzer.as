package vipIntegralShop.data
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   
   public class VipIntegralShopDataAnalyzer extends DataAnalyzer
   {
       
      
      private var _shopInfoVec:Vector.<VipIntegralShopInfo>;
      
      public function VipIntegralShopDataAnalyzer(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
      
      public function get shopInfoVec() : Vector.<VipIntegralShopInfo>{return null;}
   }
}
