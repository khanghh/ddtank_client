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
      
      public function TimesAnalyzer(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
   }
}
