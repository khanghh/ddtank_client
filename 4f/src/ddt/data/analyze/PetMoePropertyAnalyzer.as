package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import petsBag.data.PetMoePropertyInfo;
   
   public class PetMoePropertyAnalyzer extends DataAnalyzer
   {
       
      
      private var _list:Vector.<PetMoePropertyInfo>;
      
      public function PetMoePropertyAnalyzer(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
      
      public function get list() : Vector.<PetMoePropertyInfo>{return null;}
   }
}
