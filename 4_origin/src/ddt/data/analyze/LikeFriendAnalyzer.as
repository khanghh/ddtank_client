package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.LikeFriendInfo;
   
   public class LikeFriendAnalyzer extends DataAnalyzer
   {
       
      
      public var likeFriendList:Array;
      
      public function LikeFriendAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var i:int = 0;
         var info:* = null;
         likeFriendList = [];
         var xml:XML = new XML(data);
         var xmllist:XMLList = xml..Item;
         if(xml.@value == "true")
         {
            for(i = 0; i < xmllist.length(); )
            {
               info = new LikeFriendInfo();
               ObjectUtils.copyPorpertiesByXML(info,xmllist[i]);
               info.isOld = int(xmllist[i].@OldPlayer) == 1;
               info.IsShow = xmllist[i].@IsShow == "true"?true:false;
               info.ImagePath = xmllist[i].@ImagePath;
               info.isAttest = xmllist[i].@IsBeauty == "false"?false:true;
               likeFriendList.push(info);
               i++;
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
