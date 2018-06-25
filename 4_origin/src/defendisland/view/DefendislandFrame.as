package defendisland.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ChatManager;
   import ddt.manager.CheckWeaponManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import defendisland.DefendislandControl;
   import defendisland.DefendislandManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import gameCommon.GameControl;
   
   public class DefendislandFrame extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var _startGameBtn:BaseButton;
      
      private var _cancelGameBtn:BaseButton;
      
      private var _helpBtn:BaseButton;
      
      private var boss1:Bitmap;
      
      private var boss2:Bitmap;
      
      private var boss3:Bitmap;
      
      private var boss4:Bitmap;
      
      private var boss5:Bitmap;
      
      private var icon1:Component;
      
      private var icon2:Component;
      
      private var icon3:Component;
      
      private var icon4:Component;
      
      private var icon5:Component;
      
      private var bossShine:Bitmap;
      
      private var _bossList:Array;
      
      private var waiting:Bitmap;
      
      private var timeTxt:FilterFrameText;
      
      public function DefendislandFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("ddt.defendisland.frame.title");
         _bg = ComponentFactory.Instance.creatBitmap("defendisland.frame.bg");
         addToContent(_bg);
         _helpBtn = HelpFrameUtils.Instance.simpleHelpButton(this,"core.helpButtonSmall",{
            "x":731,
            "y":6
         },LanguageMgr.GetTranslation("store.view.HelpButtonText"),"defendisland.content.help",438,520);
         _startGameBtn = ComponentFactory.Instance.creatComponentByStylename("defendisland.frame.startGameBtn");
         addToContent(_startGameBtn);
         _cancelGameBtn = ComponentFactory.Instance.creatComponentByStylename("defendisland.frame.cancelGameBtn");
         addToContent(_cancelGameBtn);
         bossShine = ComponentFactory.Instance.creatBitmap("defendisland.frame.boss.shine");
         addToContent(bossShine);
         icon1 = new Component();
         icon2 = new Component();
         icon3 = new Component();
         icon4 = new Component();
         icon5 = new Component();
         boss1 = ComponentFactory.Instance.creatBitmap("defendisland.frame.boss1");
         boss2 = ComponentFactory.Instance.creatBitmap("defendisland.frame.boss2");
         boss3 = ComponentFactory.Instance.creatBitmap("defendisland.frame.boss3");
         boss4 = ComponentFactory.Instance.creatBitmap("defendisland.frame.boss4");
         boss5 = ComponentFactory.Instance.creatBitmap("defendisland.frame.boss5");
         addToContent(icon1);
         addToContent(icon2);
         addToContent(icon3);
         addToContent(icon4);
         addToContent(icon5);
         icon1.addChild(boss1);
         icon2.addChild(boss2);
         icon3.addChild(boss3);
         icon4.addChild(boss4);
         icon5.addChild(boss5);
         PositionUtils.setPos(icon1,"defendisland.frame.boss1.pos");
         PositionUtils.setPos(icon2,"defendisland.frame.boss2.pos");
         PositionUtils.setPos(icon3,"defendisland.frame.boss3.pos");
         PositionUtils.setPos(icon4,"defendisland.frame.boss4.pos");
         PositionUtils.setPos(icon5,"defendisland.frame.boss5.pos");
         _bossList = [icon1,icon2,icon3,icon4,icon5];
         var _loc1_:* = "ddt.view.tips.WordWrapLineTip";
         _bossList[4].tipStyle = _loc1_;
         _loc1_ = _loc1_;
         _bossList[3].tipStyle = _loc1_;
         _loc1_ = _loc1_;
         _bossList[2].tipStyle = _loc1_;
         _loc1_ = _loc1_;
         _bossList[1].tipStyle = _loc1_;
         _bossList[0].tipStyle = _loc1_;
         _loc1_ = "7,5";
         _bossList[4].tipDirctions = _loc1_;
         _loc1_ = _loc1_;
         _bossList[3].tipDirctions = _loc1_;
         _loc1_ = _loc1_;
         _bossList[2].tipDirctions = _loc1_;
         _loc1_ = _loc1_;
         _bossList[1].tipDirctions = _loc1_;
         _bossList[0].tipDirctions = _loc1_;
         _loc1_ = 120;
         _bossList[4].tipGapH = _loc1_;
         _loc1_ = _loc1_;
         _bossList[3].tipGapH = _loc1_;
         _loc1_ = _loc1_;
         _bossList[2].tipGapH = _loc1_;
         _loc1_ = _loc1_;
         _bossList[1].tipGapH = _loc1_;
         _bossList[0].tipGapH = _loc1_;
         _loc1_ = 72;
         _bossList[4].tipGapV = _loc1_;
         _loc1_ = _loc1_;
         _bossList[3].tipGapV = _loc1_;
         _loc1_ = _loc1_;
         _bossList[2].tipGapV = _loc1_;
         _loc1_ = _loc1_;
         _bossList[1].tipGapV = _loc1_;
         _bossList[0].tipGapV = _loc1_;
         bossShine.visible = false;
         waiting = ComponentFactory.Instance.creatBitmap("defendisland.frame.loading");
         addToContent(waiting);
         _loc1_ = false;
         waiting.visible = _loc1_;
         _cancelGameBtn.visible = _loc1_;
         timeTxt = ComponentFactory.Instance.creatComponentByStylename("defendisland.frame.activityTimeText");
         addToContent(timeTxt);
         timeTxt.text = LanguageMgr.GetTranslation("ddt.defendisland.frame.time",DefendislandManager.instance.model.beginTime,DefendislandManager.instance.model.endTime);
         setData();
      }
      
      public function setData() : void
      {
         var i:int = 0;
         var prizeList:Array = LanguageMgr.GetTranslation("ddt.defendisland.frame.prizeName").split("|");
         var npcList:Array = LanguageMgr.GetTranslation("ddt.defendisland.frame.npcName").split("|");
         for(i = _bossList.length - 1; i >= 0; )
         {
            _bossList[i].tipData = LanguageMgr.GetTranslation("ddt.defendisland.frame.tip",npcList[i],DefendislandManager.instance.model.remainCountList[i],DefendislandManager.instance.model.countList[i],prizeList[i]);
            if(DefendislandManager.instance.model.remainCountList[i] == 0)
            {
               _bossList[i].filters = ComponentFactory.Instance.creatFilters("grayFilter");
            }
            else
            {
               bossShine.visible = true;
               _bossList[i].filters = null;
               bossShine.x = _bossList[i].x;
               bossShine.y = _bossList[i].y;
            }
            i--;
         }
         _startGameBtn.visible = true;
         var _loc4_:Boolean = false;
         _cancelGameBtn.visible = _loc4_;
         waiting.visible = _loc4_;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",_responseHandle);
         _startGameBtn.addEventListener("click",createRoomBtnHandler);
         _cancelGameBtn.addEventListener("click",quickJoinBtnHandler);
         GameControl.Instance.addEventListener("StartLoading",__startLoading);
      }
      
      protected function __startLoading(event:Event) : void
      {
         StateManager.getInGame_Step_6 = true;
         ChatManager.Instance.input.faceEnabled = false;
         LayerManager.Instance.clearnGameDynamic();
         StateManager.setState("roomLoading",GameControl.Instance.Current);
         StateManager.getInGame_Step_7 = true;
      }
      
      private function createRoomBtnHandler(e:MouseEvent) : void
      {
         if(CheckWeaponManager.instance.isNoWeapon())
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.room.RoomIIController.weapon"));
            return;
         }
         if(DefendislandManager.instance.model.remainCountList[DefendislandManager.instance.model.remainCountList.length - 1] == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.defendisland.frame.remainCountNone"));
            return;
         }
         SocketManager.Instance.out.defendislandInfo(3);
         _startGameBtn.visible = false;
         var _loc2_:Boolean = true;
         _cancelGameBtn.visible = _loc2_;
         waiting.visible = _loc2_;
      }
      
      private function quickJoinBtnHandler(e:MouseEvent) : void
      {
         GameInSocketOut.sendCancelWait();
         _startGameBtn.visible = true;
         var _loc2_:Boolean = false;
         _cancelGameBtn.visible = _loc2_;
         waiting.visible = _loc2_;
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",_responseHandle);
         _startGameBtn.removeEventListener("click",createRoomBtnHandler);
         _cancelGameBtn.removeEventListener("click",quickJoinBtnHandler);
         GameControl.Instance.removeEventListener("StartLoading",__startLoading);
      }
      
      protected function _responseHandle(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(event.responseCode))
         {
            case 0:
               dispose();
               break;
            case 1:
               dispose();
               break;
            default:
               dispose();
               break;
            default:
               dispose();
               break;
            case 4:
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
         GameInSocketOut.sendCancelWait();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(boss1);
         boss1 = null;
         ObjectUtils.disposeObject(boss2);
         boss2 = null;
         ObjectUtils.disposeObject(boss3);
         boss3 = null;
         ObjectUtils.disposeObject(boss4);
         boss4 = null;
         ObjectUtils.disposeObject(boss5);
         boss5 = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_startGameBtn);
         _startGameBtn = null;
         ObjectUtils.disposeObject(_cancelGameBtn);
         _cancelGameBtn = null;
         ObjectUtils.disposeObject(waiting);
         waiting = null;
         ObjectUtils.disposeObject(timeTxt);
         timeTxt = null;
         DefendislandControl.instance._frame = null;
      }
   }
}
