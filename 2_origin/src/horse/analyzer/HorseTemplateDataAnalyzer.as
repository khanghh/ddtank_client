package horse.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import horse.data.HorseTemplateVo;
   
   public class HorseTemplateDataAnalyzer extends DataAnalyzer
   {
       
      
      private var _horseTemplateList:Vector.<HorseTemplateVo>;
      
      public function HorseTemplateDataAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc2_:* = null;
         var _loc3_:XML = new XML(param1);
         _horseTemplateList = new Vector.<HorseTemplateVo>();
         if(_loc3_.@value == "true")
         {
            _loc4_ = _loc3_..item;
            _loc5_ = 0;
            while(_loc5_ < _loc4_.length())
            {
               _loc2_ = new HorseTemplateVo();
               ObjectUtils.copyPorpertiesByXML(_loc2_,_loc4_[_loc5_]);
               _horseTemplateList.push(_loc2_);
               _loc5_++;
            }
            _horseTemplateList.sort(compareFunc);
            onAnalyzeComplete();
         }
         else
         {
            message = _loc3_.@message;
            onAnalyzeError();
            onAnalyzeError();
         }
      }
      
      private function compareFunc(param1:HorseTemplateVo, param2:HorseTemplateVo) : int
      {
         if(param1.Grade > param2.Grade)
         {
            return 1;
         }
         if(param1.Grade < param2.Grade)
         {
            return -1;
         }
         return 0;
      }
      
      public function get horseTemplateList() : Vector.<HorseTemplateVo>
      {
         return _horseTemplateList;
      }
   }
}
