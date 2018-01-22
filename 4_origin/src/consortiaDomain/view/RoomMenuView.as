package consortiaDomain.view
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import consortiaDomain.ConsortiaDomainManager;
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
      
      public function RoomMenuView()
      {
         super();
         initialize();
      }
      
      private function initialize() : void
      {
         _BG = ComponentFactory.Instance.creatBitmap("consortiadomain.menuBG");
         addChild(_BG);
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("consortiadomain.switchBtn");
         addChild(_closeBtn);
         _switchIMG = ComponentFactory.Instance.creatComponentByStylename("consortiadomain.switchIMG");
         _switchIMG.setFrame(1);
         _closeBtn.addChild(_switchIMG);
         _returnBtn = ComponentFactory.Instance.creatComponentByStylename("consortiadomain.returnBtn");
         addChild(_returnBtn);
         initEvent();
      }
      
      private function initEvent() : void
      {
         _returnBtn.addEventListener("click",backRoomList);
         _closeBtn.addEventListener("click",switchMenu);
      }
      
      private function removeEvent() : void
      {
         _returnBtn.removeEventListener("click",backRoomList);
         _closeBtn.removeEventListener("click",switchMenu);
      }
      
      private function backRoomList(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         ConsortiaDomainManager.instance.leaveScene();
      }
      
      private function switchMenu(param1:MouseEvent) : void
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
      
      private function menuShowOrHide(param1:Event) : void
      {
         if(_menuIsOpen)
         {
            this.x = this.x + 20;
            if(this.x >= StageReferance.stageWidth - this.width + (this.width - 34))
            {
               removeEventListener("enterFrame",menuShowOrHide);
               this.x = StageReferance.stageWidth - this.width + (this.width - 34);
               _menuIsOpen = false;
            }
         }
         else
         {
            this.x = this.x - 20;
            if(this.x <= StageReferance.stageWidth - this.width)
            {
               removeEventListener("enterFrame",menuShowOrHide);
               this.x = StageReferance.stageWidth - this.width;
               _menuIsOpen = true;
            }
         }
      }
      
      public function setRightDown() : void
      {
         this.x = StageReferance.stageWidth - this.width;
         this.y = StageReferance.stageHeight - this.height - 26;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         if(_BG)
         {
            ObjectUtils.disposeObject(_BG);
         }
         _BG = null;
         if(_closeBtn)
         {
            ObjectUtils.disposeObject(_closeBtn);
         }
         _closeBtn = null;
         if(_switchIMG)
         {
            ObjectUtils.disposeObject(_switchIMG);
         }
         _switchIMG = null;
         if(_returnBtn)
         {
            ObjectUtils.disposeObject(_returnBtn);
         }
         _returnBtn = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
