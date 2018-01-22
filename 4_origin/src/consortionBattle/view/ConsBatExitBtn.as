package consortionBattle.view
{
   import com.greensock.TweenLite;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class ConsBatExitBtn extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _moveOutBtn:SimpleBitmapButton;
      
      private var _moveInBtn:SimpleBitmapButton;
      
      private var _returnBtn:SimpleBitmapButton;
      
      public function ConsBatExitBtn()
      {
         super();
         this.x = 909;
         this.y = 513;
         initView();
         initEvent();
         setInOutVisible(true);
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.consortiaBattle.returnBtn.bg");
         _moveOutBtn = ComponentFactory.Instance.creatComponentByStylename("consortiaBattle.moveOutBtn");
         _moveInBtn = ComponentFactory.Instance.creatComponentByStylename("consortiaBattle.moveInBtn");
         _returnBtn = ComponentFactory.Instance.creatComponentByStylename("consortiaBattle.returnBtn");
         addChild(_bg);
         addChild(_moveOutBtn);
         addChild(_moveInBtn);
         addChild(_returnBtn);
      }
      
      private function initEvent() : void
      {
         _moveOutBtn.addEventListener("click",outHandler,false,0,true);
         _moveInBtn.addEventListener("click",inHandler,false,0,true);
         _returnBtn.addEventListener("click",exitHandler,false,0,true);
      }
      
      private function outHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         setInOutVisible(false);
         TweenLite.to(this,0.5,{"x":966});
      }
      
      private function setInOutVisible(param1:Boolean) : void
      {
         _moveOutBtn.visible = param1;
         _moveInBtn.visible = !param1;
      }
      
      private function inHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         setInOutVisible(true);
         TweenLite.to(this,0.5,{"x":909});
      }
      
      private function exitHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("ddt.consortiaBattle.leavePromptTxt"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
         _loc2_.moveEnable = false;
         _loc2_.addEventListener("response",__exitConfirm,false,0,true);
      }
      
      private function __exitConfirm(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",__exitConfirm);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            SocketManager.Instance.out.sendConsBatExit();
         }
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
         if(_returnBtn)
         {
            _returnBtn.removeEventListener("click",exitHandler);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _moveOutBtn = null;
         _moveInBtn = null;
         _returnBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
