package worldboss.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SharedManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import worldboss.WorldBossManager;
   
   public class WorldBossBuyBuffConfirmFrame extends BaseAlerFrame
   {
       
      
      protected var _bgTitle:DisplayObject;
      
      protected var _alertTips:FilterFrameText;
      
      protected var _alertTips2:FilterFrameText;
      
      protected var _buyBtn:SelectedCheckButton;
      
      private var _type:int;
      
      private var _promptSCBGroup:SelectedButtonGroup;
      
      private var _promptSCB:SelectedCheckButton;
      
      private var _promptSCB2:SelectedCheckButton;
      
      public function WorldBossBuyBuffConfirmFrame()
      {
         super();
         var _loc1_:AlertInfo = new AlertInfo();
         _loc1_.title = LanguageMgr.GetTranslation("worldboss.buyBuff.confirmFrame.title");
         this.info = _loc1_;
         initView();
         initEvent();
      }
      
      protected function initView() : void
      {
         _alertTips = ComponentFactory.Instance.creatComponentByStylename("worldboss.buyBuffFrame.text");
         addToContent(_alertTips);
         _alertTips2 = ComponentFactory.Instance.creatComponentByStylename("worldboss.buyBuffFrame.text2");
         addToContent(_alertTips2);
         _alertTips2.text = "";
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("worldboss.buyBuffFrame.selectBtn");
         _buyBtn.x = 209;
         _buyBtn.y = 83;
         addToContent(_buyBtn);
         _buyBtn.text = LanguageMgr.GetTranslation("worldboss.buyBuff.confirmFrame.noAlert");
      }
      
      public function show(param1:int = 1) : void
      {
         _type = param1;
         var _loc2_:int = WorldBossManager.Instance.bossInfo.addInjureBuffMoney;
         var _loc3_:int = WorldBossManager.Instance.bossInfo.addInjureValue;
         _promptSCB = ComponentFactory.Instance.creatComponentByStylename("worldBoss.buffBuffFrame.selectCheckButton");
         _promptSCB2 = ComponentFactory.Instance.creatComponentByStylename("worldBoss.buffBuffFrame.selectCheckButton");
         PositionUtils.setPos(_promptSCB2,"worldBoss.buffBuffFrame.selectCheckButtonPos");
         if(param1 == 1)
         {
            _promptSCB.text = LanguageMgr.GetTranslation("worldboss.buyBuff.confirmFrame.desc3",_loc2_,_loc3_);
            _promptSCB2.text = LanguageMgr.GetTranslation("worldboss.buyBuff.confirmFrame.desc4",_loc2_);
         }
         else
         {
            _promptSCB.text = LanguageMgr.GetTranslation("worldboss.buyBuff.confirmFrame.desc5",_loc2_,_loc3_);
            _promptSCB2.text = LanguageMgr.GetTranslation("worldboss.buyBuff.confirmFrame.desc6",_loc2_);
         }
         _promptSCBGroup = new SelectedButtonGroup();
         _promptSCBGroup.addSelectItem(_promptSCB);
         _promptSCBGroup.addSelectItem(_promptSCB2);
         _promptSCBGroup.selectIndex = 0;
         addToContent(_promptSCB);
         addToContent(_promptSCB2);
         _backgound.width = _backgound.width + 66;
         _backgound.height = _backgound.height + 26;
         _closeButton.x = _closeButton.x + 66;
         _submitButton.x = _submitButton.x + 26;
         _cancelButton.x = _cancelButton.x + 26;
         _submitButton.y = _submitButton.y + 26;
         _cancelButton.y = _cancelButton.y + 26;
         _buyBtn.x = 238;
         _buyBtn.y = 117;
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      protected function initEvent() : void
      {
         addEventListener("response",__framePesponse);
         _buyBtn.addEventListener("select",__noAlertTip);
      }
      
      protected function __noAlertTip(param1:Event) : void
      {
         SoundManager.instance.play("008");
         if(_type == 1)
         {
            SharedManager.Instance.isWorldBossBuyBuff = _buyBtn.selected;
            SharedManager.Instance.isWorldBossBuyBuffFull = _promptSCBGroup.selectIndex == 1;
         }
         else
         {
            SharedManager.Instance.isWorldBossBindBuyBuff = _buyBtn.selected;
            SharedManager.Instance.isWorldBossBindBuyBuffFull = _promptSCBGroup.selectIndex == 1;
         }
         SharedManager.Instance.save();
      }
      
      protected function __framePesponse(param1:FrameEvent) : void
      {
         removeEventListener("response",__framePesponse);
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
               break;
            case 2:
            case 3:
               WorldBossManager.Instance.buyNewBuff(_type,_promptSCBGroup.selectIndex == 1);
         }
         dispose();
      }
      
      protected function removeEvent() : void
      {
         removeEventListener("response",__framePesponse);
         if(_buyBtn)
         {
            _buyBtn.removeEventListener("select",__noAlertTip);
         }
      }
      
      override public function dispose() : void
      {
         if(_promptSCBGroup)
         {
            _promptSCBGroup.dispose();
         }
         _promptSCBGroup = null;
         ObjectUtils.disposeObject(_promptSCB);
         _promptSCB = null;
         ObjectUtils.disposeObject(_promptSCB2);
         _promptSCB2 = null;
         if(_bgTitle)
         {
            ObjectUtils.disposeObject(_bgTitle);
            _bgTitle = null;
         }
         if(_buyBtn)
         {
            ObjectUtils.disposeObject(_buyBtn);
            _buyBtn = null;
         }
         if(_alertTips2)
         {
            ObjectUtils.disposeObject(_alertTips2);
            _alertTips2 = null;
         }
         if(_alertTips)
         {
            ObjectUtils.disposeObject(_alertTips);
            _alertTips = null;
         }
         super.dispose();
      }
   }
}
