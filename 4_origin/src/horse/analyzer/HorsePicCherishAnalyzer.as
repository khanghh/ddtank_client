package horse.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import horse.data.HorsePicCherishVo;
   
   public class HorsePicCherishAnalyzer extends DataAnalyzer
   {
       
      
      private var _horsePicCherishList:Vector.<HorsePicCherishVo>;
      
      public function HorsePicCherishAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc2_:* = null;
         var _loc3_:XML = new XML(param1);
         _horsePicCherishList = new Vector.<HorsePicCherishVo>();
         if(_loc3_.@value == "true")
         {
            _loc4_ = _loc3_..item;
            _loc5_ = 0;
            while(_loc5_ < _loc4_.length())
            {
               _loc2_ = new HorsePicCherishVo();
               ObjectUtils.copyPorpertiesByXML(_loc2_,_loc4_[_loc5_]);
               _horsePicCherishList.push(_loc2_);
               _loc5_++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _loc3_.@message;
            onAnalyzeError();
            onAnalyzeError();
         }
      }
      
      private function compareFunc(param1:HorsePicCherishVo, param2:HorsePicCherishVo) : int
      {
         if(param1.ID > param2.ID)
         {
            return 1;
         }
         if(param1.ID < param2.ID)
         {
            return -1;
         }
         return 0;
      }
      
      public function get horsePicCherishList() : Vector.<HorsePicCherishVo>
      {
         return _horsePicCherishList;
      }
   }
}
