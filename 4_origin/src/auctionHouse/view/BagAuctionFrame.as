package auctionHouse.view
{
   import bagAndInfo.bag.BagFrame;
   import ddt.events.CellEvent;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class BagAuctionFrame extends BagFrame
   {
       
      
      public function BagAuctionFrame()
      {
         super();
         escEnable = true;
         initEvent();
      }
      
      private function initEvent() : void
      {
         _bagView.addEventListener("tabChange",__onTabChanged);
      }
      
      protected function __onTabChanged(param1:Event) : void
      {
         if(_bagView.bagType == 21)
         {
            _bagView.switchButtomVisible(false);
            _bagView.enableBeadFunctionBtns(false);
         }
         else
         {
            _bagView.switchButtomVisible(true);
         }
      }
      
      override protected function initView() : void
      {
         _bagView = new AuctionBagView();
         _bagView.isNeedCard(false);
         _bagView.cardbtnVible = false;
         _bagView.tableEnable = true;
         _bagView.info = PlayerManager.Instance.Self;
         _bagView.initBeadButton();
         _bagView.switchButtomVisible(true);
         addToContent(_bagView);
         PositionUtils.setPos(_bagView,"AutionBagView.Pos");
      }
      
      override protected function __onCloseClick(param1:MouseEvent) : void
      {
         super.__onCloseClick(null);
      }
      
      override protected function onResponse(param1:int) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1))
         {
            case 0:
            case 1:
               hide();
               dispatchEvent(new CellEvent("bagClose"));
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _bagView.removeEventListener("tabChange",__onTabChanged);
      }
   }
}
