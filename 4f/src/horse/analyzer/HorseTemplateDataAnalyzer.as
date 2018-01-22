package horse.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import horse.data.HorseTemplateVo;
   
   public class HorseTemplateDataAnalyzer extends DataAnalyzer
   {
       
      
      private var _horseTemplateList:Vector.<HorseTemplateVo>;
      
      public function HorseTemplateDataAnalyzer(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
      
      private function compareFunc(param1:HorseTemplateVo, param2:HorseTemplateVo) : int{return 0;}
      
      public function get horseTemplateList() : Vector.<HorseTemplateVo>{return null;}
   }
}
