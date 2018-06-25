package ddt.view.sceneCharacter
{
   public class SceneCharacterStateSet
   {
       
      
      private var _dataSet:Vector.<SceneCharacterStateItem>;
      
      public function SceneCharacterStateSet()
      {
         super();
         _dataSet = new Vector.<SceneCharacterStateItem>();
      }
      
      public function push(sceneCharacterStateItem:SceneCharacterStateItem) : void
      {
         if(!sceneCharacterStateItem)
         {
            return;
         }
         sceneCharacterStateItem.update();
         _dataSet.push(sceneCharacterStateItem);
      }
      
      public function get length() : uint
      {
         return _dataSet.length;
      }
      
      public function get dataSet() : Vector.<SceneCharacterStateItem>
      {
         return _dataSet;
      }
      
      public function getItem(type:String) : SceneCharacterStateItem
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
