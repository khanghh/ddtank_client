package ddt.view.character
{
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.PathManager;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.net.URLVariables;
   
   public class CellMovieClipSpecialEffectLayer extends BaseLayer
   {
       
      
      private var _specialType:int;
      
      private var _categoryID:int;
      
      protected var _movieClips:Vector.<MovieClip>;
      
      public function CellMovieClipSpecialEffectLayer(layer:int = 1)
      {
         _specialType = layer;
         _movieClips = new Vector.<MovieClip>();
         super(new ItemTemplateInfo());
      }
      
      override protected function getUrl(layer:int) : String
      {
         return PathManager.cellMovieClipSpecialEffectPath(layer.toString());
      }
      
      override protected function initLoaders() : void
      {
         var url:String = getUrl(_specialType);
         url = url.toLocaleLowerCase();
         var args:URLVariables = new URLVariables();
         args.rnd = new Date().time;
         var l:DisplayLoader = LoadResourceManager.Instance.createLoader(url,1,args);
         _queueLoader.addLoader(l);
      }
      
      override protected function __loadComplete(event:Event) : void
      {
         reSetBitmap();
         _queueLoader.removeEventListener("complete",__loadComplete);
         _queueLoader.removeEvent();
         initColors(_color);
         loadCompleteCallBack();
      }
      
      override public function reSetBitmap() : void
      {
         var i:int = 0;
         clearBitmap();
         for(i = 0; i < _queueLoader.loaders.length; )
         {
            _movieClips.push(_queueLoader.loaders[i].content);
            if(_movieClips[i])
            {
               _movieClips[i].smoothing = true;
               _movieClips[i].visible = true;
               _movieClips[i].scaleX = 1.1;
               _movieClips[i].scaleY = 1.1;
               addChild(_movieClips[i]);
            }
            i++;
         }
      }
      
      override protected function clearBitmap() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _movieClips = new Vector.<MovieClip>();
      }
   }
}
