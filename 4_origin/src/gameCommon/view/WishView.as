package gameCommon.view
{
   import baglocked.BaglockedManager;
   import com.greensock.TweenMax;
   import com.greensock.easing.Elastic;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.LivingEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import gameCommon.GameControl;
   import gameCommon.model.LocalPlayer;
   
   public class WishView extends Sprite implements Disposeable
   {
      
      public static const WISH_CLICK:String = "wishClick";
       
      
      private const MOVE_DISTANCE:int = 150;
      
      private var _wishButtom:BaseButton;
      
      private var _timesRecording:Number;
      
      private var _text:FilterFrameText;
      
      private var _self:LocalPlayer;
      
      private var _level:int;
      
      private var _isFirstWish:Boolean;
      
      private var _textBg:ScaleBitmapImage;
      
      private var _panelBtn:SelectedButton;
      
      private var _useReduceEnerge:int;
      
      private var _freeTimes:int;
      
      public function WishView(info:LocalPlayer, pop:Boolean)
      {
         var level:int = 0;
         super();
         _self = info;
         _level = _self.playerInfo.Grade;
         _timesRecording = 1;
         _isFirstWish = SharedManager.Instance.isFirstWish;
         _wishButtom = ComponentFactory.Instance.creatComponentByStylename("wishView.wishBtn");
         _wishButtom.enable = false;
         if(PlayerManager.Instance.Self.IsVIP)
         {
            level = PlayerManager.Instance.Self.VIPLevel;
            _useReduceEnerge = int(ServerConfigManager.instance.VIPPayAimEnergy[level - 1]);
         }
         else
         {
            _useReduceEnerge = ServerConfigManager.instance.PayAimEnergy;
         }
         _wishButtom.tipData = LanguageMgr.GetTranslation("ddt.games.wishofdd",_useReduceEnerge);
         addChild(_wishButtom);
         _textBg = ComponentFactory.Instance.creatComponentByStylename("core.wishView.bg");
         addChild(_textBg);
         _panelBtn = ComponentFactory.Instance.creatComponentByStylename("core.wishView.panelBtn");
         _panelBtn.tipData = LanguageMgr.GetTranslation("ddt.games.wishofdd",_useReduceEnerge);
         addChild(_panelBtn);
         _text = ComponentFactory.Instance.creatComponentByStylename("wishView.spandTicket");
         freeTimes = GameControl.Instance.Current.selfGamePlayer.wishFreeTime;
         addChild(_text);
         addEvent();
         initPosition(pop);
         stateInit();
      }
      
      protected function addEvent() : void
      {
         _wishButtom.addEventListener("click",__wishBtnClick);
         _panelBtn.addEventListener("click",__movePanle);
         _self.addEventListener("energyChanged",__ennergChange);
         SocketManager.Instance.addEventListener("playerChange",__playerChange);
         SharedManager.Instance.addEventListener("transparentChanged",__transparentChanged);
      }
      
      private function stateInit() : void
      {
         if(_self.isLiving)
         {
            if((PlayerManager.Instance.Self.Money > needMoney || freeTimes > 0) && _self.energy > _useReduceEnerge)
            {
               _wishButtom.enable = true;
               _text.setFrame(1);
            }
            else
            {
               _wishButtom.enable = false;
               _text.setFrame(2);
            }
         }
      }
      
      protected function __transparentChanged(SharedEvent:Event) : void
      {
         if(parent)
         {
            if(SharedManager.Instance.propTransparent)
            {
               alpha = 0.5;
            }
            else
            {
               alpha = 1;
            }
         }
      }
      
      private function __movePanle(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_panelBtn.selected)
         {
            TweenMax.to(this,0.5,{
               "x":-150,
               "ease":Elastic.easeOut
            });
         }
         else
         {
            TweenMax.to(this,0.5,{
               "x":0,
               "ease":Elastic.easeOut
            });
         }
         SharedManager.Instance.isWishPop = _panelBtn.selected;
         SharedManager.Instance.save();
      }
      
      protected function removeEvent() : void
      {
         _wishButtom.removeEventListener("click",__wishBtnClick);
         _panelBtn.removeEventListener("click",__movePanle);
         _self.removeEventListener("energyChanged",__ennergChange);
         SocketManager.Instance.removeEventListener("playerChange",__playerChange);
         SharedManager.Instance.removeEventListener("transparentChanged",__transparentChanged);
      }
      
      public function get freeTimes() : int
      {
         return _freeTimes;
      }
      
      public function set freeTimes(value:int) : void
      {
         _freeTimes = value;
         if(_freeTimes > 0)
         {
            _text.text = LanguageMgr.GetTranslation("ddt.games.spandFreeTimes",_freeTimes);
         }
         else
         {
            _text.text = LanguageMgr.GetTranslation("ddt.games.spandTicket",needMoney);
         }
      }
      
      private function __playerChange(event:CrazyTankSocketEvent) : void
      {
         stateInit();
      }
      
      private function __ennergChange(event:LivingEvent) : void
      {
         if(_wishButtom.enable)
         {
            stateInit();
         }
      }
      
      protected function get needMoney() : Number
      {
         return int(0.1 * _level * Math.pow(2,_timesRecording - 1)) + 2;
      }
      
      protected function __wishBtnClick(event:MouseEvent) : void
      {
         var reduce:int = 0;
         SoundManager.instance.play("008");
         if(_isFirstWish)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.games.FirstWish"));
            SharedManager.Instance.isFirstWish = false;
            SharedManager.Instance.save();
         }
         if(_timesRecording >= 10 && PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
         }
         else if(_self.isLiving && _self.isAttacking)
         {
            SocketManager.Instance.out.sendWish();
            if(_freeTimes <= 0)
            {
               _timesRecording = Number(_timesRecording) + 1;
            }
            _wishButtom.enable = false;
            _self.energy = _self.energy - _useReduceEnerge;
            dispatchEvent(new Event("wishClick"));
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.games.cannotuse"));
         }
      }
      
      private function initPosition(isPop:Boolean) : void
      {
         if(isPop)
         {
            this.x = -150;
            _panelBtn.selected = true;
         }
         else
         {
            _panelBtn.selected = false;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_wishButtom)
         {
            ObjectUtils.disposeObject(_wishButtom);
            _wishButtom = null;
         }
         if(_text)
         {
            ObjectUtils.disposeObject(_text);
            _text = null;
         }
      }
   }
}
