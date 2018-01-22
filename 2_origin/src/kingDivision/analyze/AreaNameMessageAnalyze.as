package kingDivision.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import flash.utils.Dictionary;
   import kingDivision.data.KingDivisionAreaNameMessageInfo;
   
   public class AreaNameMessageAnalyze extends DataAnalyzer
   {
       
      
      public var _listDic:Dictionary;
      
      public function AreaNameMessageAnalyze(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc6_:* = null;
         var _loc2_:* = null;
         var _loc7_:int = 0;
         var _loc4_:* = null;
         var _loc5_:XML = new XML(param1);
         if(_loc5_.@value == "true")
         {
            _loc6_ = _loc5_..Info;
            _listDic = new Dictionary();
            _loc2_ = [];
            _loc7_ = 0;
            while(_loc7_ < _loc6_.length())
            {
               _loc4_ = new KingDivisionAreaNameMessageInfo();
               ObjectUtils.copyPorpertiesByXML(_loc4_,_loc6_[_loc7_]);
               _loc2_.push(_loc4_);
               _loc7_++;
            }
            var _loc9_:int = 0;
            var _loc8_:* = _loc2_;
            for each(var _loc3_ in _loc2_)
            {
               if(!_listDic[_loc3_.AreaID])
               {
                  _listDic[_loc3_.AreaID] = [];
               }
               _listDic[_loc3_.AreaID].push(_loc3_.AreaName);
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _loc5_.@message;
            onAnalyzeError();
            onAnalyzeComplete();
         }
      }
      
      public function get kingDivisionAreaNameDataDic() : Dictionary
      {
         return _listDic;
      }
   }
}
