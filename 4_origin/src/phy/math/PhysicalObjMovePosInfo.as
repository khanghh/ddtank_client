package phy.math
{
   import road7th.data.DictionaryData;
   
   public class PhysicalObjMovePosInfo
   {
       
      
      private var _voDic:DictionaryData;
      
      public function PhysicalObjMovePosInfo()
      {
         super();
         _voDic = new DictionaryData();
      }
      
      public function addVo(key:int, value:PhysicalObjMovePosVo) : void
      {
         _voDic.add(key,value);
      }
      
      public function isIntersect(x:int, y:int) : Boolean
      {
         if(_voDic.hasKey(x) && _voDic[x].isIntersect(y))
         {
            return true;
         }
         return false;
      }
   }
}
