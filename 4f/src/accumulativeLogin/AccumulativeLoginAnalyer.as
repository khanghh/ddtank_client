package accumulativeLogin
{
   import accumulativeLogin.data.AccumulativeLoginRewardData;
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import flash.utils.Dictionary;
   
   public class AccumulativeLoginAnalyer extends DataAnalyzer
   {
       
      
      private var _accumulativeloginDataDic:Dictionary;
      
      public function AccumulativeLoginAnalyer(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
      
      public function get accumulativeloginDataDic() : Dictionary{return null;}
   }
}
