package ddt.view.sceneCharacter
{
   public class SceneCharacterActionSet
   {
       
      
      private var _dataSet:Vector.<SceneCharacterActionItem>;
      
      public function SceneCharacterActionSet()
      {
         super();
         _dataSet = new Vector.<SceneCharacterActionItem>();
      }
      
      public function push(param1:SceneCharacterActionItem) : void
      {
         _dataSet.push(param1);
      }
      
      public function get length() : uint
      {
         return _dataSet.length;
      }
      
      public function get dataSet() : Vector.<SceneCharacterActionItem>
      {
         return _dataSet;
      }
      
      public function getItem(param1:String) : SceneCharacterActionItem
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
