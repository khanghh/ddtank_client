package times.data
{
   import com.pickgliss.loader.LoaderQueue;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   
   public class TimesModel implements Disposeable
   {
      
      public static const SMALL_PIC_WIDTH:uint = 250;
      
      public static const SMALL_PIC_HEIGHT:uint = 140;
       
      
      public var smallPicInfos:Vector.<TimesPicInfo>;
      
      public var bigPicInfos:Vector.<TimesPicInfo>;
      
      public var contentInfos:Array;
      
      public var webPath:String;
      
      public var edition:int;
      
      public var editor:String;
      
      public var nextDate:String;
      
      public var isDailyGotten:Boolean;
      
      public var isShowEgg:Boolean;
      
      public var smallPicWidth:int = 250;
      
      public var smallPicHeight:int = 140;
      
      private var _thumbnailQueue:LoaderQueue;
      
      private var _thumbnailLoaders:Array;
      
      public function TimesModel()
      {
         super();
      }
      
      private function init() : void
      {
         smallPicInfos = new Vector.<TimesPicInfo>();
         bigPicInfos = new Vector.<TimesPicInfo>();
      }
      
      public function dispose() : void
      {
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < smallPicInfos.length)
         {
            smallPicInfos[_loc4_] = null;
            _loc4_++;
         }
         smallPicInfos = null;
         _loc2_ = 0;
         while(_loc2_ < bigPicInfos.length)
         {
            bigPicInfos[_loc2_] = null;
            _loc2_++;
         }
         bigPicInfos = null;
         _loc3_ = 0;
         while(_loc3_ < contentInfos.length)
         {
            _loc1_ = 0;
            while(_loc1_ < contentInfos[_loc3_].length)
            {
               contentInfos[_loc3_][_loc1_] = null;
               _loc1_++;
            }
            _loc3_++;
         }
         contentInfos = null;
         ObjectUtils.disposeObject(_thumbnailQueue);
         _thumbnailQueue = null;
      }
   }
}
