package starling.display.sceneCharacter
{
   public class SceneCharacterTextureSet
   {
       
      
      private var _dataSet:Vector.<SceneCharacterTextureItem>;
      
      public function SceneCharacterTextureSet()
      {
         super();
         _dataSet = new Vector.<SceneCharacterTextureItem>();
      }
      
      public function push(sceneCharacterItem:SceneCharacterTextureItem) : void
      {
         _dataSet.push(sceneCharacterItem);
      }
      
      public function get length() : uint
      {
         return _dataSet.length;
      }
      
      public function get dataSet() : Vector.<SceneCharacterTextureItem>
      {
         return _dataSet;
      }
      
      public function replace(item:SceneCharacterTextureItem) : void
      {
         var i:int = 0;
         if(_dataSet)
         {
            for(i = 0; i < _dataSet.length; )
            {
               if(_dataSet[i].type == item.type)
               {
                  if(_dataSet[i] != item)
                  {
                     _dataSet.splice(i,1,item);
                  }
                  return;
               }
               i++;
            }
            _dataSet.push(item);
         }
      }
      
      public function getItem(type:String) : SceneCharacterTextureItem
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
      
      public function removeItem(type:String) : void
      {
         var i:int = 0;
         if(_dataSet)
         {
            for(i = 0; i < _dataSet.length; )
            {
               if(_dataSet[i].type == type)
               {
                  _dataSet.splice(i,1);
                  return;
               }
               i++;
            }
         }
      }
      
      public function dispose() : void
      {
         while(_dataSet && _dataSet.length > 0)
         {
            _dataSet.shift();
         }
         _dataSet = null;
      }
   }
}
