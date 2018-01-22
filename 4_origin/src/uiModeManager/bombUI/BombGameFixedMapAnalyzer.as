package uiModeManager.bombUI
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import road7th.data.DictionaryData;
   import uiModeManager.bombUI.model.bomb.FixedMapData;
   
   public class BombGameFixedMapAnalyzer extends DataAnalyzer
   {
       
      
      private var _data:DictionaryData;
      
      public function BombGameFixedMapAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc3_:XML = new XML(param1);
         if(_loc3_.@value == "true")
         {
            _data = new DictionaryData();
            _loc4_ = _loc3_..item;
            _loc5_ = 0;
            while(_loc5_ < _loc4_.length())
            {
               _loc2_ = new FixedMapData();
               ObjectUtils.copyPorpertiesByXML(_loc2_,_loc4_[_loc5_]);
               _data.add(_loc2_.Level,_loc2_);
               _loc5_++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _loc3_.@message;
            onAnalyzeError();
         }
      }
      
      public function get data() : DictionaryData
      {
         return _data;
      }
   }
}
