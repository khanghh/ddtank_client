package ddt.view.caddyII
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   
   public class CaddyAwardDataAnalyzer extends DataAnalyzer
   {
       
      
      public var _awards:Vector.<CaddyAwardInfo>;
      
      public var _silverAwards:Vector.<CaddyAwardInfo>;
      
      public var _goldAwards:Vector.<CaddyAwardInfo>;
      
      public var _treasureAwards:Vector.<CaddyAwardInfo>;
      
      public var _silverToyAwards:Vector.<CaddyAwardInfo>;
      
      public var _goldToyAwards:Vector.<CaddyAwardInfo>;
      
      public function CaddyAwardDataAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var i:int = 0;
         var itemData:* = null;
         _awards = new Vector.<CaddyAwardInfo>();
         _silverAwards = new Vector.<CaddyAwardInfo>();
         _goldAwards = new Vector.<CaddyAwardInfo>();
         _treasureAwards = new Vector.<CaddyAwardInfo>();
         _silverToyAwards = new Vector.<CaddyAwardInfo>();
         _goldToyAwards = new Vector.<CaddyAwardInfo>();
         var xml:XML = new XML(data);
         var len:int = xml.item.length();
         var xmllist:XMLList = xml.item;
         for(i = 0; i < len; )
         {
            itemData = new CaddyAwardInfo();
            ObjectUtils.copyPorpertiesByXML(itemData,xmllist[i]);
            if(xmllist[i].@BoxType == 1)
            {
               _awards.push(itemData);
            }
            else if(xmllist[i].@BoxType == 2)
            {
               _silverAwards.push(itemData);
            }
            else if(xmllist[i].@BoxType == 3)
            {
               _goldAwards.push(itemData);
            }
            else if(xmllist[i].@BoxType == 4)
            {
               _treasureAwards.push(itemData);
            }
            else if(xmllist[i].@BoxType == 5)
            {
               _silverToyAwards.push(itemData);
            }
            else if(xmllist[i].@BoxType == 6)
            {
               _goldToyAwards.push(itemData);
            }
            i++;
         }
         onAnalyzeComplete();
      }
   }
}
