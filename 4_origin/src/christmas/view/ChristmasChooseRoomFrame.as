package christmas.view
{
   import christmas.ChristmasCoreController;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import store.HelpFrame;
   
   public class ChristmasChooseRoomFrame extends Frame
   {
       
      
      private var _titleImg:Bitmap;
      
      private var _roomBgImg:ScaleBitmapImage;
      
      private var _entranceImg:Bitmap;
      
      private var _activityTimeImg:Bitmap;
      
      private var _activeTimeTxt:FilterFrameText;
      
      private var _chooseRoomText:FilterFrameText;
      
      private var _enterBtn:BaseButton;
      
      private var _enterHeapBtn:BaseButton;
      
      private var _help:BaseButton;
      
      private var _clickDate:Number = 0;
      
      public function ChristmasChooseRoomFrame()
      {
         super();
         initView();
         initEvent();
         initText();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("tank.menu.christmasTiTle");
         _roomBgImg = ComponentFactory.Instance.creatComponentByStylename("chooseRoom.christmas.ChristmasChooseRoomFrameBgImg");
         _titleImg = ComponentFactory.Instance.creatBitmap("asset.christmas.room.titleImg");
         _entranceImg = ComponentFactory.Instance.creatBitmap("asset.christmas.room.entranceImg");
         _activityTimeImg = ComponentFactory.Instance.creatBitmap("asset.christmas.room.activityTimeImg");
         _activeTimeTxt = ComponentFactory.Instance.creatComponentByStylename("christmas.chooseRoom.activeTimeTxt");
         _chooseRoomText = ComponentFactory.Instance.creatComponentByStylename("christmas.chooseRoom.chooseRoomText");
         _enterBtn = ComponentFactory.Instance.creat("christmas.chooseRoom.enter.btn");
         _enterHeapBtn = ComponentFactory.Instance.creat("christmas.chooseRoom.enterHeap.btn");
         _help = ComponentFactory.Instance.creat("christmas.chooseRoom.help.btn");
         addToContent(_roomBgImg);
         addToContent(_titleImg);
         addToContent(_entranceImg);
         addToContent(_activityTimeImg);
         addToContent(_activeTimeTxt);
         addToContent(_chooseRoomText);
         addToContent(_enterBtn);
         addToContent(_enterHeapBtn);
         addToContent(_help);
      }
      
      private function initText() : void
      {
         _chooseRoomText.text = LanguageMgr.GetTranslation("christmas.chooseRoom.chooseRoomTextLG");
         _activeTimeTxt.text = ChristmasCoreController.instance.model.activityTime;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         _enterBtn.addEventListener("click",__onClickEnterHandler);
         _enterHeapBtn.addEventListener("click",__onClickEnterHeapHandler);
         _help.addEventListener("click",__onClickHelpHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         if(_enterBtn)
         {
            _enterBtn.removeEventListener("click",__onClickEnterHandler);
         }
         if(_enterHeapBtn)
         {
            _enterHeapBtn.removeEventListener("click",__onClickEnterHeapHandler);
         }
         if(_help)
         {
            _help.removeEventListener("click",__onClickHelpHandler);
         }
      }
      
      private function __onClickEnterHandler(e:MouseEvent) : void
      {
         if(new Date().time - _clickDate > 1000)
         {
            _clickDate = new Date().time;
            SoundManager.instance.play("008");
            SocketManager.Instance.out.enterChristmasRoomIsTrue();
         }
      }
      
      private function __onClickEnterHeapHandler(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         SocketManager.Instance.out.enterMakingSnowManRoom();
      }
      
      private function __onClickHelpHandler(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var helpBd:DisplayObject = ComponentFactory.Instance.creat("christmas.HelpPrompt");
         var helpPage:HelpFrame = ComponentFactory.Instance.creat("christmas.HelpFrame");
         helpPage.setView(helpBd);
         helpPage.titleText = LanguageMgr.GetTranslation("christmas.christmas.readme");
         LayerManager.Instance.addToLayer(helpPage,1,true,1);
      }
      
      private function __responseHandler(evt:FrameEvent) : void
      {
         if(evt.responseCode == 0 || evt.responseCode == 1)
         {
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         _titleImg = null;
         _roomBgImg = null;
         _entranceImg = null;
         _activityTimeImg = null;
         _activeTimeTxt = null;
         _chooseRoomText = null;
         _enterBtn = null;
         _enterHeapBtn = null;
      }
   }
}
