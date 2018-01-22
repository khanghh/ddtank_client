package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import petsBag.data.PetFightPropertyData;
   
   public class PetsEvolutionDataAnalyzer extends DataAnalyzer
   {
       
      
      private var _list:Vector.<PetFightPropertyData>;
      
      public function PetsEvolutionDataAnalyzer(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
      
      public function get list() : Vector.<PetFightPropertyData>{return null;}
   }
}
