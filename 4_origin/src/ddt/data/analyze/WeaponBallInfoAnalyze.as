package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import flash.utils.Dictionary;
   
   public class WeaponBallInfoAnalyze extends DataAnalyzer
   {
       
      
      public var bombs:Dictionary;
      
      public function WeaponBallInfoAnalyze(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var attr:* = null;
         var bombIds:* = null;
         var TemplateID:int = 0;
         var propname:* = null;
         var value:int = 0;
         var xml:XML = new XML(data);
         bombs = new Dictionary();
         if(xml.@value == "true")
         {
            xmllist = xml..Item;
            for(i = 0; i < xmllist.length(); )
            {
               attr = xmllist[i].attributes();
               bombIds = [];
               var _loc14_:int = 0;
               var _loc13_:* = attr;
               for each(var item in attr)
               {
                  propname = item.name().toString();
                  try
                  {
                     if(propname == "TemplateID")
                     {
                        TemplateID = item;
                     }
                     else
                     {
                        value = item;
                        bombIds.push(value);
                     }
                  }
                  catch(e:Error)
                  {
                     trace("错误:",e.message);
                     continue;
                  }
               }
               bombs[TemplateID] = bombIds;
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
