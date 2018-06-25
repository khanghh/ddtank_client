package catchInsect.componets
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class RoomMenuView extends Sprite implements Disposeable
   {
       
      
      private var _menuIsOpen:Boolean = true;
      
      private var _BG:Bitmap;
      
      private var _closeBtn:SimpleBitmapButton;
      
      private var _switchIMG:ScaleFrameImage;
      
      private var _returnBtn:SimpleBitmapButton;
      
      private var _backAlertFrame:BaseAlerFrame;
      
      public function RoomMenuView()
      {
         super();
         initialize();
      }
      
      private function initialize() : void
      {
         _BG = ComponentFactory.Instance.creatBitmap("catchInsect.room.menuBG");
         addChild(_BG);
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("catchInsect.room.switchBtn");
         addChild(_closeBtn);
         _switchIMG = ComponentFactory.Instance.creatComponentByStylename("catchInsect.room.switchIMG");
         _switchIMG.setFrame(1);
         _closeBtn.addChild(_switchIMG);
         _returnBtn = ComponentFactory.Instance.creatComponentByStylename("catchInsect.room.returnBtn");
         addChild(_returnBtn);
         setEvent();
      }
      
      private function setEvent() : void
      {
         _returnBtn.addEventListener("click",backRoomList);
         _closeBtn.addEventListener("click",switchMenu);
      }
      
      private function backRoomList(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _backAlertFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("catchInsect.leavingScene"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
         _backAlertFrame.addEventListener("response",__frameResponse);
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
               SocketManager.Instance.out.enterOrLeaveInsectScene(1);
               SoundManager.instance.play("008");
               dispatchEvent(new Event("close"));
         }
      }
      
      private function switchMenu(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_menuIsOpen)
         {
            _switchIMG.setFrame(2);
         }
         else
         {
            _switchIMG.setFrame(1);
         }
         addEventListener("enterFrame",menuShowOrHide);
      }
      
      private function menuShowOrHide(evt:Event) : void
      {
         var offset:int = 34;
         if(_menuIsOpen)
         {
            this.x = this.x + 20;
            if(this.x >= StageReferance.stageWidth - offset)
            {
               removeEventListener("enterFrame",menuShowOrHide);
               this.x = StageReferance.stageWidth - offset;
               _menuIsOpen = false;
            }
         }
         else
         {
            this.x = this.x - 20;
            if(this.x <= StageReferance.stageWidth - this.width)
            {
               removeEventListener("enterFrame",menuShowOrHide);
               this.x = StageReferance.stageWidth - this.width + 5;
               _menuIsOpen = true;
            }
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_backAlertFrame);
         _backAlertFrame = null;
         ObjectUtils.disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         ObjectUtils.disposeObject(_switchIMG);
         _BG = null;
         _closeBtn = null;
         _switchIMG = null;
         _returnBtn = null;
      }
   }
}
