package collectionTask.model
{
   import collectionTask.vo.CollectionRobertVo;
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ItemManager;
   
   public class CollectionTaskAnalyzer extends DataAnalyzer
   {
       
      
      private var _collectionTaskInfoList:Vector.<CollectionRobertVo>;
      
      public function CollectionTaskAnalyzer(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
      
      public function get collectionTaskInfoList() : Vector.<CollectionRobertVo>{return null;}
   }
}
