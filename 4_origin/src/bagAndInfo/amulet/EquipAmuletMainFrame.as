package bagAndInfo.amulet
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.BagEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import flash.events.Event;
   
   public class EquipAmuletMainFrame extends Frame
   {
       
      
      private var _helpBtn:SimpleBitmapButton;
      
      private var _upgradeBtn:SelectedButton;
      
      private var _activateBtn:SelectedButton;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _upgradeView:EquipAmuletUpgradeView;
      
      private var _activateView:EquipAmuletActivateView;
      
      public function EquipAmuletMainFrame()
      {
         super();
         addEvent();
         _btnGroup.selectIndex = 0;
         SocketManager.Instance.out.sendEquipAmuletBuyNum();
      }
      
      override protected function init() : void
      {
         _upgradeBtn = ComponentFactory.Instance.creatComponentByStylename("equipAmulet.upgradeSelectBtn");
         _activateBtn = ComponentFactory.Instance.creatComponentByStylename("equipAmulet.activateSelectBtn");
         _upgradeView = new EquipAmuletUpgradeView();
         PositionUtils.setPos(_upgradeView,"equipAmulet.upgradeViewPos");
         _activateView = new EquipAmuletActivateView();
         PositionUtils.setPos(_activateView,"equipAmulet.activateViewPos");
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_upgradeBtn);
         _btnGroup.addSelectItem(_activateBtn);
         super.init();
         titleText = LanguageMgr.GetTranslation("tank.data.EquipType.equipAmulet");
         _helpBtn = HelpFrameUtils.Instance.simpleHelpButton(this,"coreii.helpBtn",{
            "x":399,
            "y":-38
         },LanguageMgr.GetTranslation("store.view.HelpButtonText"),"asset.equipAmulet.help",408,488);
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_upgradeBtn)
         {
            addToContent(_upgradeBtn);
         }
         if(_activateBtn)
         {
            addToContent(_activateBtn);
         }
         if(_upgradeView)
         {
            addToContent(_upgradeView);
         }
         if(_activateView)
         {
            addToContent(_activateView);
         }
      }
      
      private function __onChangeHandler(param1:Event) : void
      {
         SoundManager.instance.playButtonSound();
         switch(int(_btnGroup.selectIndex))
         {
            case 0:
               _upgradeView.update();
               _upgradeView.visible = true;
               _activateView.visible = false;
               break;
            case 1:
               _upgradeView.visible = false;
               _activateView.update();
               _activateView.visible = true;
         }
      }
      
      private function __onUpdateBuyStiveNum(param1:PkgEvent) : void
      {
         EquipAmuletManager.Instance.buyStiveNum = param1.pkg.readInt();
      }
      
      private function __onUpdateBag(param1:BagEvent) : void
      {
         if(PlayerManager.Instance.Self.Bag.items[18] == null)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.equipAmulet.dated"));
            EquipAmuletManager.Instance.closeFrame();
         }
      }
      
      override protected function onResponse(param1:int) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.playButtonSound();
         if(_activateView.isActivate)
         {
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("tank.equipAmulet.closeFrameTip"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2,null,"SimpleAlert",60,false);
            _loc2_.addEventListener("response",__onCloseFrameTips);
         }
         else
         {
            EquipAmuletManager.Instance.closeFrame();
         }
      }
      
      private function __onCloseFrameTips(param1:FrameEvent) : void
      {
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",__onCloseFrameTips);
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            EquipAmuletManager.Instance.closeFrame();
         }
         _loc2_.dispose();
      }
      
      private function addEvent() : void
      {
         _btnGroup.addEventListener("change",__onChangeHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(386,1),__onUpdateBuyStiveNum);
         PlayerManager.Instance.Self.getBag(0).addEventListener("update",__onUpdateBag);
      }
      
      private function removeEvent() : void
      {
         _btnGroup.removeEventListener("change",__onChangeHandler);
         SocketManager.Instance.removeEventListener(PkgEvent.format(386,1),__onUpdateBuyStiveNum);
         PlayerManager.Instance.Self.getBag(0).removeEventListener("update",__onUpdateBag);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         _btnGroup.dispose();
         _btnGroup = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         super.dispose();
         _upgradeBtn = null;
         _activateBtn = null;
         _upgradeView = null;
         _activateView = null;
      }
   }
}
