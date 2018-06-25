package ddt.view.sceneCharacter
{
   public class SceneCharacterSet
   {
       
      
      private var _dataSet:Vector.<SceneCharacterItem>;
      
      public function SceneCharacterSet()
      {
         super();
         _dataSet = new Vector.<SceneCharacterItem>();
      }
      
      public function push(sceneCharacterItem:SceneCharacterItem) : void
      {
         _dataSet.push(sceneCharacterItem);
      }
      
      public function get length() : uint
      {
         return _dataSet.length;
      }
      
      public function get dataSet() : Vector.<SceneCharacterItem>
      {
         return _dataSet.sort(sortOn);
      }
      
      private function sortOn(a:SceneCharacterItem, b:SceneCharacterItem) : Number
      {
         if(a.sortOrder < b.sortOrder)
         {
            return -1;
         }
         if(a.sortOrder > b.sortOrder)
         {
            return 1;
         }
         return 0;
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
