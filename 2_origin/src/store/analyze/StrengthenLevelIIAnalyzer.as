package store.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.store.StrengthenLevelII;
   import flash.utils.Dictionary;
   
   public class StrengthenLevelIIAnalyzer extends DataAnalyzer
   {
       
      
      public var LevelItems1:Dictionary;
      
      public var LevelItems2:Dictionary;
      
      public var LevelItems3:Dictionary;
      
      public var LevelItems4:Dictionary;
      
      public var SucceedRate:int;
      
      private var _xml:XML;
      
      public function StrengthenLevelIIAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var i:int = 0;
         var info:* = null;
         _xml = new XML(data);
         LevelItems1 = new Dictionary(true);
         LevelItems2 = new Dictionary(true);
         LevelItems3 = new Dictionary(true);
         LevelItems4 = new Dictionary(true);
         var xmllist:XMLList = _xml.Item;
         if(_xml.@value == "true")
         {
            for(i = 0; i < xmllist.length(); )
            {
               info = new StrengthenLevelII();
               ObjectUtils.copyPorpertiesByXML(info,xmllist[i]);
               SucceedRate = info.DamagePlusRate;
               LevelItems1[info.StrengthenLevel] = info.Rock;
               LevelItems2[info.StrengthenLevel] = info.Rock1;
               LevelItems3[info.StrengthenLevel] = info.Rock2;
               LevelItems4[info.StrengthenLevel] = info.Rock3;
               i++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _xml.@message;
            onAnalyzeError();
            onAnalyzeComplete();
         }
      }
   }
}
