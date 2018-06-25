package ddt.view.character
{
   import com.pickgliss.loader.BitmapLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.PathManager;
   import flash.events.Event;
   
   public class StateLayer extends BaseLayer
   {
       
      
      private var _stateType:int;
      
      private var _sex:Boolean;
      
      public function StateLayer(info:ItemTemplateInfo, sex:Boolean, color:String, type:int = 1)
      {
         _stateType = type;
         _sex = sex;
         super(info,color);
      }
      
      override protected function getUrl(layer:int) : String
      {
         return PathManager.SITE_MAIN + "image/equip/effects/state/" + (!!_sex?"m/":"f/") + _stateType + "/show" + layer + ".png";
      }
      
      override protected function initLoaders() : void
      {
         var i:int = 0;
         var url:* = null;
         var l:* = null;
         for(i = 0; i < 3; )
         {
            url = getUrl(i + 1);
            url = url.toLocaleLowerCase();
            l = LoadResourceManager.Instance.createLoader(url,0);
            _queueLoader.addLoader(l);
            i++;
         }
         _defaultLayer = 0;
         _currentEdit = _queueLoader.length;
      }
      
      override protected function __loadComplete(event:Event) : void
      {
         reSetBitmap();
         _queueLoader.removeEventListener("complete",__loadComplete);
         _queueLoader.removeEvent();
         initColors(_color);
         loadCompleteCallBack();
      }
   }
}
