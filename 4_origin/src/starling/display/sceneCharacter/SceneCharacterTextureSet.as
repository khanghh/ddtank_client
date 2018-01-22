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
      
      public function push(param1:SceneCharacterTextureItem) : void
      {
         _dataSet.push(param1);
      }
      
      public function get length() : uint
      {
         return _dataSet.length;
      }
      
      public function get dataSet() : Vector.<SceneCharacterTextureItem>
      {
         return _dataSet;
      }
      
      public function replace(param1:SceneCharacterTextureItem) : void
      {
         var _loc2_:int = 0;
         if(_dataSet)
         {
            _loc2_ = 0;
            while(_loc2_ < _dataSet.length)
            {
               if(_dataSet[_loc2_].type == param1.type)
               {
                  if(_dataSet[_loc2_] != param1)
                  {
                     _dataSet.splice(_loc2_,1,param1);
                  }
                  return;
               }
               _loc2_++;
            }
            _dataSet.push(param1);
         }
      }
      
      public function getItem(param1:String) : SceneCharacterTextureItem
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
      
      public function removeItem(param1:String) : void
      {
         var _loc2_:int = 0;
         if(_dataSet)
         {
            _loc2_ = 0;
            while(_loc2_ < _dataSet.length)
            {
               if(_dataSet[_loc2_].type == param1)
               {
                  _dataSet.splice(_loc2_,1);
                  return;
               }
               _loc2_++;
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
