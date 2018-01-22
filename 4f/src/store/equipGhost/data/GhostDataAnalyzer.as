package store.equipGhost.data
{
   import com.pickgliss.loader.DataAnalyzer;
   
   public final class GhostDataAnalyzer extends DataAnalyzer
   {
       
      
      private var _dataList:Vector.<GhostData>;
      
      public function GhostDataAnalyzer(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
      
      public function get data() : Vector.<GhostData>{return null;}
   }
}
