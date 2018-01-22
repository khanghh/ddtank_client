package collectionTask.model
{
   import collectionTask.vo.CollectionRobertVo;
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ItemManager;
   
   public class CollectionTaskAnalyzer extends DataAnalyzer
   {
       
      
      private var _collectionTaskInfoList:Vector.<CollectionRobertVo>;
      
      public function CollectionTaskAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc2_:* = null;
         var _loc3_:XML = new XML(param1);
         _collectionTaskInfoList = new Vector.<CollectionRobertVo>();
         if(_loc3_.@value == "true")
         {
            _loc4_ = _loc3_..item;
            _loc5_ = 0;
            while(_loc5_ < _loc4_.length())
            {
               _loc2_ = new CollectionRobertVo();
               ObjectUtils.copyPorpertiesByXML(_loc2_,_loc4_[_loc5_]);
               _loc2_.Style = "," + _loc2_.Glass + "|" + ItemManager.Instance.getTemplateById(_loc2_.Glass).Pic + "," + _loc2_.Hair + "|" + ItemManager.Instance.getTemplateById(_loc2_.Hair).Pic + "," + _loc2_.Eye + "|" + ItemManager.Instance.getTemplateById(_loc2_.Eye).Pic + "," + "," + _loc2_.Face + "|" + ItemManager.Instance.getTemplateById(_loc2_.Face).Pic + ",,,,,";
               _collectionTaskInfoList.push(_loc2_);
               _loc5_++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _loc3_.@message;
            onAnalyzeError();
            onAnalyzeError();
         }
      }
      
      public function get collectionTaskInfoList() : Vector.<CollectionRobertVo>
      {
         return _collectionTaskInfoList;
      }
   }
}
