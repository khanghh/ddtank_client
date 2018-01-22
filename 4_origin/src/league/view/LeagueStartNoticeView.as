package league.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ChatManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.geom.Point;
   
   public class LeagueStartNoticeView extends BaseAlerFrame
   {
       
      
      private var _bmpNpc:Bitmap;
      
      private var _bmpTxt:Bitmap;
      
      public function LeagueStartNoticeView()
      {
         super();
         addEventListener("response",__responseHandler);
         initView();
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            this.dispose();
         }
      }
      
      private function initView() : void
      {
         info = new AlertInfo();
         _info.showCancel = false;
         _info.moveEnable = false;
         _info.autoButtonGape = false;
         _info.customPos = ComponentFactory.Instance.creatCustomObject("trainer.league.posBtn");
         _bmpNpc = ComponentFactory.Instance.creatBitmap("asset.trainer.welcome.girl2");
         PositionUtils.setPos(_bmpNpc,"league.LeagueStartNoticeView.girlPos");
         addToContent(_bmpNpc);
         _bmpTxt = ComponentFactory.Instance.creatBitmap("asset.league.leagueNotice");
         addToContent(_bmpTxt);
         ChatManager.Instance.releaseFocus();
      }
      
      override public function dispose() : void
      {
         removeEventListener("response",__responseHandler);
         super.dispose();
         ObjectUtils.disposeAllChildren(this);
         _bmpTxt = null;
         _bmpNpc = null;
      }
      
      public function show() : void
      {
         if(PlayerManager.Instance.Self._hasPopupLeagueNotice)
         {
            return;
         }
         var _loc1_:Point = ComponentFactory.Instance.creatCustomObject("trainer.posLeagueStart");
         x = _loc1_.x;
         y = _loc1_.y;
         LayerManager.Instance.addToLayer(this,3,false,1);
         PlayerManager.Instance.Self._hasPopupLeagueNotice = true;
      }
   }
}
