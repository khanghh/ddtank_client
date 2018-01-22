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
      
      public function getItems(param1:String) : Vector.<SceneCharacterActionItem>
      {
         var _loc3_:int = 0;
         var _loc2_:Vector.<SceneCharacterActionItem> = new Vector.<SceneCharacterActionItem>();
         if(_dataSet && _dataSet.length > 0)
         {
            _loc3_ = 0;
            while(_loc3_ < _dataSet.length)
            {
               if(_dataSet[_loc3_].state == param1)
               {
                  _loc2_.push(_dataSet[_loc3_]);
               }
               _loc3_++;
            }
         }
         return _loc2_;
      }
      
      public function replace(param1:SceneCharacterActionItem) : void
      {
         var _loc2_:int = 0;
         if(_dataSet)
         {
            _loc2_ = 0;
            while(_loc2_ < _dataSet.length)
            {
               if(_dataSet[_loc2_].state == param1.state && _dataSet[_loc2_].type == param1.type)
               {
                  if(_dataSet[_loc2_] != param1)
                  {
                     _dataSet[_loc2_].dispose();
                     _dataSet.splice(_loc2_,1,param1);
                  }
                  return;
               }
               _loc2_++;
            }
            _dataSet.push(param1);
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
