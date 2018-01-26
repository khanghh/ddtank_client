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
      
      public function TimesModel(){super();}
      
      private function init() : void{}
      
      public function dispose() : void{}
   }
}
