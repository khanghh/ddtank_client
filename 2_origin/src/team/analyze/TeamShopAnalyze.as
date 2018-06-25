package team.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import road7th.data.DictionaryData;
   import team.model.TeamShopInfo;
   
   public class TeamShopAnalyze extends DataAnalyzer
   {
       
      
      public var data:DictionaryData;
      
      public var buyLimitLv:Array;
      
      public function TeamShopAnalyze(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(value:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var info:* = null;
         var lv:int = 0;
         var list:* = null;
         var xml:XML = new XML(value);
         buyLimitLv = [];
         data = new DictionaryData();
         if(xml.@value == "true")
         {
            xmllist = xml..Item;
            for(i = 0; i < xmllist.length(); )
            {
               info = new TeamShopInfo();
               ObjectUtils.copyPorpertiesByXML(info,xmllist[i]);
               lv = xmllist[i].@NeedLevel;
               if(buyLimitLv.indexOf(lv) == -1)
               {
                  buyLimitLv.push(lv);
               }
               if(!data.hasKey(info.ShopType))
               {
                  data.add(info.ShopType,[]);
               }
               list = data[info.ShopType];
               list.push(info);
               i++;
            }
            buyLimitLv.sort();
            onAnalyzeComplete();
         }
         else
         {
            message = xml.@message;
            onAnalyzeError();
         }
         data = null;
         buyLimitLv = null;
      }
   }
}
