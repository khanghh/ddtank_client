package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.GoodsExchangeInfo;
   
   public class ActiveExchangeAnalyzer extends DataAnalyzer
   {
       
      
      private var _list:Array;
      
      private var _xml:XML;
      
      public function ActiveExchangeAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         _xml = new XML(param1);
         _list = [];
         var _loc2_:XMLList = _xml..Item;
         if(_xml.@value == "true")
         {
            _loc4_ = 0;
            while(_loc4_ < _loc2_.length())
            {
               _loc3_ = new GoodsExchangeInfo();
               ObjectUtils.copyPorpertiesByXML(_loc3_,_loc2_[_loc4_]);
               _list.push(_loc3_);
               _loc4_++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _xml.@message;
            onAnalyzeError();
            onAnalyzeComplete();
         }
      }
      
      public function get list() : Array
      {
         return _list.slice(0);
      }
   }
}
