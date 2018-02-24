package store.equipGhost.data
{
   import flash.utils.Dictionary;
   
   public final class GhostModel
   {
       
      
      private var _dataList:Vector.<GhostData>;
      
      private var _topLvDic:Dictionary;
      
      public function GhostModel(){super();}
      
      public function initModel(param1:Vector.<GhostData>) : void{}
      
      public function get topLvDic() : Dictionary{return null;}
      
      public function getGhostData(param1:int, param2:int) : GhostData{return null;}
   }
}
