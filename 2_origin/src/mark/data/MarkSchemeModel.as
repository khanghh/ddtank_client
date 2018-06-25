package mark.data
{
   import flash.events.EventDispatcher;
   import road7th.data.DictionaryData;
   
   public class MarkSchemeModel extends EventDispatcher
   {
       
      
      private var _curScheme:int;
      
      private var _schemCount:int;
      
      private var _schemeData:DictionaryData;
      
      public function MarkSchemeModel()
      {
         super();
         _schemeData = new DictionaryData();
      }
      
      public function set schemCount(value:int) : void
      {
         _schemCount = value;
      }
      
      public function updateScheme(schemeID:int, info:MarkSchemeInfo) : void
      {
         if(_schemeData)
         {
            if(_schemeData.hasKey(schemeID))
            {
               _schemeData[schemeID] = info;
            }
            else
            {
               _schemeData.add(schemeID,info);
            }
         }
      }
      
      public function getSchemeInfo(schemeID:int) : MarkSchemeInfo
      {
         if(_schemeData && _schemeData.hasKey(schemeID))
         {
            return _schemeData[schemeID];
         }
         return null;
      }
      
      public function get getAllSchemeData() : String
      {
         var temStr:String = "";
         var _loc4_:int = 0;
         var _loc3_:* = _schemeData;
         for each(var info in _schemeData)
         {
            temStr = temStr + (info.schemeData + ",");
         }
         return "," + temStr;
      }
      
      public function get schemCount() : int
      {
         return _schemCount;
      }
      
      public function get curScheme() : int
      {
         return _curScheme;
      }
      
      public function clearScheme() : void
      {
         if(_schemeData)
         {
            _schemeData.clear();
         }
      }
      
      public function set curScheme(value:int) : void
      {
         if(_curScheme == value)
         {
            return;
         }
         _curScheme = value;
      }
   }
}
