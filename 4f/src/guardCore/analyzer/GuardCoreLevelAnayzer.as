package guardCore.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import guardCore.data.GuardCoreLevelInfo;
   
   public class GuardCoreLevelAnayzer extends DataAnalyzer
   {
       
      
      private var _list:Vector.<GuardCoreLevelInfo>;
      
      public function GuardCoreLevelAnayzer(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
      
      public function get list() : Vector.<GuardCoreLevelInfo>{return null;}
   }
}
