package collectionTask.view
{
   import collectionTask.CollectionTaskManager;
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
   import ddt.manager.StateManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class CollectionTaskExitMenuView extends Sprite implements Disposeable
   {
       
      
      private var _menuIsOpen:Boolean = true;
      
      private var _BG:Bitmap;
      
      private var _moveOutBtn:SimpleBitmapButton;
      
      private var _moveInBtn:SimpleBitmapButton;
      
      private var _returnBtn:SimpleBitmapButton;
      
      public function CollectionTaskExitMenuView()
      {
         super();
         this.x = 909;
         this.y = 541;
         initialize();
         setEvent();
         setInOutVisible(true);
      }
      
      private function initialize() : void
      {
         _BG = ComponentFactory.Instance.creatBitmap("collectionTask.menuBG");
         addChild(_BG);
         _moveOutBtn = ComponentFactory.Instance.creatComponentByStylename("collectionTask.views.moveOutBtn");
         _moveInBtn = ComponentFactory.Instance.creatComponentByStylename("collectionTask.views.moveInBtn");
         _returnBtn = ComponentFactory.Instance.creatComponentByStylename("collectionTask.views.returnBtn");
         addChild(_moveOutBtn);
         addChild(_moveInBtn);
         addChild(_returnBtn);
      }
      
      private function setEvent() : void
      {
         _moveOutBtn.addEventListener("click",outHandler,false,0,true);
         _moveInBtn.addEventListener("click",inHandler,false,0,true);
         _returnBtn.addEventListener("click",exitHandler,false,0,true);
      }
      
      private function outHandler(event:MouseEvent) : void
      {
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
         SoundManager.instance.play("008");
         setInOutVisible(true);
         TweenLite.to(this,0.5,{"x":909});
      }
      
      private function exitHandler(event:MouseEvent) : void
      {
         var alert:* = null;
         SoundManager.instance.playButtonSound();
         if(!CollectionTaskManager.Instance.isTaskComplete)
         {
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("collectionTask.leaveScene"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
            alert.addEventListener("response",__frameResponse);
         }
         else
         {
            SocketManager.Instance.out.sendLeaveCollectionScene();
            StateManager.setState("main");
         }
      }
      
      private function __frameResponse(e:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var alert:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         alert.removeEventListener("response",__frameResponse);
         switch(int(e.responseCode))
         {
            case 0:
            case 1:
               alert.dispose();
               break;
            case 2:
            case 3:
            case 4:
               SocketManager.Instance.out.sendLeaveCollectionScene();
               StateManager.setState("main");
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
         _BG = null;
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
