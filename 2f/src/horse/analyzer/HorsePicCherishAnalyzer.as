package horse.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import horse.data.HorsePicCherishVo;
   
   public class HorsePicCherishAnalyzer extends DataAnalyzer
   {
       
      
      private var _horsePicCherishList:Vector.<HorsePicCherishVo>;
      
      public function HorsePicCherishAnalyzer(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
      
      private function compareFunc(param1:HorsePicCherishVo, param2:HorsePicCherishVo) : int{return 0;}
      
      public function get horsePicCherishList() : Vector.<HorsePicCherishVo>{return null;}
   }
}
