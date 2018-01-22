package homeTemple.data
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import flash.utils.Dictionary;
   import homeTemple.HomeTempleController;
   
   public class HomeTempleDataAnalyzer extends DataAnalyzer
   {
       
      
      public var list:Dictionary;
      
      private var _xml:XML;
      
      public function HomeTempleDataAnalyzer(param1:Function)
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
            list = new Dictionary();
            _loc2_ = _xml..item;
            _loc4_ = 0;
            while(_loc4_ < _loc2_.length())
            {
               _loc3_ = new HomeTempleModel();
               ObjectUtils.copyPorpertiesByXML(_loc3_,_loc2_[_loc4_]);
               list[_loc3_.Level] = _loc3_;
               _loc4_++;
            }
            HomeTempleController.MAXLEVEL = _loc2_.length() - 1;
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
