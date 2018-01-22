package worldboss.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import ddt.view.DailyButtunBar;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import worldboss.WorldBossManager;
   import worldboss.event.WorldBossRoomEvent;
   
   public class WorldBossHideBtn extends Sprite implements Disposeable
   {
       
      
      private var _btn:SimpleBitmapButton;
      
      private var _isOverTip:Boolean = false;
      
      private var _isOverBtn:Boolean = false;
      
      private var _isShow:Boolean = true;
      
      public function WorldBossHideBtn()
      {
         super();
         this.x = 909;
         this.y = 16;
         _isShow = !DailyButtunBar.Insance.hideFlag;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _btn = ComponentFactory.Instance.creatComponentByStylename("worldBoss.hideBtn.btn");
         refreshBtnStatus();
         addChild(_btn);
      }
      
      private function refreshBtnStatus() : void
      {
         if(!_btn)
         {
            return;
         }
         if(_isShow)
         {
            (_btn.backgound as MovieClip)["mc"].gotoAndStop(2);
         }
         else
         {
            (_btn.backgound as MovieClip)["mc"].gotoAndStop(1);
         }
      }
      
      private function selectedChangeHandler(param1:Event) : void
      {
         refreshBtnStatus();
      }
      
      private function initEvent() : void
      {
         _btn.addEventListener("click",clickHandler,false,0,true);
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _isShow = !_isShow;
         refreshBtnStatus();
         WorldBossManager.Instance.dispatchEvent(new WorldBossRoomEvent("worldBossHidePlayerChange",_isShow));
      }
      
      private function removeEvent() : void
      {
         if(_btn)
         {
            _btn.removeEventListener("click",clickHandler);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _btn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
