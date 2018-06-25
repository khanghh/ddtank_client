package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.Role;
   import road7th.utils.DateUtils;
   
   public class LoginSelectListAnalyzer extends DataAnalyzer
   {
       
      
      public var list:Vector.<Role>;
      
      public var totalCount:int;
      
      public function LoginSelectListAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var info:* = null;
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            list = new Vector.<Role>();
            totalCount = int(xml.@total);
            xmllist = XML(xml)..Item;
            for(i = 0; i < xmllist.length(); )
            {
               info = new Role();
               ObjectUtils.copyPorpertiesByXML(info,xmllist[i]);
               info.lastDate = DateUtils.decodeDated(xmllist[i].@LastDate);
               list.push(info);
               i++;
            }
            list.sort(sortLastDate);
            list.sort(sortLoginState);
            onAnalyzeComplete();
         }
         else
         {
            message = xml.@message;
            onAnalyzeError();
         }
      }
      
      private function sortLastDate(a:Role, b:Role) : int
      {
         var result:int = 0;
         if(a.lastDate.time < b.lastDate.time)
         {
            result = 1;
         }
         else
         {
            result = -1;
         }
         return result;
      }
      
      private function sortLoginState(a:Role, b:Role) : int
      {
         if(a.LoginState == 1 && b.LoginState != 1)
         {
            return 1;
         }
         if(a.LoginState != -1 && b.LoginState == 1)
         {
            return -1;
         }
         return sortLastDate(a,b);
      }
   }
}
