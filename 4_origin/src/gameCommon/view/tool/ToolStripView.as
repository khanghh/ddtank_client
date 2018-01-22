package gameCommon.view.tool
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.LivingEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.IMManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SharedManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import ddt.view.chat.RightChatFacePanel;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import gameCommon.GameControl;
   import org.aswing.KeyboardManager;
   import setting.controll.SettingController;
   import trainer.view.GhostTipFrame;
   
   public class ToolStripView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _faceBtn:SimpleBitmapButton;
      
      private var _fastMovie:MovieClip;
      
      private var _fastChatBtn:SimpleBitmapButton;
      
      private var _bloodStrip:BloodStrip;
      
      private var _powerStrip:PowerStrip;
      
      private var _facePanelPos:Point;
      
      private var _center:Bitmap;
      
      private var _transparentBtn:BaseButton;
      
      private var _startDate:Date;
      
      private var _facePanel:RightChatFacePanel;
      
      private var _danderBar:DanderBar;
      
      private var _frame:int;
      
      public function ToolStripView()
      {
         super();
         initView();
         initEvents();
         _startDate = TimeManager.Instance.Now();
      }
      
      private function initView() : void
      {
         mouseEnabled = false;
         _bg = ComponentFactory.Instance.creatBitmap("asset.game.health.back");
         addChild(_bg);
         _bloodStrip = new BloodStrip();
         var _loc1_:Point = ComponentFactory.Instance.creatCustomObject("asset.game.bloodStripPos");
         _bloodStrip.x = _loc1_.x;
         _bloodStrip.y = _loc1_.y;
         addChild(_bloodStrip);
         _danderBar = new DanderBar(GameControl.Instance.Current.selfGamePlayer,this);
         _danderBar.x = 120;
         _danderBar.y = 1;
         addChild(_danderBar);
         _faceBtn = ComponentFactory.Instance.creatComponentByStylename("asset.game.faceButton");
         setTip(_faceBtn,LanguageMgr.GetTranslation("tank.game.ToolStripView.face"));
         addChild(_faceBtn);
         _fastChatBtn = ComponentFactory.Instance.creatComponentByStylename("asset.game.chatButton");
         setTip(_fastChatBtn,LanguageMgr.GetTranslation("tank.game.ToolStripView.chat"));
         addChild(_fastChatBtn);
         _fastMovie = ClassUtils.CreatInstance("asset.game.prop.chatMoive") as MovieClip;
         PositionUtils.setPos(_fastMovie,"asset.game.chatmoviePos");
         _fastChatBtn.addChild(_fastMovie);
         if(IMManager.Instance.hasUnreadMessage() && !IMManager.Instance.cancelflashState)
         {
            _fastMovie.gotoAndPlay(1);
         }
         else
         {
            _fastMovie.gotoAndStop(_fastMovie.totalFrames);
         }
         _facePanel = ComponentFactory.Instance.creatCustomObject("chat.rightFacePanel",[true]);
         _facePanelPos = ComponentFactory.Instance.creatCustomObject("asset.game.facePanelView");
         _powerStrip = new PowerStrip();
         var _loc2_:Point = ComponentFactory.Instance.creatCustomObject("asset.game.powerStripPos");
         _powerStrip.x = _loc2_.x;
         _powerStrip.y = _loc2_.y;
         addChild(_powerStrip);
         _transparentBtn = ComponentFactory.Instance.creatComponentByStylename("asset.game.TransparentButton");
         setTip(_transparentBtn,LanguageMgr.GetTranslation("tank.game.ToolStripView.transparent"));
         addChild(_transparentBtn);
      }
      
      private function setTip(param1:BaseButton, param2:String) : void
      {
         param1.tipStyle = "ddt.view.tips.OneLineTip";
         param1.tipDirctions = "0";
         param1.tipGapV = 5;
         param1.tipData = param2;
      }
      
      private function initEvents() : void
      {
         _faceBtn.addEventListener("click",__face);
         _fastChatBtn.addEventListener("click",__fastChat);
         _fastChatBtn.addEventListener("mouseOver",__overHandler);
         _fastChatBtn.addEventListener("mouseOut",__outHandler);
         _facePanel.addEventListener("select",__onFaceSelect);
         _transparentBtn.addEventListener("click",__transparentChanged);
         IMManager.Instance.addEventListener("hasNewMessage",__hasNewHandler);
         IMManager.Instance.addEventListener("nomessage",__noMessageHandler);
      }
      
      protected function __noMessageHandler(param1:Event) : void
      {
         _fastMovie.gotoAndStop(_fastMovie.totalFrames);
      }
      
      protected function __hasNewHandler(param1:Event) : void
      {
         _fastMovie.gotoAndPlay(1);
      }
      
      protected function __overHandler(param1:MouseEvent) : void
      {
         if(KeyboardManager.isDown(32))
         {
            return;
         }
         IMManager.Instance.showMessageBox(_faceBtn);
      }
      
      protected function __outHandler(param1:MouseEvent) : void
      {
         IMManager.Instance.hideMessageBox();
      }
      
      protected function __transparentChanged(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         SharedManager.Instance.propTransparent = !SharedManager.Instance.propTransparent;
      }
      
      private function removeEvents() : void
      {
         _fastChatBtn.removeEventListener("click",__fastChat);
         _fastChatBtn.removeEventListener("mouseOver",__overHandler);
         _fastChatBtn.removeEventListener("mouseOut",__outHandler);
         _facePanel.removeEventListener("select",__onFaceSelect);
         _transparentBtn.removeEventListener("click",__transparentChanged);
         IMManager.Instance.removeEventListener("hasNewMessage",__hasNewHandler);
         IMManager.Instance.removeEventListener("nomessage",__noMessageHandler);
      }
      
      public function dispose() : void
      {
         removeEvents();
         _facePanel.dispose();
         _facePanel = null;
         if(_bloodStrip)
         {
            if(_bloodStrip.parent)
            {
               _bloodStrip.parent.removeChild(_bloodStrip);
            }
            _bloodStrip.dispose();
         }
         _bloodStrip = null;
         if(_powerStrip)
         {
            if(_powerStrip.parent)
            {
               _powerStrip.parent.removeChild(_powerStrip);
            }
            _powerStrip.dispose();
         }
         _powerStrip = null;
         if(_faceBtn)
         {
            if(_faceBtn.parent)
            {
               _faceBtn.parent.removeChild(_faceBtn);
            }
            _faceBtn.dispose();
         }
         if(_fastMovie)
         {
            ObjectUtils.disposeObject(_fastMovie);
            _fastMovie = null;
         }
         _faceBtn = null;
         if(_fastChatBtn)
         {
            if(_fastChatBtn.parent)
            {
               _fastChatBtn.parent.removeChild(_fastChatBtn);
            }
            _fastChatBtn.dispose();
         }
         _fastChatBtn = null;
         ObjectUtils.disposeObject(_danderBar);
         _danderBar = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      private function __fastChat(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         param1.stopImmediatePropagation();
         ChatManager.Instance.switchVisible();
      }
      
      private function __setBtn(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         SettingController.Instance.switchVisible();
      }
      
      private function __face(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _facePanel.x = localToGlobal(new Point(_facePanelPos.x,_facePanelPos.y)).x;
         _facePanel.y = localToGlobal(new Point(_facePanelPos.x,_facePanelPos.y)).y;
         _facePanel.setVisible = true;
      }
      
      private function __onFaceSelect(param1:Event) : void
      {
         ChatManager.Instance.sendFace(_facePanel.selected);
         _facePanel.setVisible = false;
         StageReferance.stage.focus = null;
      }
      
      private function __im(param1:MouseEvent) : void
      {
         IMManager.Instance.show();
         SoundManager.instance.play("008");
      }
      
      private function updateDander(param1:int) : void
      {
      }
      
      private function __dander(param1:LivingEvent) : void
      {
         if(GameControl.Instance.Current.selfGamePlayer.isLiving)
         {
            updateDander(GameControl.Instance.Current.selfGamePlayer.dander);
         }
      }
      
      private function __ok() : void
      {
         if(StateManager.currentStateType == "fighting" || StateManager.currentStateType == "fighting3d" || StateManager.currentStateType == "fightLabGameView")
         {
            mouseChildren = false;
            GameInSocketOut.sendGamePlayerExit();
            SoundManager.instance.play("008");
         }
      }
      
      private function __cancel() : void
      {
         SoundManager.instance.play("008");
      }
      
      private function __die(param1:LivingEvent) : void
      {
         updateDander(0);
         showDeadTip();
      }
      
      private function showDeadTip() : void
      {
         var _loc1_:* = null;
         if(GameControl.Instance.Current.selfGamePlayer.playerInfo.Grade >= 10)
         {
            return;
         }
         if(!GameControl.Instance.Current.haveAllias)
         {
            return;
         }
         if(SharedManager.Instance.deadtip < 2)
         {
            SharedManager.Instance.deadtip++;
            _loc1_ = ComponentFactory.Instance.creat("GhostTip");
            LayerManager.Instance.addToLayer(_loc1_,3,true,1);
         }
      }
      
      public function set specialEnabled(param1:Boolean) : void
      {
         _danderBar.specialEnabled = param1;
      }
      
      public function setDanderEnable(param1:Boolean) : void
      {
         _danderBar.setVisible(param1);
      }
   }
}
