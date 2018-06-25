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
      
      public function load(callBack:Function) : void
      {
         var i:int = 0;
         _cellBack = callBack;
         _loaders = new Vector.<ILayer>();
         setLoaderData();
         for(i = 0; i < _loaders.length; )
         {
            _loaders[i].load(layerComplete);
            i++;
         }
      }
      
      protected function setLoaderData() : void
      {
      }
      
      private function layerComplete(layer:ILayer) : void
      {
         var i:int = 0;
         var isAllLayerComplete:Boolean = true;
         for(i = 0; i < _loaders.length; )
         {
            if(!_loaders[i].isComplete)
            {
               isAllLayerComplete = false;
            }
            i++;
         }
         if(isAllLayerComplete)
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
         var i:int = 0;
         if(_loaders)
         {
            for(i = 0; i < _loaders.length; )
            {
               _loaders[i].dispose();
               i++;
            }
         }
         _loaders = null;
         _cellBack = null;
      }
   }
}
