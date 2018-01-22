package starling.display.sceneCharacter
{
   public class SceneCharacterActionPointSet
   {
       
      
      private var _dataSet:Vector.<SceneCharacterActionPointItem>;
      
      public function SceneCharacterActionPointSet()
      {
         super();
         _dataSet = new Vector.<SceneCharacterActionPointItem>();
      }
      
      public function push(param1:SceneCharacterActionPointItem) : void
      {
         _dataSet.push(param1);
      }
      
      public function get length() : uint
      {
         return _dataSet.length;
      }
      
      public function get dataSet() : Vector.<SceneCharacterActionPointItem>
      {
         return _dataSet;
      }
      
      public function getItem(param1:String) : SceneCharacterActionPointItem
      {
         var _loc2_:int = 0;
         if(_dataSet && _dataSet.length > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < _dataSet.length)
            {
               if(_dataSet[_loc2_].type == param1)
               {
                  return _dataSet[_loc2_];
               }
               _loc2_++;
            }
         }
         return null;
      }
      
      public function replace(param1:SceneCharacterActionPointItem) : void
      {
         var _loc2_:int = 0;
         if(_dataSet)
         {
            _loc2_ = 0;
            while(_loc2_ < _dataSet.length)
            {
               if(_dataSet[_loc2_].type == param1.type)
               {
                  _dataSet[_loc2_].dispose();
                  _dataSet.splice(_loc2_,1,param1);
                  return;
               }
               _loc2_++;
            }
            _dataSet.push(param1);
         }
      }
      
      public function reset() : void
      {
         while(_dataSet && _dataSet.length > 0)
         {
            _dataSet[0].dispose();
            _dataSet.shift();
         }
      }
      
      public function dispose() : void
      {
         while(_dataSet && _dataSet.length > 0)
         {
            _dataSet[0].dispose();
            _dataSet.shift();
         }
         _dataSet = null;
      }
   }
}
