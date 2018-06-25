package farm.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import farm.modelx.SuperPetFoodPriceInfo;
   
   public class SuperPetFoodPriceAnalyzer extends DataAnalyzer
   {
      
      public static const Path:String = "PetExpItemPrice.xml";
       
      
      public var list:Vector.<SuperPetFoodPriceInfo>;
      
      public function SuperPetFoodPriceAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var tmpFoodID:int = 0;
         var info:* = null;
         var xml:XML = XML(data);
         var items:XMLList = xml..Item;
         list = new Vector.<SuperPetFoodPriceInfo>();
         var _loc8_:int = 0;
         var _loc7_:* = items;
         for each(var item in items)
         {
            info = new SuperPetFoodPriceInfo();
            ObjectUtils.copyPorpertiesByXML(info,item);
            list.push(info);
         }
         onAnalyzeComplete();
      }
   }
}
