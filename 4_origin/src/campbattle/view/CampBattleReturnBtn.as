package campbattle.view
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class CampBattleReturnBtn extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _moveOutBtn:SimpleBitmapButton;
      
      private var _moveInBtn:SimpleBitmapButton;
      
      public var returnBtn:SimpleBitmapButton;
      
      private var _isDice:Boolean;
      
      public function CampBattleReturnBtn()
      {
         super();
         initView();
         initEvent();
         setInOutVisible(true);
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.returnBtn.bg");
         _moveOutBtn = ComponentFactory.Instance.creatComponentByStylename("asset.views.moveOutBtn");
         _moveInBtn = ComponentFactory.Instance.creatComponentByStylename("asset.views.moveInBtn");
         returnBtn = ComponentFactory.Instance.creatComponentByStylename("asset.views.returnBtn");
         addChild(_bg);
         addChild(_moveOutBtn);
         addChild(_moveInBtn);
         addChild(returnBtn);
      }
      
      private function initEvent() : void
      {
         _moveOutBtn.addEventListener("click",outHandler,false,0,true);
         _moveInBtn.addEventListener("click",inHandler,false,0,true);
         returnBtn.addEventListener("click",exitHandler,false,0,true);
      }
      
      private function outHandler(event:MouseEvent) : void
      {
         event.stopImmediatePropagation();
         SoundManager.instance.play("008");
         setInOutVisible(false);
         TweenLite.to(this,0.5,{"x":966});
      }
      
      private function setInOutVisible(isOut:Boolean) : void
      {
         _moveOutBtn.visible = isOut;
         _moveInBtn.visible = !isOut;
      }
      
      private function inHandler(event:MouseEvent) : void
      {
         event.stopImmediatePropagation();
         SoundManager.instance.play("008");
         setInOutVisible(true);
         TweenLite.to(this,0.5,{"x":909});
      }
      
      private function exitHandler(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
      }
      
      private function removeEvent() : void
      {
         if(_moveOutBtn)
         {
            _moveOutBtn.removeEventListener("click",outHandler);
         }
         if(_moveInBtn)
         {
            _moveInBtn.removeEventListener("click",inHandler);
         }
         if(returnBtn)
         {
            returnBtn.removeEventListener("click",exitHandler);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _moveOutBtn = null;
         _moveInBtn = null;
         returnBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
