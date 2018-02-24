package farm.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import farm.modelx.SuperPetFoodPriceInfo;
   
   public class SuperPetFoodPriceAnalyzer extends DataAnalyzer
   {
      
      public static const Path:String = "PetExpItemPrice.xml";
       
      
      public var list:Vector.<SuperPetFoodPriceInfo>;
      
      public function SuperPetFoodPriceAnalyzer(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
   }
}
