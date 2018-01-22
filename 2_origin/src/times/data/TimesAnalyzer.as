package times.data
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   
   public class TimesAnalyzer extends DataAnalyzer
   {
       
      
      public var webPath:String;
      
      public var edition:int;
      
      public var editor:String;
      
      public var nextDate:String;
      
      public var smallPicInfos:Vector.<TimesPicInfo>;
      
      public var bigPicInfos:Vector.<TimesPicInfo>;
      
      public var contentInfos:Array;
      
      public function TimesAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc4_:* = null;
         var _loc7_:* = null;
         var _loc8_:int = 0;
         var _loc2_:* = null;
         var _loc5_:int = 0;
         var _loc6_:* = null;
         smallPicInfos = new Vector.<TimesPicInfo>();
         bigPicInfos = new Vector.<TimesPicInfo>();
         var _loc3_:XML = new XML(param1);
         if(_loc3_.@value == "true")
         {
            webPath = _loc3_.@webPath;
            edition = _loc3_.@edition;
            editor = _loc3_.@editor;
            nextDate = _loc3_.@nextDate;
            var _loc9_:* = _loc3_..item;
            var _loc10_:int = 0;
            var _loc12_:* = new XMLList("");
            _loc4_ = _loc3_..item.(@type == "small");
            _loc8_ = 0;
            while(_loc8_ < _loc4_.length())
            {
               _loc7_ = new TimesPicInfo();
               ObjectUtils.copyPorpertiesByXML(_loc7_,_loc4_[_loc8_]);
               smallPicInfos.push(_loc7_);
               _loc8_++;
            }
            var _loc13_:* = _loc3_..item;
            var _loc14_:int = 0;
            _loc9_ = new XMLList("");
            _loc4_ = _loc3_..item.(@type == "big");
            _loc8_ = 0;
            while(_loc8_ < _loc4_.length())
            {
               _loc2_ = new TimesPicInfo();
               ObjectUtils.copyPorpertiesByXML(_loc2_,_loc4_[_loc8_]);
               bigPicInfos.push(_loc2_);
               _loc8_++;
            }
            contentInfos = [];
            _loc5_ = 0;
            while(_loc5_ < 4)
            {
               var _loc15_:* = _loc3_..item;
               var _loc16_:int = 0;
               _loc12_ = new XMLList("");
               _loc4_ = _loc3_..item.(@type == "category" + String(_loc5_));
               contentInfos.push(new Vector.<TimesPicInfo>());
               _loc8_ = 0;
               while(_loc8_ < _loc4_.length())
               {
                  _loc6_ = new TimesPicInfo();
                  ObjectUtils.copyPorpertiesByXML(_loc6_,_loc4_[_loc8_]);
                  _loc6_.category = _loc5_;
                  _loc6_.page = _loc8_;
                  contentInfos[_loc5_].push(_loc6_);
                  _loc8_++;
               }
               _loc5_++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _loc3_.@message;
            onAnalyzeError();
            onAnalyzeComplete();
         }
      }
   }
}
