package totem.data
{
   import com.pickgliss.loader.DataAnalyzer;
   
   public class HonorUpDataAnalyz extends DataAnalyzer
   {
       
      
      private var _dataList:Array;
      
      public function HonorUpDataAnalyz(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var info:* = null;
         var xml:XML = new XML(data);
         _dataList = [];
         if(xml.@value == "true")
         {
            xmllist = xml..item;
            for(i = 0; i < xmllist.length(); )
            {
               info = new HonorUpDataVo();
               info.index = xmllist[i].@ID;
               info.honor = xmllist[i].@AddHonor;
               info.money = xmllist[i].@NeedMoney;
               _dataList.push(info);
               i++;
            }
            _dataList.sortOn("index",16);
            onAnalyzeComplete();
         }
         else
         {
            message = xml.@message;
            onAnalyzeError();
            onAnalyzeError();
         }
      }
      
      public function get dataList() : Array
      {
         return _dataList;
      }
   }
}
