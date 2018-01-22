package ringStation.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import labyrinth.data.RankingInfo;
   import road7th.comm.PackageIn;
   
   public class ArmoryView extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var _closeBg:ScaleBitmapImage;
      
      private var _closeBtn:BaseButton;
      
      private var _list:ListPanel;
      
      public function ArmoryView()
      {
         super();
         initView();
         initEvent();
         sendPkg();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("ringStation.view.armoryView.titleInfo");
         _bg = ComponentFactory.Instance.creat("ringStation.view.armory.bg");
         addToContent(_bg);
         _closeBg = ComponentFactory.Instance.creatComponentByStylename("ringStation.view.armory.closeBg");
         addToContent(_closeBg);
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("ringStation.view.armory.closeBtn");
         addToContent(_closeBtn);
         _list = ComponentFactory.Instance.creatComponentByStylename("ringStation.view.armory.List");
         addToContent(_list);
      }
      
      private function sendPkg() : void
      {
         SocketManager.Instance.out.sendRingStationArmory();
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameEventHandler);
         _closeBtn.addEventListener("click",__onCloseClick);
         SocketManager.Instance.addEventListener(PkgEvent.format(404,3),__getArmoryInfo);
      }
      
      protected function __getArmoryInfo(param1:PkgEvent) : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = null;
         var _loc3_:PackageIn = param1.pkg;
         var _loc4_:Array = [];
         var _loc2_:int = _loc3_.readInt();
         _loc6_ = 0;
         while(_loc6_ < _loc2_)
         {
            _loc5_ = new RankingInfo();
            _loc5_.PlayerRank = _loc3_.readInt();
            _loc5_.FamLevel = _loc3_.readInt();
            _loc5_.PlayerName = _loc3_.readUTF();
            _loc5_.Fighting = _loc3_.readInt();
            _loc3_.readInt();
            _loc4_.push(_loc5_);
            _loc6_++;
         }
         _list.vectorListModel.clear();
         _list.vectorListModel.appendAll(_loc4_);
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,2);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameEventHandler);
         _closeBtn.removeEventListener("click",__onCloseClick);
         SocketManager.Instance.removeEventListener(PkgEvent.format(404,3),__getArmoryInfo);
      }
      
      private function __frameEventHandler(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         if(_bg)
         {
            _bg.bitmapData.dispose();
            _bg = null;
         }
         if(_closeBg)
         {
            _closeBg.dispose();
            _closeBg = null;
         }
         if(_closeBtn)
         {
            _closeBtn.dispose();
            _closeBtn = null;
         }
         if(_list)
         {
            _list.dispose();
            _list = null;
         }
      }
   }
}
