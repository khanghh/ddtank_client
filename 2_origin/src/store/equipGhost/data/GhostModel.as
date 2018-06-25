package store.equipGhost.data
{
   import flash.utils.Dictionary;
   
   public final class GhostModel
   {
       
      
      private var _dataList:Vector.<GhostData>;
      
      private var _topLvDic:Dictionary;
      
      public function GhostModel()
      {
         _topLvDic = new Dictionary();
         super();
      }
      
      public function initModel(data:Vector.<GhostData>) : void
      {
         _dataList = data;
         var key:int = -1;
         var _loc5_:int = 0;
         var _loc4_:* = _dataList;
         for each(var gd in _dataList)
         {
            key = gd.categoryID;
            if(!_topLvDic[key])
            {
               _topLvDic[key] = 0;
            }
            if(gd.level > _topLvDic[key])
            {
               _topLvDic[key] = gd.level;
            }
         }
      }
      
      public function get topLvDic() : Dictionary
      {
         return _topLvDic;
      }
      
      public function getGhostData(categoryID:int, level:int) : GhostData
      {
         var _loc5_:int = 0;
         var _loc4_:* = this._dataList;
         for each(var data in this._dataList)
         {
            if(data.categoryID == categoryID && data.level == level)
            {
               return data;
            }
         }
         return null;
      }
   }
}
