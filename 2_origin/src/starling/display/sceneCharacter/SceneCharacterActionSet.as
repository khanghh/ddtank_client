package starling.display.sceneCharacter
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
      
      public function getItems(state:String) : Vector.<SceneCharacterActionItem>
      {
         var i:int = 0;
         var list:Vector.<SceneCharacterActionItem> = new Vector.<SceneCharacterActionItem>();
         if(_dataSet && _dataSet.length > 0)
         {
            for(i = 0; i < _dataSet.length; )
            {
               if(_dataSet[i].state == state)
               {
                  list.push(_dataSet[i]);
               }
               i++;
            }
         }
         return list;
      }
      
      public function replace(item:SceneCharacterActionItem) : void
      {
         var i:int = 0;
         if(_dataSet)
         {
            for(i = 0; i < _dataSet.length; )
            {
               if(_dataSet[i].state == item.state && _dataSet[i].type == item.type)
               {
                  if(_dataSet[i] != item)
                  {
                     _dataSet[i].dispose();
                     _dataSet.splice(i,1,item);
                  }
                  return;
               }
               i++;
            }
            _dataSet.push(item);
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
