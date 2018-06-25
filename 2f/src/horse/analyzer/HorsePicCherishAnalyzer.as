package horse.analyzer{   import com.pickgliss.loader.DataAnalyzer;   import com.pickgliss.utils.ObjectUtils;   import horse.data.HorsePicCherishVo;      public class HorsePicCherishAnalyzer extends DataAnalyzer   {                   private var _horsePicCherishList:Vector.<HorsePicCherishVo>;            public function HorsePicCherishAnalyzer(onCompleteCall:Function) { super(null); }
            override public function analyze(data:*) : void { }
            private function compareFunc(tmpA:HorsePicCherishVo, tmpB:HorsePicCherishVo) : int { return 0; }
            public function get horsePicCherishList() : Vector.<HorsePicCherishVo> { return null; }
   }}