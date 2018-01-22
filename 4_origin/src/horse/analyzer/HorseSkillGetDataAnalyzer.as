package horse.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import horse.data.HorseSkillGetVo;
   import road7th.data.DictionaryData;
   
   public class HorseSkillGetDataAnalyzer extends DataAnalyzer
   {
       
      
      private var _horseSkillGetList:DictionaryData;
      
      private var _horseSkillGetIdList:DictionaryData;
      
      public function HorseSkillGetDataAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc5_:* = null;
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:* = null;
         var _loc4_:XML = new XML(param1);
         _horseSkillGetList = new DictionaryData();
         _horseSkillGetIdList = new DictionaryData();
         if(_loc4_.@value == "true")
         {
            _loc5_ = _loc4_..item;
            _loc7_ = 0;
            while(_loc7_ < _loc5_.length())
            {
               _loc6_ = _loc5_[_loc7_].@Type;
               if(!_horseSkillGetList[_loc6_])
               {
                  _horseSkillGetList.add(_loc6_,new Vector.<HorseSkillGetVo>());
               }
               _loc2_ = new HorseSkillGetVo();
               ObjectUtils.copyPorpertiesByXML(_loc2_,_loc5_[_loc7_]);
               _horseSkillGetList[_loc6_].push(_loc2_);
               _horseSkillGetIdList.add(_loc2_.SkillID,_loc2_);
               _loc7_++;
            }
            var _loc9_:int = 0;
            var _loc8_:* = _horseSkillGetList;
            for each(var _loc3_ in _horseSkillGetList)
            {
               _loc3_.sort(compareFunc);
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _loc4_.@message;
            onAnalyzeError();
            onAnalyzeError();
         }
      }
      
      private function compareFunc(param1:HorseSkillGetVo, param2:HorseSkillGetVo) : int
      {
         if(param1.Level > param2.Level)
         {
            return 1;
         }
         if(param1.Level < param2.Level)
         {
            return -1;
         }
         return 0;
      }
      
      public function get horseSkillGetList() : DictionaryData
      {
         return _horseSkillGetList;
      }
      
      public function get horseSkillGetIdList() : DictionaryData
      {
         return _horseSkillGetIdList;
      }
   }
}
