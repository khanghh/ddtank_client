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
      
      public function push(sceneCharacterActionItem:SceneCharacterActionItem) : void
      {
         _dataSet.push(sceneCharacterActionItem);
      }
      
      public function get length() : uint
      {
         return _dataSet.length;
      }
      
      public function get dataSet() : Vector.<SceneCharacterActionItem>
      {
         return _dataSet;
      }
      
      public function getItem(type:String) : SceneCharacterActionItem
      {
         var i:int = 0;
         if(_dataSet && _dataSet.length > 0)
         {
            for(i = 0; i < _dataSet.length; )
            {
               if(_dataSet[i].type == type)
               {
                  return _dataSet[i];
               }
               i++;
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
