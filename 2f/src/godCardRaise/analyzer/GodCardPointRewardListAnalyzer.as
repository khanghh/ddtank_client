package godCardRaise.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import godCardRaise.info.GodCardPointRewardListInfo;
   
   public class GodCardPointRewardListAnalyzer extends DataAnalyzer
   {
       
      
      private var _list:Vector.<GodCardPointRewardListInfo>;
      
      public function GodCardPointRewardListAnalyzer(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
      
      public function get list() : Vector.<GodCardPointRewardListInfo>{return null;}
   }
}
