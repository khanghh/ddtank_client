package vip.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import vip.VipController;
   
   public class VIPRechargeAlertFrame extends Frame
   {
       
      
      private var _scrollBg:Scale9CornerImage;
      
      private var _content:DisplayObject;
      
      private var _renewalVipBtn:BaseButton;
      
      private var _contentScroll:ScrollPanel;
      
      private var _buttomBit:ScaleBitmapImage;
      
      private var _head:VipFrameHead;
      
      private var _dueDataWord:FilterFrameText;
      
      private var _dueData:FilterFrameText;
      
      public function VIPRechargeAlertFrame()
      {
         super();
         initFrame();
      }
      
      public function set content(param1:DisplayObject) : void
      {
         _content = param1;
         _contentScroll.setView(_content);
      }
      
      private function initFrame() : void
      {
         _dueDataWord = ComponentFactory.Instance.creat("VipStatusView.dueDate2FontTxt");
         _dueDataWord.text = LanguageMgr.GetTranslation("ddt.vip.dueDate2FontTxt");
         _dueData = ComponentFactory.Instance.creat("VipStatusView.dueDate2");
         addToContent(_dueDataWord);
         addToContent(_dueData);
         _buttomBit = ComponentFactory.Instance.creatComponentByStylename("VIPRechargeAlert.buttomBG");
         addToContent(_buttomBit);
         _renewalVipBtn = ComponentFactory.Instance.creatComponentByStylename("GiveYourselfOpenView.renewalVipBtn");
         addToContent(_renewalVipBtn);
         var _loc1_:Point = ComponentFactory.Instance.creatCustomObject("VIPRechargeAlert.renewalVipBtnPos");
         _renewalVipBtn.x = _loc1_.x;
         _renewalVipBtn.y = _loc1_.y;
         _scrollBg = ComponentFactory.Instance.creatComponentByStylename("vip.rechargeLVBg");
         addToContent(_scrollBg);
         _contentScroll = ComponentFactory.Instance.creatComponentByStylename("vipRechargeAlertFrame.scroll");
         addToContent(_contentScroll);
         _contentScroll.vScrollProxy = 1;
         _contentScroll.hScrollProxy = 2;
         _contentScroll.vScrollbar.x = 392;
         _contentScroll.vScrollbar.y = 4;
         _head = new VipFrameHead(true,false);
         PositionUtils.setPos(_head,"vip.VipRechargeFrame.FrameHeadPos");
         addToContent(_head);
         titleText = LanguageMgr.GetTranslation("ddt.vip.helpFrame.title");
         StageReferance.stage.focus = this;
         _renewalVipBtn.addEventListener("click",__OK);
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,2);
         updata();
      }
      
      private function updata() : void
      {
         var _loc1_:Date = PlayerManager.Instance.Self.VIPExpireDay as Date;
         _dueData.text = _loc1_.fullYear + "-" + (_loc1_.month + 1) + "-" + _loc1_.date;
      }
      
      private function __OK(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         VipController.instance.show();
         dispatchEvent(new FrameEvent(0));
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_head)
         {
            _head.dispose();
            _head = null;
         }
         ObjectUtils.disposeObject(_scrollBg);
         _scrollBg = null;
         if(_dueDataWord)
         {
            ObjectUtils.disposeObject(_dueDataWord);
            _dueDataWord = null;
         }
         if(_dueData)
         {
            ObjectUtils.disposeObject(_dueData);
            _dueData = null;
         }
         if(_renewalVipBtn)
         {
            _renewalVipBtn.removeEventListener("click",__OK);
         }
         if(_content)
         {
            ObjectUtils.disposeObject(_content);
         }
         _content = null;
         if(_renewalVipBtn)
         {
            ObjectUtils.disposeObject(_renewalVipBtn);
         }
         _renewalVipBtn = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
