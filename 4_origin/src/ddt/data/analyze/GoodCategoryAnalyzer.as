package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.CateCoryInfo;
   
   public class GoodCategoryAnalyzer extends DataAnalyzer
   {
       
      
      public var list:Vector.<CateCoryInfo>;
      
      private var _xml:XML;
      
      public function GoodCategoryAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc2_:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = null;
         _xml = new XML(param1);
         if(_xml.@value == "true")
         {
            list = new Vector.<CateCoryInfo>();
            _loc2_ = _xml..Item;
            _loc4_ = 0;
            while(_loc4_ < _loc2_.length())
            {
               _loc3_ = new CateCoryInfo();
               ObjectUtils.copyPorpertiesByXML(_loc3_,_loc2_[_loc4_]);
               list.push(_loc3_);
               _loc4_++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _xml.@message;
            onAnalyzeError();
         }
      }
   }
}
