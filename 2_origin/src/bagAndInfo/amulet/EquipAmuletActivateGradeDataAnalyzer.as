package bagAndInfo.amulet
{
   import bagAndInfo.amulet.vo.EquipAmuletActivateGradeVo;
   import com.pickgliss.loader.DataAnalyzer;
   import road7th.data.DictionaryData;
   
   public class EquipAmuletActivateGradeDataAnalyzer extends DataAnalyzer
   {
       
      
      private var _data:DictionaryData;
      
      public function EquipAmuletActivateGradeDataAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc2_:* = null;
         _data = new DictionaryData();
         var _loc3_:XML = new XML(param1);
         if(_loc3_.@value == "true")
         {
            _loc4_ = _loc3_..Item;
            _loc5_ = 0;
            while(_loc5_ < _loc4_.length())
            {
               _loc2_ = new EquipAmuletActivateGradeVo();
               _loc2_.wahsGrade = _loc4_[_loc5_].@WahsLevel;
               _loc2_.WahsTimes = _loc4_[_loc5_].@WahsTimes;
               _loc2_.minValue = _loc4_[_loc5_].@Minvalue;
               _loc2_.maxValue = _loc4_[_loc5_].@Maxvalue;
               _data.add(_loc2_.wahsGrade,_loc2_);
               _loc5_++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _loc3_.@message;
            onAnalyzeError();
         }
         _data = null;
      }
      
      public function get data() : DictionaryData
      {
         return _data;
      }
   }
}
