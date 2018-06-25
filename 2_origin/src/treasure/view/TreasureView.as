package treasure.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleUpDownImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import farm.FarmModelController;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import treasure.controller.TreasureManager;
   import treasure.events.TreasureEvents;
   import treasure.model.TreasureModel;
   
   public class TreasureView extends Sprite implements Disposeable
   {
       
      
      private var _model:TreasureModel;
      
      private var _bg:Bitmap;
      
      private var _loginDaysTitle:Bitmap;
      
      private var _numBg:Bitmap;
      
      private var _digTimesTitle:Bitmap;
      
      private var _helpTimesTitle:Bitmap;
      
      private var _line1:Bitmap;
      
      private var _line2:Bitmap;
      
      private var _loginDaysTf:FilterFrameText;
      
      private var infoFrameBg:ScaleUpDownImage;
      
      private var beginBtn:SimpleBitmapButton;
      
      private var endBtn:SimpleBitmapButton;
      
      private var box:Sprite;
      
      private var fieldView:TreasureField;
      
      private var _treasureReturnBar:TreasureReturnBar;
      
      private var _helpFrame:TreasureHelpFrame;
      
      public function TreasureView()
      {
         super();
         _model = TreasureModel.instance;
         init();
         addListener();
      }
      
      private function init() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.treasure.bg");
         infoFrameBg = ComponentFactory.Instance.creatComponentByStylename("asset.treasure.infoFrame.BG");
         _loginDaysTitle = ComponentFactory.Instance.creatBitmap("asset.treasure.loginDays");
         _numBg = ComponentFactory.Instance.creatBitmap("asset.treasure.numBg");
         _digTimesTitle = ComponentFactory.Instance.creatBitmap("asset.treasure.digTimes");
         _helpTimesTitle = ComponentFactory.Instance.creatBitmap("asset.treasure.helpTimes");
         _line1 = ComponentFactory.Instance.creatBitmap("asset.treasure.line");
         _line2 = ComponentFactory.Instance.creatBitmap("asset.treasure.line");
         _loginDaysTf = ComponentFactory.Instance.creatComponentByStylename("asset.treasure.loginDaysTf");
         beginBtn = ComponentFactory.Instance.creatComponentByStylename("treasure.beginbtn");
         box = new Sprite();
         _treasureReturnBar = ComponentFactory.Instance.creat("asset.treasure.returnMenu");
         _helpFrame = ComponentFactory.Instance.creat("asset.treasure.helpFrame");
         PositionUtils.setPos(_line1,"treasure.pos.line1");
         PositionUtils.setPos(_line2,"treasure.pos.line2");
         addChild(_bg);
         addChild(infoFrameBg);
         addChild(_loginDaysTitle);
         addChild(_numBg);
         addChild(_digTimesTitle);
         addChild(_helpTimesTitle);
         addChild(_line1);
         addChild(_line2);
         addChild(_loginDaysTf);
         addChild(box);
         addChild(beginBtn);
         addChild(_treasureReturnBar);
         fieldView = new TreasureField(this);
         addChild(_helpFrame);
         if(TreasureModel.instance.isEndTreasure)
         {
            fieldView.setField(true);
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.treasure.over"));
         }
         else if(TreasureModel.instance.isBeginTreasure)
         {
            fieldView.setField(false);
         }
         else
         {
            fieldView.setField(true);
         }
         initData();
      }
      
      private function initData() : void
      {
         var i:int = 0;
         var iconForfex:* = null;
         var j:int = 0;
         var iconStar:* = null;
         var n:int = 0;
         var iconSun:* = null;
         var jj:int = 0;
         var nn:int = 0;
         if(TreasureModel.instance.isEndTreasure)
         {
            beginBtn.visible = false;
         }
         else if(TreasureModel.instance.isBeginTreasure)
         {
            beginBtn.visible = false;
         }
         else
         {
            beginBtn.visible = true;
         }
         _loginDaysTf.text = String(TreasureModel.instance.logoinDays);
         var total:int = TreasureModel.instance.logoinDays > 2?3:TreasureModel.instance.logoinDays;
         if(box)
         {
            ObjectUtils.disposeAllChildren(box);
         }
         i = 0;
         while(i < TreasureModel.instance.friendHelpTimes)
         {
            iconForfex = ComponentFactory.Instance.creatBitmap("asset.treasure.forfex");
            box.addChild(iconForfex);
            iconForfex.x = 60 + i * (iconForfex.width + 10);
            i++;
         }
         var starArr:Array = [];
         for(j = 0; j < total; )
         {
            iconStar = ComponentFactory.Instance.creatBitmap("asset.treasure.star");
            box.addChild(iconStar);
            iconStar.x = 60 + j * (iconStar.width + 10);
            iconStar.filters = ComponentFactory.Instance.creatFilters("grayFilter");
            starArr.push(iconStar);
            j++;
         }
         var sunNum:int = TreasureModel.instance.friendHelpTimes >= PathManager.treasureHelpTimes?1:0;
         var sunArr:Array = [];
         for(n = 0; n < sunNum; )
         {
            iconSun = ComponentFactory.Instance.creatBitmap("asset.treasure.sun");
            box.addChild(iconSun);
            iconSun.x = 60 + total * (iconSun.width + 10);
            iconSun.filters = ComponentFactory.Instance.creatFilters("grayFilter");
            sunArr.push(iconSun);
            n++;
         }
         for(jj = 0; jj < PlayerManager.Instance.Self.treasure; )
         {
            if(starArr[jj])
            {
               starArr[jj].filters = null;
            }
            jj++;
         }
         for(nn = 0; nn < PlayerManager.Instance.Self.treasureAdd; )
         {
            if(sunArr[nn])
            {
               sunArr[nn].filters = null;
            }
            nn++;
         }
      }
      
      private function addListener() : void
      {
         beginBtn.addEventListener("click",__onbeginBtnClick);
         _treasureReturnBar.addEventListener("returnTreasure",__returnHandler);
         TreasureManager.instance.addEventListener("beRepairFriendFarmSend",__friendHelpFarmHandler);
         TreasureManager.instance.addEventListener("beginGame",__beginGameHandler);
         TreasureManager.instance.addEventListener("dig",__diHandler);
         TreasureManager.instance.addEventListener("endGame",__endGameHandler);
      }
      
      private function __endGameHandler(e:TreasureEvents) : void
      {
         fieldView.endGameShow();
      }
      
      private function __diHandler(e:TreasureEvents) : void
      {
         initData();
         fieldView.digField(e.info.pos);
      }
      
      private function __beginGameHandler(e:TreasureEvents) : void
      {
         beginBtn.visible = false;
         fieldView.playStartCartoon();
      }
      
      private function __returnHandler(e:TreasureEvents) : void
      {
         SoundManager.instance.play("008");
         FarmModelController.instance.goFarm(PlayerManager.Instance.Self.ID,PlayerManager.Instance.Self.NickName);
      }
      
      private function __friendHelpFarmHandler(e:TreasureEvents) : void
      {
         initData();
      }
      
      private function __onEndBtnClick(e:MouseEvent) : void
      {
         var alert:* = null;
         if(TreasureModel.instance.friendHelpTimes < PathManager.treasureHelpTimes)
         {
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.treasure.giveUp"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2);
            alert.addEventListener("response",__onFeedResponse);
         }
         else
         {
            SocketManager.Instance.out.endTreasure();
         }
      }
      
      protected function __onFeedResponse(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(event.responseCode) - 2)
         {
            case 0:
            case 1:
               SocketManager.Instance.out.endTreasure();
         }
         event.currentTarget.removeEventListener("response",__onFeedResponse);
         ObjectUtils.disposeObject(event.currentTarget);
      }
      
      private function __onbeginBtnClick(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         beginBtn.enable = false;
         SocketManager.Instance.out.startTreasure();
      }
      
      private function removeEvent() : void
      {
         beginBtn.removeEventListener("click",__onbeginBtnClick);
         _treasureReturnBar.removeEventListener("returnTreasure",__returnHandler);
         TreasureManager.instance.removeEventListener("beRepairFriendFarmSend",__friendHelpFarmHandler);
         TreasureManager.instance.removeEventListener("beginGame",__beginGameHandler);
         TreasureManager.instance.removeEventListener("dig",__diHandler);
         TreasureManager.instance.removeEventListener("endGame",__endGameHandler);
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(box)
         {
            ObjectUtils.disposeAllChildren(box);
         }
         if(box)
         {
            ObjectUtils.disposeObject(box);
         }
         box = null;
         if(_loginDaysTf)
         {
            ObjectUtils.disposeObject(_loginDaysTf);
         }
         _loginDaysTf = null;
         if(_line1)
         {
            ObjectUtils.disposeObject(_line1);
         }
         _line1 = null;
         if(_line2)
         {
            ObjectUtils.disposeObject(_line2);
         }
         _line2 = null;
         if(_helpTimesTitle)
         {
            ObjectUtils.disposeObject(_helpTimesTitle);
         }
         _helpTimesTitle = null;
         if(_digTimesTitle)
         {
            ObjectUtils.disposeObject(_digTimesTitle);
         }
         _digTimesTitle = null;
         if(_numBg)
         {
            ObjectUtils.disposeObject(_numBg);
         }
         _numBg = null;
         if(_loginDaysTitle)
         {
            ObjectUtils.disposeObject(_loginDaysTitle);
         }
         _loginDaysTitle = null;
         if(infoFrameBg)
         {
            ObjectUtils.disposeObject(infoFrameBg);
         }
         infoFrameBg = null;
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         fieldView.dispose();
         fieldView = null;
         _helpFrame.dispose();
         _helpFrame = null;
         _treasureReturnBar.dispose();
         _treasureReturnBar = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
