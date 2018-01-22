package auctionHouse.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   
   public class SimpleLoading extends Sprite implements Disposeable
   {
      
      public static var _instance:SimpleLoading;
       
      
      private var _view:Sprite;
      
      public function SimpleLoading()
      {
         super();
         _view = ComponentFactory.Instance.creat("asset.auctionHouse.simpleLoading");
         addChild(_view);
      }
      
      public static function get instance() : SimpleLoading
      {
         if(_instance == null)
         {
            _instance = new SimpleLoading();
         }
         return _instance;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,1,true);
      }
      
      public function hide() : void
      {
         dispose();
      }
      
      public function dispose() : void
      {
         if(_view)
         {
            ObjectUtils.disposeObject(_view);
         }
         _view = null;
         if(_instance)
         {
            _instance = null;
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
