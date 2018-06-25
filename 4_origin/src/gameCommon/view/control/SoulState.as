package gameCommon.view.control
{
   import com.greensock.TweenLite;
   import com.greensock.TweenMax;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ChatManager;
   import ddt.manager.IMManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.chat.ChatFacePanel;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import game.GameDecorateManager;
   import game.GameManager;
   import gameCommon.GameControl;
   import gameCommon.model.LocalPlayer;
   import gameCommon.view.prop.CustomPropBar;
   import gameCommon.view.prop.SoulPropBar;
   import gameStarling.view.GameViewBase3D;
   import org.aswing.KeyStroke;
   import org.aswing.KeyboardManager;
   
   public class SoulState extends ControlState
   {
       
      
      private var _psychicBar:PsychicBar;
      
      private var _psychicBar3D:PsychicBar3D;
      
      private var _propBar:SoulPropBar;
      
      private var _customPropBar:CustomPropBar;
      
      private var _tweenMax:TweenMax;
      
      private var _msgShape:DisplayObject;
      
      private var _fastChatBtn:SimpleBitmapButton;
      
      private var _faceBtn:SimpleBitmapButton;
      
      private var _fastMovie:MovieClip;
      
      private var _facePanel:ChatFacePanel;
      
      private var _facePanelPos:Point;
      
      private var _gameViewBtn:BaseButton;
      
      private var _freedomViewBtn:BaseButton;
      
      private var _isREleaseFours:Boolean;
      
      public function SoulState(self:LocalPlayer)
      {
         super(self);
         mouseEnabled = false;
      }
      
      override protected function configUI() : void
      {
         GameDecorateManager.Instance.createBitmapUI(this,"asset.gameDecorate.viewBg2-1");
         _background = ComponentFactory.Instance.creatBitmap("asset.game.SoulState.Back");
         addChild(_background);
         _tweenMax = TweenMax.to(_background,0.7,{
            "repeat":-1,
            "yoyo":true,
            "glowFilter":{
               "color":3305215,
               "alpha":0.8,
               "blurX":8,
               "blurY":8,
               "strength":2
            }
         });
         if(GameControl.Instance.is3DGame)
         {
            _psychicBar3D = ComponentFactory.Instance.creatCustomObject("PsychicBar3D",[_self]);
            addChild(_psychicBar3D);
         }
         else
         {
            _psychicBar = ComponentFactory.Instance.creatCustomObject("PsychicBar",[_self]);
            addChild(_psychicBar);
         }
         _customPropBar = ComponentFactory.Instance.creatCustomObject("SoulCustomPropBar",[_self,1]);
         addChild(_customPropBar);
         _propBar = ComponentFactory.Instance.creatCustomObject("SoulPropBar",[_self]);
         addChild(_propBar);
         _faceBtn = ComponentFactory.Instance.creatComponentByStylename("asset.game.faceButton");
         setTip(_faceBtn,LanguageMgr.GetTranslation("tank.game.ToolStripView.face"));
         addChild(_faceBtn);
         _facePanel = ComponentFactory.Instance.creatCustomObject("chat.FacePanel",[true]);
         _facePanelPos = ComponentFactory.Instance.creatCustomObject("asset.soulState.facePanelPos");
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
         PositionUtils.setPos(_faceBtn,"asset.soulState.facebtnPos");
         PositionUtils.setPos(_fastChatBtn,"asset.soulState.fastbtnPos");
         super.configUI();
         GameDecorateManager.Instance.createBitmapUI(this,"asset.gameDecorate.viewBg2-2");
         _gameViewBtn = ComponentFactory.Instance.creatComponentByStylename("game.soulState.gameView");
         addChild(_gameViewBtn);
         _gameViewBtn.tipData = LanguageMgr.GetTranslation("tank.game.gameView");
         _freedomViewBtn = ComponentFactory.Instance.creatComponentByStylename("game.soulState.stopViewMove");
         addChild(_freedomViewBtn);
         _freedomViewBtn.visible = false;
         _freedomViewBtn.tipData = LanguageMgr.GetTranslation("tank.game.freedomView");
      }
      
      private function setTip(btn:BaseButton, data:String) : void
      {
         btn.tipStyle = "ddt.view.tips.OneLineTip";
         btn.tipDirctions = "0";
         btn.tipGapV = 5;
         btn.tipData = data;
      }
      
      override protected function addEvent() : void
      {
         StageReferance.stage.addEventListener("enterFrame",__onFrame);
         _fastChatBtn.addEventListener("click",__fastChat);
         _fastChatBtn.addEventListener("mouseOver",__overHandler);
         _fastChatBtn.addEventListener("mouseOut",__outHandler);
         _faceBtn.addEventListener("click",__face);
         _facePanel.addEventListener("select",__onFaceSelect);
         IMManager.Instance.addEventListener("hasNewMessage",__hasNewHandler);
         IMManager.Instance.addEventListener("nomessage",__noMessageHandler);
         _gameViewBtn.addEventListener("click",__gameViewClickHandler);
         _freedomViewBtn.addEventListener("click",__freedomViewClickHandler);
      }
      
      protected function __noMessageHandler(event:Event) : void
      {
         _fastMovie.gotoAndStop(_fastMovie.totalFrames);
      }
      
      protected function __hasNewHandler(event:Event) : void
      {
         _fastMovie.gotoAndPlay(1);
      }
      
      protected function __onFaceSelect(event:Event) : void
      {
         ChatManager.Instance.sendFace(_facePanel.selected);
         _facePanel.setVisible = false;
         StageReferance.stage.focus = null;
      }
      
      protected function __face(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _facePanel.x = localToGlobal(new Point(_facePanelPos.x,_facePanelPos.y)).x;
         _facePanel.y = localToGlobal(new Point(_facePanelPos.x,_facePanelPos.y)).y;
         _facePanel.setVisible = true;
      }
      
      protected function __outHandler(event:MouseEvent) : void
      {
         IMManager.Instance.hideMessageBox();
      }
      
      protected function __overHandler(event:MouseEvent) : void
      {
         if(KeyboardManager.isDown(32))
         {
            return;
         }
         IMManager.Instance.showMessageBox(_fastChatBtn);
      }
      
      protected function __fastChat(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         event.stopImmediatePropagation();
         ChatManager.Instance.switchVisible();
      }
      
      private function __onFrame(evt:Event) : void
      {
         if(!(StageReferance.stage.focus is TextField) && KeyboardManager.isDown(KeyStroke.VK_SPACE.getCode()))
         {
            _self.setCenter(_self.pos.x,_self.pos.y,true);
            GameControl.Instance.gameView.map.lockFocusAt(new Point(_self.pos.x,_self.pos.y));
            _isREleaseFours = false;
         }
         else if(!_isREleaseFours)
         {
            if(GameControl.Instance.is3DGame)
            {
               (GameControl.Instance.gameView as GameViewBase3D).map.releaseFocus();
            }
            else
            {
               GameControl.Instance.gameView.map.releaseFocus();
            }
            _isREleaseFours = true;
         }
      }
      
      override protected function removeEvent() : void
      {
         StageReferance.stage.removeEventListener("enterFrame",__onFrame);
         StageReferance.stage.removeEventListener("mouseUp",__mouseUpInStep1);
         if(_fastChatBtn)
         {
            _fastChatBtn.removeEventListener("click",__fastChat);
            _fastChatBtn.removeEventListener("mouseOver",__overHandler);
            _fastChatBtn.removeEventListener("mouseOut",__outHandler);
         }
         if(_faceBtn)
         {
            _faceBtn.removeEventListener("click",__face);
         }
         if(_facePanel)
         {
            _facePanel.removeEventListener("select",__onFaceSelect);
         }
         IMManager.Instance.removeEventListener("hasNewMessage",__hasNewHandler);
         IMManager.Instance.removeEventListener("nomessage",__noMessageHandler);
         _gameViewBtn.removeEventListener("click",__gameViewClickHandler);
         _freedomViewBtn.removeEventListener("click",__freedomViewClickHandler);
      }
      
      private function __gameViewClickHandler(evt:MouseEvent) : void
      {
         changeView(true);
         _freedomViewBtn.visible = true;
         _gameViewBtn.visible = false;
      }
      
      private function __freedomViewClickHandler(evt:MouseEvent) : void
      {
         changeView(false);
         _gameViewBtn.visible = true;
         _freedomViewBtn.visible = false;
      }
      
      private function changeView(isStop:Boolean) : void
      {
         GameManager.instance.isStopFocus = isStop;
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.game.gameView.changeComplete"));
      }
      
      override public function enter(container:DisplayObjectContainer) : void
      {
         if(_psychicBar)
         {
            _psychicBar.enter();
         }
         if(_psychicBar3D)
         {
            _psychicBar3D.enter();
         }
         _customPropBar.enter();
         _propBar.enter();
         if(_tweenMax)
         {
            _tweenMax.play();
         }
         super.enter(container);
      }
      
      override public function leaving(onComplete:Function = null) : void
      {
         if(_tweenMax)
         {
            _tweenMax.pause();
         }
         super.leaving(onComplete);
      }
      
      override protected function tweenIn() : void
      {
         y = 600;
         TweenLite.to(this,0.3,{
            "y":503,
            "onComplete":enterComplete
         });
      }
      
      override protected function enterComplete() : void
      {
         if(!PlayerManager.Instance.Self.IsWeakGuildFinish(300))
         {
            _msgShape = ComponentFactory.Instance.creatBitmap("asset.game.ghost.msg1");
            _msgShape.x = StageReferance.stageWidth - _msgShape.width >> 1;
            _msgShape.y = (StageReferance.stageHeight - _msgShape.height >> 1) + _msgShape.height * 2;
            _msgShape.alpha = 0;
            _container.addChild(_msgShape);
            TweenLite.to(_msgShape,0.3,{
               "alpha":1,
               "y":StageReferance.stageHeight - _msgShape.height >> 1
            });
            StageReferance.stage.addEventListener("mouseUp",__mouseUpInStep1);
            SocketManager.Instance.out.syncWeakStep(300);
         }
      }
      
      protected function __mouseUpInStep1(event:MouseEvent) : void
      {
         StageReferance.stage.removeEventListener("mouseUp",__mouseUpInStep1);
         if(_msgShape)
         {
            TweenLite.killTweensOf(_msgShape);
         }
         ObjectUtils.disposeObject(_msgShape);
         _msgShape = null;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_fastChatBtn);
         _fastChatBtn = null;
         ObjectUtils.disposeObject(_faceBtn);
         _faceBtn = null;
         ObjectUtils.disposeObject(_fastMovie);
         _fastMovie = null;
         ObjectUtils.disposeObject(_facePanel);
         _facePanel = null;
         ObjectUtils.disposeObject(_psychicBar);
         _psychicBar = null;
         ObjectUtils.disposeObject(_psychicBar3D);
         _psychicBar3D = null;
         ObjectUtils.disposeObject(_customPropBar);
         _customPropBar = null;
         ObjectUtils.disposeObject(_propBar);
         _propBar = null;
         if(_msgShape)
         {
            TweenLite.killTweensOf(_msgShape);
         }
         ObjectUtils.disposeObject(_msgShape);
         _msgShape = null;
         if(_tweenMax)
         {
            _tweenMax.kill();
         }
         _tweenMax = null;
         super.dispose();
         ObjectUtils.disposeObject(_gameViewBtn);
         _gameViewBtn = null;
         ObjectUtils.disposeObject(_freedomViewBtn);
         _freedomViewBtn = null;
      }
   }
}
