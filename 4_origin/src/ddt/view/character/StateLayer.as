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
      
      public function StateLayer(param1:ItemTemplateInfo, param2:Boolean, param3:String, param4:int = 1)
      {
         _stateType = param4;
         _sex = param2;
         super(param1,param3);
      }
      
      override protected function getUrl(param1:int) : String
      {
         return PathManager.SITE_MAIN + "image/equip/effects/state/" + (!!_sex?"m/":"f/") + _stateType + "/show" + param1 + ".png";
      }
      
      override protected function initLoaders() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc1_:* = null;
         _loc3_ = 0;
         while(_loc3_ < 3)
         {
            _loc2_ = getUrl(_loc3_ + 1);
            _loc2_ = _loc2_.toLocaleLowerCase();
            _loc1_ = LoadResourceManager.Instance.createLoader(_loc2_,0);
            _queueLoader.addLoader(_loc1_);
            _loc3_++;
         }
         _defaultLayer = 0;
         _currentEdit = _queueLoader.length;
      }
      
      override protected function __loadComplete(param1:Event) : void
      {
         reSetBitmap();
         _queueLoader.removeEventListener("complete",__loadComplete);
         _queueLoader.removeEvent();
         initColors(_color);
         loadCompleteCallBack();
      }
   }
}
