package guardCore.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import guardCore.data.GuardCoreInfo;
   
   public class GuardCoreAnalyzer extends DataAnalyzer
   {
       
      
      private var _list:Vector.<GuardCoreInfo>;
      
      public function GuardCoreAnalyzer(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
      
      public function get list() : Vector.<GuardCoreInfo>{return null;}
   }
}
