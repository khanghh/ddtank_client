package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.map.DungeonInfo;
   
   public class DungeonAnalyzer extends DataAnalyzer
   {
      
      private static const PATH:String = "LoadPVEItems.xml";
       
      
      public var list:Vector.<DungeonInfo>;
      
      public function DungeonAnalyzer(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
   }
}
