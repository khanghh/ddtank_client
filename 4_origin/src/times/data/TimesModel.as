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
         var i:int = 0;
         var j:int = 0;
         var k:int = 0;
         var l:int = 0;
         for(i = 0; i < smallPicInfos.length; )
         {
            smallPicInfos[i] = null;
            i++;
         }
         smallPicInfos = null;
         for(j = 0; j < bigPicInfos.length; )
         {
            bigPicInfos[j] = null;
            j++;
         }
         bigPicInfos = null;
         for(k = 0; k < contentInfos.length; )
         {
            for(l = 0; l < contentInfos[k].length; )
            {
               contentInfos[k][l] = null;
               l++;
            }
            k++;
         }
         contentInfos = null;
         ObjectUtils.disposeObject(_thumbnailQueue);
         _thumbnailQueue = null;
      }
   }
}
