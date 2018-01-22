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
      
      public function CellMovieClipSpecialEffectLayer(param1:int = 1)
      {
         _specialType = param1;
         _movieClips = new Vector.<MovieClip>();
         super(new ItemTemplateInfo());
      }
      
      override protected function getUrl(param1:int) : String
      {
         return PathManager.cellMovieClipSpecialEffectPath(param1.toString());
      }
      
      override protected function initLoaders() : void
      {
         var _loc3_:String = getUrl(_specialType);
         _loc3_ = _loc3_.toLocaleLowerCase();
         var _loc1_:URLVariables = new URLVariables();
         _loc1_.rnd = new Date().time;
         var _loc2_:DisplayLoader = LoadResourceManager.Instance.createLoader(_loc3_,1,_loc1_);
         _queueLoader.addLoader(_loc2_);
      }
      
      override protected function __loadComplete(param1:Event) : void
      {
         reSetBitmap();
         _queueLoader.removeEventListener("complete",__loadComplete);
         _queueLoader.removeEvent();
         initColors(_color);
         loadCompleteCallBack();
      }
      
      override public function reSetBitmap() : void
      {
         var _loc1_:int = 0;
         clearBitmap();
         _loc1_ = 0;
         while(_loc1_ < _queueLoader.loaders.length)
         {
            _movieClips.push(_queueLoader.loaders[_loc1_].content);
            if(_movieClips[_loc1_])
            {
               _movieClips[_loc1_].smoothing = true;
               _movieClips[_loc1_].visible = true;
               _movieClips[_loc1_].scaleX = 1.1;
               _movieClips[_loc1_].scaleY = 1.1;
               addChild(_movieClips[_loc1_]);
            }
            _loc1_++;
         }
      }
      
      override protected function clearBitmap() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _movieClips = new Vector.<MovieClip>();
      }
   }
}
