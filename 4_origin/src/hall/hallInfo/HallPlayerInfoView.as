package hall.hallInfo
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.buff.BuffControl;
   import ddt.view.buff.BuffControlManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import hall.hallInfo.playerInfo.HallRefreshableServerDropList;
   import hall.hallInfo.playerInfo.PlayerFighterPower;
   import hall.hallInfo.playerInfo.PlayerHead;
   import hall.hallInfo.playerInfo.PlayerTool;
   import hall.hallInfo.playerInfo.PlayerVIP;
   import playerDress.event.PlayerDressEvent;
   
   public class HallPlayerInfoView extends Sprite
   {
       
      
      private var _sprite:Sprite;
      
      private var _bg:Bitmap;
      
      private var _head:PlayerHead;
      
      private var _fighterPower:PlayerFighterPower;
      
      private var _vip:PlayerVIP;
      
      private var _buff:BuffControl;
      
      private var _toolBtn:PlayerTool;
      
      private var _showHideBtn:ScaleFrameImage;
      
      private var _showAnimation:MovieClip;
      
      private var _serverlist:HallRefreshableServerDropList;
      
      public function HallPlayerInfoView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _sprite = new Sprite();
         addChild(_sprite);
         _bg = ComponentFactory.Instance.creat("asset.hall.playerInfoBg");
         _sprite.addChild(_bg);
         _head = new PlayerHead();
         PositionUtils.setPos(_head,"hall.playerInfoview.headPos");
         _sprite.addChild(_head);
         _fighterPower = new PlayerFighterPower();
         PositionUtils.setPos(_fighterPower,"hall.playerInfoview.bloodPos");
         _sprite.addChild(_fighterPower);
         _vip = new PlayerVIP();
         PositionUtils.setPos(_vip,"hall.playerInfoview.vipPos");
         _sprite.addChild(_vip);
         _buff = BuffControlManager.instance.buff;
         PositionUtils.setPos(_buff,"hall.playerInfo.buffPos");
         _sprite.addChild(_buff);
         _toolBtn = new PlayerTool();
         PositionUtils.setPos(_toolBtn,"hall.playerInfoview.toolPos");
         _sprite.addChild(_toolBtn);
         _serverlist = new HallRefreshableServerDropList();
         PositionUtils.setPos(_serverlist,"hall.playerInfoview.refresh.serverlistPos");
         _sprite.addChild(_serverlist);
         _showHideBtn = ComponentFactory.Instance.creatComponentByStylename("hall.playerInfo.showHideBtn");
         addChild(_showHideBtn);
         _showHideBtn.buttonMode = true;
         _showHideBtn.setFrame(1);
         showShowHideAnimation();
      }
      
      private function showShowHideAnimation() : void
      {
         if(!PlayerManager.Instance.Self.isNewOnceFinish(134))
         {
            _showAnimation = ComponentFactory.Instance.creat("asset.hall.playerInfo.showHideAnimation");
            PositionUtils.setPos(_showAnimation,_showHideBtn);
            addChild(_showAnimation);
            var _loc1_:Boolean = false;
            _showAnimation.mouseChildren = _loc1_;
            _showAnimation.mouseEnabled = _loc1_;
            SocketManager.Instance.out.syncWeakStep(134);
         }
      }
      
      public function __updatePlayerInfo(param1:PlayerDressEvent) : void
      {
         _head.loadHead();
      }
      
      private function initEvent() : void
      {
         SocketManager.Instance.addEventListener("updatePlayerinfo",__updatePlayerInfo);
         SocketManager.Instance.addEventListener("showbuffcontrol",__showBuffControl);
         PlayerManager.Instance.Self.addEventListener("propertychange",__propertyChange);
         _showHideBtn.addEventListener("click",__onShowHideClick);
      }
      
      protected function __onShowHideClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         ObjectUtils.disposeObject(_showAnimation);
         _showAnimation = null;
         if(_showHideBtn.getFrame == 1)
         {
            _showHideBtn.setFrame(2);
            TweenLite.to(_sprite,0.3,{"x":-_bg.bitmapData.width});
         }
         else
         {
            _showHideBtn.setFrame(1);
            TweenLite.to(_sprite,0.3,{"x":0});
         }
      }
      
      private function __propertyChange(param1:PlayerPropertyEvent) : void
      {
         if(param1.changedProperties["FightPower"])
         {
            _fighterPower.update();
         }
      }
      
      protected function __showBuffControl(param1:Event) : void
      {
         if(_buff)
         {
            PositionUtils.setPos(_buff,"hall.playerInfo.buffPos");
            addChild(_buff);
         }
      }
      
      private function removeEvent() : void
      {
         SocketManager.Instance.removeEventListener("updatePlayerinfo",__updatePlayerInfo);
         SocketManager.Instance.removeEventListener("showbuffcontrol",__showBuffControl);
         PlayerManager.Instance.Self.removeEventListener("propertychange",__propertyChange);
         _showHideBtn.removeEventListener("click",__onShowHideClick);
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_bg)
         {
            _bg.bitmapData.dispose();
            _bg = null;
         }
         if(_fighterPower)
         {
            _fighterPower.dispose();
            _fighterPower = null;
         }
         if(_buff)
         {
            _buff.dispose();
            _buff = null;
            BuffControlManager.instance.buff = null;
         }
         if(_vip)
         {
            _vip.dispose();
            _vip = null;
         }
         if(_toolBtn)
         {
            _toolBtn.dispose();
            _toolBtn = null;
         }
         if(_head)
         {
            _head.dispose();
            _head = null;
         }
         ObjectUtils.disposeObject(_serverlist);
         _serverlist = null;
         ObjectUtils.disposeObject(_showHideBtn);
         _showHideBtn = null;
         ObjectUtils.disposeObject(_showAnimation);
         _showAnimation = null;
         ObjectUtils.disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      public function get toolBtn() : PlayerTool
      {
         return _toolBtn;
      }
   }
}
