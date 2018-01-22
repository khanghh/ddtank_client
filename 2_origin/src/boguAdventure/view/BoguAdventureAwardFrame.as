package boguAdventure.view
{
   import baglocked.BaglockedManager;
   import boguAdventure.BoguAdventureControl;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class BoguAdventureAwardFrame extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var _tipBg:Bitmap;
      
      private var _tipText:FilterFrameText;
      
      private var _awardTipText1:FilterFrameText;
      
      private var _awardTipText2:FilterFrameText;
      
      private var _awardTipText3:FilterFrameText;
      
      private var _control:BoguAdventureControl;
      
      private var _level:int;
      
      private var awardTip1:Component;
      
      private var awardTip2:Component;
      
      private var awardTip3:Component;
      
      private var _awardBtn1:SimpleBitmapButton;
      
      private var _awardBtn2:SimpleBitmapButton;
      
      private var _awardBtn3:SimpleBitmapButton;
      
      public function BoguAdventureAwardFrame()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("tank.timeBox.awardsBtn");
         _bg = UICreatShortcut.creatAndAdd("boguAdventure.awardFrame.Bg",_container);
         _tipBg = UICreatShortcut.creatAndAdd("boguAdventure.awardFrame.tipBg",_container);
         _tipText = UICreatShortcut.creatTextAndAdd("boguAdventure.awardFrame.tipText",LanguageMgr.GetTranslation("boguAdventure.view.awardFrameText"),_container);
         _awardTipText1 = UICreatShortcut.creatAndAdd("boguAdventure.awardFrame.waradText",_container);
         _awardTipText2 = UICreatShortcut.creatAndAdd("boguAdventure.awardFrame.waradText",_container);
         _awardTipText3 = UICreatShortcut.creatAndAdd("boguAdventure.awardFrame.waradText",_container);
         _awardBtn1 = UICreatShortcut.creatAndAdd("boguAdventure.awardFrame.awardBtn",_container);
         _awardBtn2 = UICreatShortcut.creatAndAdd("boguAdventure.awardFrame.awardBtn",_container);
         _awardBtn3 = UICreatShortcut.creatAndAdd("boguAdventure.awardFrame.awardBtn",_container);
         awardTip1 = UICreatShortcut.creatAndAdd("boguAdventure.awardFrame.awardTip",_container);
         awardTip2 = UICreatShortcut.creatAndAdd("boguAdventure.awardFrame.awardTip",_container);
         awardTip3 = UICreatShortcut.creatAndAdd("boguAdventure.awardFrame.awardTip",_container);
         createAwardTip(awardTip1);
         createAwardTip(awardTip2);
         createAwardTip(awardTip3);
         PositionUtils.setPos(_awardTipText1,"boguAdventure.awardFrame.textPos1");
         PositionUtils.setPos(_awardTipText2,"boguAdventure.awardFrame.textPos2");
         PositionUtils.setPos(_awardTipText3,"boguAdventure.awardFrame.textPos3");
         PositionUtils.setPos(_awardBtn1,"boguAdventure.awardFrame.awardBtnPos1");
         PositionUtils.setPos(_awardBtn2,"boguAdventure.awardFrame.awardBtnPos2");
         PositionUtils.setPos(_awardBtn3,"boguAdventure.awardFrame.awardBtnPos3");
         PositionUtils.setPos(awardTip1,"boguAdventure.awardFrame.awardTipPos1");
         PositionUtils.setPos(awardTip2,"boguAdventure.awardFrame.awardTipPos2");
         PositionUtils.setPos(awardTip3,"boguAdventure.awardFrame.awardTipPos3");
         _awardBtn1.addEventListener("click",__onAwardClick);
         _awardBtn2.addEventListener("click",__onAwardClick);
         _awardBtn3.addEventListener("click",__onAwardClick);
      }
      
      public function set control(param1:BoguAdventureControl) : void
      {
         _control = param1;
         updateBtnView();
      }
      
      private function updateBtnView() : void
      {
         _awardBtn1.enable = _control.model.openCount >= int(_control.model.awardCount[0]) && !_control.model.isAcquireAward1;
         _awardBtn2.enable = _control.model.openCount >= int(_control.model.awardCount[1]) && !_control.model.isAcquireAward2;
         _awardBtn3.enable = _control.model.openCount >= int(_control.model.awardCount[2]) && !_control.model.isAcquireAward3;
         awardTip1.tipData = _control.model.awardGoodsTip[0];
         awardTip2.tipData = _control.model.awardGoodsTip[1];
         awardTip3.tipData = _control.model.awardGoodsTip[2];
         _awardTipText1.text = LanguageMgr.GetTranslation("boguAdventure.view.successfulWalkCount",_control.model.awardCount[0]);
         _awardTipText2.text = LanguageMgr.GetTranslation("boguAdventure.view.successfulWalkCount",_control.model.awardCount[1]);
         _awardTipText3.text = LanguageMgr.GetTranslation("boguAdventure.view.successfulWalkCount",_control.model.awardCount[2]);
      }
      
      private function __onAwardClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(param1.currentTarget == _awardBtn1)
         {
            _level = 0;
         }
         else if(param1.currentTarget == _awardBtn2)
         {
            _level = 1;
         }
         else
         {
            _level = 2;
         }
         sendAwardAlter();
      }
      
      private function sendAwardAlter() : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(_control.model.openCount < int(_control.model.awardCount[_level]))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("boguAdventure.view.openAwardError"));
            return;
         }
         if(_control.model.isAcquireAward1 && _control.model.isAcquireAward2 && _control.model.isAcquireAward3)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("boguAdventure.view.awardComplete"));
            return;
         }
         SocketManager.Instance.out.sendBoguAdventureAcquireAward(_level);
         dispose();
      }
      
      private function createAwardTip(param1:Sprite) : void
      {
         param1.graphics.beginFill(0,0.1);
         param1.graphics.drawRect(0,0,param1.width,param1.height);
         param1.graphics.endFill();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,2);
      }
      
      override protected function onResponse(param1:int) : void
      {
         super.onResponse(param1);
         if(param1 == 1 || param1 == 0)
         {
            SoundManager.instance.playButtonSound();
            ObjectUtils.disposeObject(this);
         }
      }
      
      override public function dispose() : void
      {
         _control = null;
         _awardBtn1.removeEventListener("click",__onAwardClick);
         _awardBtn2.removeEventListener("click",__onAwardClick);
         _awardBtn3.removeEventListener("click",__onAwardClick);
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_tipBg);
         _tipBg = null;
         ObjectUtils.disposeObject(_tipText);
         _tipText = null;
         ObjectUtils.disposeObject(_awardBtn1);
         _awardBtn1 = null;
         ObjectUtils.disposeObject(_awardBtn2);
         _awardBtn2 = null;
         ObjectUtils.disposeObject(_awardBtn3);
         _awardBtn3 = null;
         ObjectUtils.disposeObject(_awardTipText1);
         _awardTipText1 = null;
         ObjectUtils.disposeObject(_awardTipText2);
         _awardTipText2 = null;
         ObjectUtils.disposeObject(_awardTipText3);
         _awardTipText3 = null;
         super.dispose();
      }
   }
}
