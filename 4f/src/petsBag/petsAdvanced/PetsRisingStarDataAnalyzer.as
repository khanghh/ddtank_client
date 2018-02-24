package petsBag.petsAdvanced
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import petsBag.data.PetStarExpData;
   
   public class PetsRisingStarDataAnalyzer extends DataAnalyzer
   {
       
      
      private var _list:Vector.<PetStarExpData>;
      
      public function PetsRisingStarDataAnalyzer(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
      
      public function get list() : Vector.<PetStarExpData>{return null;}
   }
}
