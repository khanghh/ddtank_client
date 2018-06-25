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
      
      public function push(item:SceneCharacterActionPointItem) : void
      {
         _dataSet.push(item);
      }
      
      public function get length() : uint
      {
         return _dataSet.length;
      }
      
      public function get dataSet() : Vector.<SceneCharacterActionPointItem>
      {
         return _dataSet;
      }
      
      public function getItem(type:String) : SceneCharacterActionPointItem
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
      
      public function replace(item:SceneCharacterActionPointItem) : void
      {
         var i:int = 0;
         if(_dataSet)
         {
            for(i = 0; i < _dataSet.length; )
            {
               if(_dataSet[i].type == item.type)
               {
                  _dataSet[i].dispose();
                  _dataSet.splice(i,1,item);
                  return;
               }
               i++;
            }
            _dataSet.push(item);
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
