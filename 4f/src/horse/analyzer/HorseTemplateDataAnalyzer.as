package horse.analyzer{   import com.pickgliss.loader.DataAnalyzer;   import com.pickgliss.utils.ObjectUtils;   import horse.data.HorseTemplateVo;      public class HorseTemplateDataAnalyzer extends DataAnalyzer   {                   private var _horseTemplateList:Vector.<HorseTemplateVo>;            public function HorseTemplateDataAnalyzer(onCompleteCall:Function) { super(null); }
            override public function analyze(data:*) : void { }
            private function compareFunc(tmpA:HorseTemplateVo, tmpB:HorseTemplateVo) : int { return 0; }
            public function get horseTemplateList() : Vector.<HorseTemplateVo> { return null; }
   }}