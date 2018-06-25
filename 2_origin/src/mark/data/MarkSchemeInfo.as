package mark.data
{
   public class MarkSchemeInfo
   {
       
      
      private var _schemeID:int;
      
      private var _schemeData:String;
      
      public function MarkSchemeInfo(id:int, data:String)
      {
         super();
         _schemeID = id;
         _schemeData = data;
      }
      
      public function get schemeData() : String
      {
         return _schemeData;
      }
      
      public function get chips() : Array
      {
         var arr:* = null;
         var i:int = 0;
         var allChips:Array = [];
         if(_schemeData && _schemeData.length > 0)
         {
            arr = _schemeData.split(",");
            for(i = 0; i < arr.length; )
            {
               allChips.push(int(arr[i]));
               i++;
            }
         }
         return allChips;
      }
   }
}
