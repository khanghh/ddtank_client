package bagAndInfo.ddtKingGrade
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import road7th.data.DictionaryData;
   
   public class DDTKingGradeAnalyzer extends DataAnalyzer
   {
       
      
      private var _data:DictionaryData;
      
      public function DDTKingGradeAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc3_:* = null;
         var _loc5_:* = null;
         var _loc4_:int = 0;
         var _loc2_:XML = new XML(param1);
         if(_loc2_.@value == "true")
         {
            _data = new DictionaryData();
            _loc3_ = _loc2_..Item;
            _loc5_ = new DDTKingGradeInfo();
            _data.add(_loc5_.Level,_loc5_);
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length())
            {
               _loc5_ = new DDTKingGradeInfo();
               ObjectUtils.copyPorpertiesByXML(_loc5_,_loc3_[_loc4_]);
               _data.add(_loc5_.Level,_loc5_);
               _loc4_++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _loc2_.@message;
            onAnalyzeError();
            onAnalyzeError();
         }
      }
      
      public function get data() : DictionaryData
      {
         return _data;
      }
   }
}
