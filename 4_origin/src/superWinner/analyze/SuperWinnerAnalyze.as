package superWinner.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import superWinner.data.SuperWinnerAwardsMode;
   
   public class SuperWinnerAnalyze extends DataAnalyzer
   {
       
      
      private var _awardsArr:Vector.<Object>;
      
      public function SuperWinnerAnalyze(onCompleteCall:Function)
      {
         _awardsArr = new Vector.<Object>();
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var ii:int = 0;
         var vec:* = undefined;
         var i:int = 0;
         var tpXml:* = null;
         var index:* = 0;
         var mode:* = null;
         var xml:XML = new XML(data);
         var xmllist:XMLList = xml..Item;
         for(ii = 0; ii < 6; )
         {
            vec = new Vector.<SuperWinnerAwardsMode>();
            _awardsArr.push(vec);
            ii++;
         }
         for(i = 0; i < xmllist.length(); )
         {
            tpXml = xmllist[i];
            index = uint(tpXml.@rank - 1);
            mode = new SuperWinnerAwardsMode();
            mode.type = tpXml.@rank;
            mode.goodId = tpXml.@template;
            mode.count = tpXml.@count;
            (_awardsArr[5 - index] as Vector.<SuperWinnerAwardsMode>).push(mode);
            i++;
         }
         onAnalyzeComplete();
      }
      
      public function get awards() : Vector.<Object>
      {
         return _awardsArr;
      }
   }
}
