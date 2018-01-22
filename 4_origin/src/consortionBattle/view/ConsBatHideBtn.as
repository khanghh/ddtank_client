package consortionBattle.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import consortionBattle.ConsortiaBattleManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.setTimeout;
   
   public class ConsBatHideBtn extends Sprite implements Disposeable
   {
       
      
      private var _btn:SimpleBitmapButton;
      
      private var _tip:ConsBatHideTip;
      
      private var _isOverTip:Boolean = false;
      
      private var _isOverBtn:Boolean = false;
      
      public function ConsBatHideBtn()
      {
         super();
         this.x = 782;
         this.y = 16;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _btn = ComponentFactory.Instance.creatComponentByStylename("consortiaBattle.hideBtn.btn");
         refreshBtnStatus();
         _tip = new ConsBatHideTip();
         PositionUtils.setPos(_tip,"consortiaBattle.hideTipPos");
         addChild(_btn);
      }
      
      private function refreshBtnStatus() : void
      {
         if(!_btn)
         {
            return;
         }
         if(!ConsortiaBattleManager.instance.isHide(1) && !ConsortiaBattleManager.instance.isHide(2) && !ConsortiaBattleManager.instance.isHide(3))
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
         _btn.addEventListener("mouseOver",overHandler,false,0,true);
         _btn.addEventListener("mouseOut",outHandler,false,0,true);
         _btn.addEventListener("click",clickHandler,false,0,true);
         _tip.addEventListener("mouseOver",overHandler,false,0,true);
         _tip.addEventListener("mouseOut",outHandler,false,0,true);
         _tip.addEventListener("consBatHideTip_selected_change",selectedChangeHandler,false,0,true);
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(ConsortiaBattleManager.instance.isHide(1) && ConsortiaBattleManager.instance.isHide(2) && ConsortiaBattleManager.instance.isHide(3))
         {
            _tip.showAll();
         }
         else
         {
            _tip.hideAll();
         }
         refreshBtnStatus();
      }
      
      private function overHandler(param1:MouseEvent) : void
      {
         if(param1.currentTarget == _tip)
         {
            _isOverTip = true;
         }
         if(param1.currentTarget == _btn)
         {
            _isOverBtn = true;
         }
         if(!contains(_tip))
         {
            addChild(_tip);
         }
      }
      
      private function outHandler(param1:MouseEvent) : void
      {
         if(param1.currentTarget == _tip)
         {
            _isOverTip = false;
         }
         if(param1.currentTarget == _btn)
         {
            _isOverBtn = false;
         }
      }
      
      private function delayRemoveTip() : void
      {
         if(contains(_tip) && !_isOverTip && !_isOverBtn)
         {
            removeChild(_tip);
         }
      }
      
      private function removeEvent() : void
      {
         if(_btn)
         {
            _btn.removeEventListener("mouseOver",overHandler);
            _btn.removeEventListener("mouseOut",outHandler);
            _btn.removeEventListener("click",clickHandler);
         }
         if(_tip)
         {
            _tip.removeEventListener("mouseOver",overHandler);
            _tip.removeEventListener("mouseOut",outHandler);
            _tip.removeEventListener("consBatHideTip_selected_change",selectedChangeHandler);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _btn = null;
         _tip = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
