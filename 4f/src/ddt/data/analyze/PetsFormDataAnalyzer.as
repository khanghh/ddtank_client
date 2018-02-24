package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import petsBag.data.PetsFormData;
   
   public class PetsFormDataAnalyzer extends DataAnalyzer
   {
       
      
      private var _list:Vector.<PetsFormData>;
      
      public function PetsFormDataAnalyzer(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
      
      public function get list() : Vector.<PetsFormData>{return null;}
   }
}
