package farm.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import farm.modelx.SuperPetFoodPriceInfo;
   
   public class SuperPetFoodPriceAnalyzer extends DataAnalyzer
   {
      
      public static const Path:String = "PetExpItemPrice.xml";
       
      
      public var list:Vector.<SuperPetFoodPriceInfo>;
      
      public function SuperPetFoodPriceAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc2_:int = 0;
         var _loc6_:* = null;
         var _loc5_:XML = XML(param1);
         var _loc3_:XMLList = _loc5_..Item;
         list = new Vector.<SuperPetFoodPriceInfo>();
         var _loc8_:int = 0;
         var _loc7_:* = _loc3_;
         for each(var _loc4_ in _loc3_)
         {
            _loc6_ = new SuperPetFoodPriceInfo();
            ObjectUtils.copyPorpertiesByXML(_loc6_,_loc4_);
            list.push(_loc6_);
         }
         onAnalyzeComplete();
      }
   }
}
