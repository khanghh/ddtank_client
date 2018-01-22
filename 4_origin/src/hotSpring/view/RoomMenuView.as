package hotSpring.view
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import hotSpring.controller.HotSpringRoomManager;
   import hotSpring.model.HotSpringRoomModel;
   
   public class RoomMenuView extends Sprite implements Disposeable
   {
       
      
      private var _controller:HotSpringRoomManager;
      
      private var _model:HotSpringRoomModel;
      
      private var _menuIsOpen:Boolean = true;
      
      private var _BG:Bitmap;
      
      private var _closeBtn:SimpleBitmapButton;
      
      private var _switchIMG:ScaleFrameImage;
      
      private var _returnBtn:SimpleBitmapButton;
      
      public function RoomMenuView(param1:HotSpringRoomManager, param2:HotSpringRoomModel)
      {
         super();
         _controller = param1;
         _model = param2;
         initialize();
      }
      
      private function initialize() : void
      {
         _BG = ComponentFactory.Instance.creatBitmap("asset.hotSpring.menuBG");
         addChild(_BG);
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("asset.hotSpring.switchBtn");
         addChild(_closeBtn);
         _switchIMG = ComponentFactory.Instance.creatComponentByStylename("asset.hotSpring.switchIMG");
         _switchIMG.setFrame(1);
         _closeBtn.addChild(_switchIMG);
         _returnBtn = ComponentFactory.Instance.creatComponentByStylename("asset.hotSpring.returnBtn");
         addChild(_returnBtn);
         setEvent();
      }
      
      private function setEvent() : void
      {
         _returnBtn.addEventListener("click",backRoomList);
         _closeBtn.addEventListener("click",switchMenu);
      }
      
      private function backRoomList(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         StateManager.setState("hotSpringRoomList");
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
      
      public function dispose() : void
      {
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
         _controller = null;
         _model = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
