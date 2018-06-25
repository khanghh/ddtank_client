package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import flash.utils.Dictionary;
   
   public class FriendsMountTypeAnalyzer extends DataAnalyzer
   {
       
      
      public var list:Dictionary;
      
      public function FriendsMountTypeAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var len:int = 0;
         var xmllist:* = null;
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            list = new Dictionary();
            len = xml.Item.length();
            xmllist = xml.Item;
            var _loc7_:int = 0;
            var _loc6_:* = xmllist;
            for each(var v in xmllist)
            {
               list[v.@UserID.toString()] = Math.max(1,int(v.@CurrentID));
            }
            onAnalyzeComplete();
         }
         else
         {
            message = xml.@message;
            onAnalyzeError();
            onAnalyzeComplete();
         }
      }
   }
}
