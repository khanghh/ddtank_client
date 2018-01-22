package starling.scene.hall.player
{
   import com.pickgliss.ui.core.Disposeable;
   import ddt.view.character.ILayer;
   
   public class HallPlayerBaseLoader implements Disposeable
   {
       
      
      protected var _isAllLoadSucceed:Boolean = false;
      
      protected var _loaders:Vector.<ILayer>;
      
      protected var _cellBack:Function;
      
      public function HallPlayerBaseLoader()
      {
         super();
      }
      
      public function load(param1:Function) : void
      {
         var _loc2_:int = 0;
         _cellBack = param1;
         _loaders = new Vector.<ILayer>();
         setLoaderData();
         _loc2_ = 0;
         while(_loc2_ < _loaders.length)
         {
            _loaders[_loc2_].load(layerComplete);
            _loc2_++;
         }
      }
      
      protected function setLoaderData() : void
      {
      }
      
      private function layerComplete(param1:ILayer) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Boolean = true;
         _loc3_ = 0;
         while(_loc3_ < _loaders.length)
         {
            if(!_loaders[_loc3_].isComplete)
            {
               _loc2_ = false;
            }
            _loc3_++;
         }
         if(_loc2_)
         {
            _isAllLoadSucceed = true;
            drawCharacter();
            loadComplete();
         }
      }
      
      protected function drawCharacter() : void
      {
      }
      
      protected function loadComplete() : void
      {
         if(_cellBack)
         {
            _cellBack(this);
         }
      }
      
      public function get content() : Object
      {
         return null;
      }
      
      public function get isAllLoadSucceed() : Boolean
      {
         return _isAllLoadSucceed;
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         if(_loaders)
         {
            _loc1_ = 0;
            while(_loc1_ < _loaders.length)
            {
               _loaders[_loc1_].dispose();
               _loc1_++;
            }
         }
         _loaders = null;
         _cellBack = null;
      }
   }
}
