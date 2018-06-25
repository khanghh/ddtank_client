package vip.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import game.GameManager;
   import vip.VipController;
   
   public class VIPHelpFrame extends Frame
   {
       
      
      private var content:MovieClip;
      
      private var openVip:BaseButton;
      
      private var _openFun:Function;
      
      private var _contentScroll:ScrollPanel;
      
      private var _buttomBit:ScaleBitmapImage;
      
      public function VIPHelpFrame()
      {
         super();
         initFrame();
      }
      
      private function initFrame() : void
      {
         titleText = LanguageMgr.GetTranslation("ddt.vip.helpFrame.title");
         content = ComponentFactory.Instance.creat("asset.vip.helpFrame.content");
         _contentScroll = ComponentFactory.Instance.creatComponentByStylename("viphelpFrame.scroll");
         addToContent(_contentScroll);
         _contentScroll.setView(content);
         _buttomBit = ComponentFactory.Instance.creatComponentByStylename("GiveYourselfOpenView.buttomBG");
         addToContent(_buttomBit);
         _buttomBit.y = 372;
         openVip = ComponentFactory.Instance.creatComponentByStylename("GiveYourselfOpenView.openVipBtn");
         addToContent(openVip);
         var pos:Point = ComponentFactory.Instance.creatCustomObject("vipHelpFrame.openBtnPos");
         openVip.x = pos.x;
         openVip.y = pos.y;
         StageReferance.stage.focus = this;
         openVip.addEventListener("click",__open);
      }
      
      public function set openFun(fun:Function) : void
      {
         _openFun = fun;
      }
      
      public function show() : void
      {
         if(GameManager.instance.isPlaying)
         {
            return;
         }
         LayerManager.Instance.addToLayer(this,3,true,2);
      }
      
      private function __open(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.Grade < 3)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",3));
            return;
         }
         if(_openFun != null)
         {
            _openFun();
         }
         dispatchEvent(new FrameEvent(0));
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(openVip)
         {
            openVip.removeEventListener("click",__open);
         }
         if(content)
         {
            ObjectUtils.disposeObject(content);
         }
         content = null;
         if(openVip)
         {
            ObjectUtils.disposeObject(openVip);
         }
         openVip = null;
         _openFun = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         VipController.instance.helpframeNull();
      }
   }
}
