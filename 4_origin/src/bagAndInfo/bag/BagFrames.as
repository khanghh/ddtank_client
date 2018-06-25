package bagAndInfo.bag
{
   import auctionHouse.view.AuctionBagView;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import ddt.manager.PlayerManager;
   
   public class BagFrames extends Frame
   {
       
      
      protected var _bagView:BagView;
      
      protected var _emailBagView:AuctionBagView;
      
      protected var _isShow:Boolean;
      
      public function BagFrames()
      {
         super();
         initView();
         initEvent();
      }
      
      protected function initView() : void
      {
         _bagView = ComponentFactory.Instance.creatCustomObject("bagFrameBagView");
         _bagView.info = PlayerManager.Instance.Self;
         _emailBagView = ComponentFactory.Instance.creatCustomObject("email.view.EmailBagView.Frame");
         _emailBagView.info = PlayerManager.Instance.Self;
         addToContent(_emailBagView);
      }
      
      public function graySortBtn() : void
      {
         _bagView.sortBagEnable = false;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
      }
      
      private function __responseHandler(evt:FrameEvent) : void
      {
         switch(int(evt.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function get bagView() : BagView
      {
         return _bagView;
      }
      
      public function get emailBagView() : AuctionBagView
      {
         return _emailBagView;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,false);
         _isShow = true;
      }
      
      public function hide() : void
      {
         if(parent)
         {
            parent.removeChild(this);
            _isShow = false;
         }
      }
      
      public function get isShow() : Boolean
      {
         return _isShow;
      }
      
      override public function dispose() : void
      {
         removeEventListener("response",__responseHandler);
         if(_bagView)
         {
            _bagView.dispose();
         }
         if(_emailBagView)
         {
            _emailBagView.dispose();
         }
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
