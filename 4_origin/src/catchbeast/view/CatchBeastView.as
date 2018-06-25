package catchbeast.view
{
   import baglocked.BaglockedManager;
   import catchbeast.CatchBeastControl;
   import catchbeast.CatchBeastManager;
   import catchbeast.date.CatchBeastInfo;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.PositionUtils;
   import ddt.view.tips.GoodTipInfo;
   import ddt.view.tips.OneLineTip;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import gameCommon.GameControl;
   import road7th.comm.PackageIn;
   import store.HelpFrame;
   
   public class CatchBeastView extends Frame
   {
      
      private static var AWARD_NUM:int = 5;
       
      
      private var _progressInfo:Array;
      
      private var _bg:Bitmap;
      
      private var _helpBtn:BaseButton;
      
      private var _challengeBtn:BaseButton;
      
      private var _challengeNumText:FilterFrameText;
      
      private var _buyBuffBtn:BaseButton;
      
      private var _buyBuffNumText:FilterFrameText;
      
      private var _beastMovie:MovieImage;
      
      private var _progress:ScaleFrameImage;
      
      private var _progressSense:Sprite;
      
      private var _progressTips:OneLineTip;
      
      private var _damageInfo:FilterFrameText;
      
      private var _progressMask:Sprite;
      
      private var _careInfo:FilterFrameText;
      
      private var _getAwardVec:Vector.<MovieImage>;
      
      private var _info:CatchBeastInfo;
      
      public function CatchBeastView()
      {
         _progressInfo = [{
            "damage":0,
            "pos":0
         },{
            "damage":5,
            "pos":104
         },{
            "damage":20,
            "pos":187
         },{
            "damage":50,
            "pos":270
         },{
            "damage":100,
            "pos":353
         },{
            "damage":200,
            "pos":436
         }];
         super();
         _info = new CatchBeastInfo();
         initView();
         initEvent();
         sendPkg();
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var getAward:* = null;
         titleText = LanguageMgr.GetTranslation("catchBeast.view.Title");
         _bg = ComponentFactory.Instance.creat("catchBeast.view.bg");
         addToContent(_bg);
         _helpBtn = ComponentFactory.Instance.creat("catchBeast.view.helpBtn");
         addToContent(_helpBtn);
         _beastMovie = ComponentFactory.Instance.creat("catchBeast.view.beastMovie");
         addToContent(_beastMovie);
         _damageInfo = ComponentFactory.Instance.creatComponentByStylename("catchBeast.view.damageText");
         addToContent(_damageInfo);
         _progress = ComponentFactory.Instance.creatComponentByStylename("catchBeast.view.progressImage");
         addToContent(_progress);
         _progressTips = new OneLineTip();
         addToContent(_progressTips);
         _progressTips.x = _progress.x;
         _progressTips.y = _progress.y - _progress.height;
         _progressTips.visible = false;
         _challengeBtn = ComponentFactory.Instance.creat("catchBeast.view.challengeBtn");
         _challengeBtn.tipData = LanguageMgr.GetTranslation("catchBeast.view.challengeTips");
         addToContent(_challengeBtn);
         _challengeNumText = ComponentFactory.Instance.creatComponentByStylename("catchBeast.view.challengeNum");
         _challengeBtn.addChild(_challengeNumText);
         _buyBuffBtn = ComponentFactory.Instance.creat("catchBeast.view.buyBuffBtn");
         _buyBuffBtn.tipData = LanguageMgr.GetTranslation("catchBeast.view.buyBuffTips");
         addToContent(_buyBuffBtn);
         _buyBuffNumText = ComponentFactory.Instance.creatComponentByStylename("catchBeast.view.buyBuffNum");
         _buyBuffBtn.addChild(_buyBuffNumText);
         createProgressMask();
         createProgressSense();
         _careInfo = ComponentFactory.Instance.creatComponentByStylename("catchBeast.view.careInfoText");
         _careInfo.text = LanguageMgr.GetTranslation("catchBeast.view.careInfo");
         addToContent(_careInfo);
         _getAwardVec = new Vector.<MovieImage>();
         var awardPos:Point = PositionUtils.creatPoint("catchBeast.view.awardPos");
         for(i = 0; i < AWARD_NUM; )
         {
            getAward = ComponentFactory.Instance.creat("catchBeast.view.getAwardMovie");
            getAward.id = i;
            getAward.x = awardPos.x + i * 83;
            getAward.y = awardPos.y;
            addToContent(getAward);
            getAward.movie.gotoAndStop(1);
            _getAwardVec.push(getAward);
            i++;
         }
      }
      
      private function createProgressSense() : void
      {
         _progressSense = new Sprite();
         _progressSense.graphics.beginFill(0,0);
         _progressSense.graphics.drawRect(0,0,_progress.width,_progress.height);
         _progressSense.graphics.endFill();
         _progressSense.buttonMode = true;
         PositionUtils.setPos(_progressSense,_progress);
         addToContent(_progressSense);
      }
      
      private function createProgressMask() : void
      {
         _progressMask = new Sprite();
         _progressMask.graphics.beginFill(16777215);
         _progressMask.graphics.drawRect(0,0,_progress.width,_progress.height);
         _progressMask.graphics.endFill();
         _progressMask.x = _progress.x - _progress.width;
         _progressMask.y = _progress.y;
         addToContent(_progressMask);
         _progress.mask = _progressMask;
      }
      
      private function setProgressLength(num:int) : void
      {
         var i:int = 0;
         var offX:int = 0;
         if(num >= _progressInfo[5].damage * 10000)
         {
            num = _progressInfo[5].damage * 10000;
         }
         i = 1;
         while(i < _progressInfo.length)
         {
            if(num <= _progressInfo[i].damage * 10000)
            {
               offX = (_progressInfo[i].pos - _progressInfo[i - 1].pos) * (num - _progressInfo[i - 1].damage * 10000) / ((_progressInfo[i].damage - _progressInfo[i - 1].damage) * 10000) + _progressInfo[i - 1].pos;
               break;
            }
            i++;
         }
         _progressMask.x = _progressMask.x + offX;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameEventHandler);
         _helpBtn.addEventListener("click",__onHelpClick);
         _challengeBtn.addEventListener("click",__onChallengeClick);
         _buyBuffBtn.addEventListener("click",__onBuyBuffClick);
         _progressSense.addEventListener("mouseOver",__onProgressOver);
         _progressSense.addEventListener("mouseOut",__onProgressOut);
         CatchBeastManager.instance.addEventListener("catchbeast_viewinfo",__onSetViewInfo);
         CatchBeastManager.instance.addEventListener("catchbeast_getaward",__onIsGetAward);
         CatchBeastManager.instance.addEventListener("catchbeast_buybuff",__onIsBuyBuff);
         GameControl.Instance.addEventListener("StartLoading",__startLoading);
         StateManager.getInGame_Step_1 = true;
      }
      
      protected function __onHelpClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var helpBd:DisplayObject = ComponentFactory.Instance.creat("catchBeast.HelpPrompt");
         var helpPage:HelpFrame = ComponentFactory.Instance.creat("catchBeast.HelpFrame");
         helpPage.setView(helpBd);
         helpPage.titleText = LanguageMgr.GetTranslation("store.view.HelpButtonText");
         LayerManager.Instance.addToLayer(helpPage,1,true,1);
      }
      
      private function __startLoading(e:Event) : void
      {
         StateManager.getInGame_Step_6 = true;
         StateManager.setState("roomLoading",GameControl.Instance.Current);
         StateManager.getInGame_Step_7 = true;
      }
      
      protected function __onSetViewInfo(event:CrazyTankSocketEvent) : void
      {
         var i:int = 0;
         var pkg:PackageIn = event.pkg;
         _info.ChallengeNum = pkg.readInt();
         _info.BuyBuffNum = pkg.readInt();
         _info.BuffPrice = pkg.readInt();
         _info.DamageNum = pkg.readInt();
         var length:int = pkg.readInt();
         for(i = 0; i < length; )
         {
            _getAwardVec[i].tipData = new GoodTipInfo();
            _getAwardVec[i].tipData.itemInfo = setAwardBoxInfo(pkg.readInt());
            InventoryItemInfo(_getAwardVec[i].tipData.itemInfo).IsBinds = true;
            _progressInfo[i + 1].damage = pkg.readInt() / 10000;
            _info.BoxState.push(pkg.readInt());
            i++;
         }
         _challengeBtn.enable = _info.ChallengeNum <= 0?false:true;
         _buyBuffBtn.enable = _info.BuyBuffNum <= 0?false:true;
         _challengeNumText.text = LanguageMgr.GetTranslation("catchBeast.view.challengeNum",_info.ChallengeNum);
         _buyBuffNumText.text = LanguageMgr.GetTranslation("catchBeast.view.challengeNum",_info.BuyBuffNum);
         _damageInfo.text = LanguageMgr.GetTranslation("catchBeast.view.damageInfo",_progressInfo[1].damage,_progressInfo[2].damage,_progressInfo[3].damage,_progressInfo[4].damage,_progressInfo[5].damage);
         setProgressTipNum(_info.DamageNum);
         setProgressLength(_info.DamageNum);
         setAwardBoxState();
      }
      
      private function setProgressTipNum(num:int) : void
      {
         var str:String = num.toString() + "/" + (_progressInfo[_progressInfo.length - 1].damage * 10000).toString();
         _progressTips.tipData = LanguageMgr.GetTranslation("catchBeast.view.progressTips",str);
      }
      
      private function setAwardBoxState() : void
      {
         var i:int = 0;
         for(i = 0; i < _info.BoxState.length; )
         {
            if(_info.BoxState[i] == 2)
            {
               _getAwardVec[i].buttonMode = true;
               _getAwardVec[i].addEventListener("click",__onGetAward);
            }
            _getAwardVec[i].movie.gotoAndStop(_info.BoxState[i]);
            i++;
         }
      }
      
      protected function __onGetAward(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var movie:MovieImage = event.currentTarget as MovieImage;
         _getAwardVec[movie.id].removeEventListener("click",__onGetAward);
         SocketManager.Instance.out.sendCatchBeastGetAward(movie.id);
      }
      
      protected function __onIsGetAward(event:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var flag:Boolean = pkg.readBoolean();
         var id:int = pkg.readInt();
         if(flag)
         {
            _getAwardVec[id].movie.gotoAndStop(3);
            _getAwardVec[id].buttonMode = false;
         }
      }
      
      private function setAwardBoxInfo(id:int) : InventoryItemInfo
      {
         var itemInfo:InventoryItemInfo = new InventoryItemInfo();
         itemInfo.TemplateID = id;
         return ItemManager.fill(itemInfo);
      }
      
      protected function __onProgressOver(event:MouseEvent) : void
      {
         _progressTips.visible = true;
      }
      
      protected function __onProgressOut(event:MouseEvent) : void
      {
         _progressTips.visible = false;
      }
      
      protected function __onBuyBuffClick(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var alertAsk:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("catchBeast.view.buyBuffInfoText",_info.BuffPrice),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2,null,"SimpleAlert",60,false);
         alertAsk.addEventListener("response",__alertBuyBuff);
      }
      
      protected function __onIsBuyBuff(event:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var buyNum:int = pkg.readInt();
         _buyBuffBtn.enable = buyNum <= 0?false:true;
         _buyBuffNumText.text = LanguageMgr.GetTranslation("catchBeast.view.challengeNum",buyNum);
      }
      
      protected function __onChallengeClick(event:MouseEvent) : void
      {
         var alertAsk:* = null;
         SoundManager.instance.playButtonSound();
         if(_info.ChallengeNum < 0)
         {
            _challengeBtn.enable = false;
         }
         else
         {
            alertAsk = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("catchBeast.view.challengeInofText"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2,null,"SimpleAlert",60,false,0);
            alertAsk.addEventListener("response",__alertChallenge);
         }
      }
      
      protected function __alertChallenge(event:FrameEvent) : void
      {
         var frame:BaseAlerFrame = event.currentTarget as BaseAlerFrame;
         frame.removeEventListener("response",__alertChallenge);
         switch(int(event.responseCode) - 2)
         {
            case 0:
            case 1:
               SocketManager.Instance.out.sendCatchBeastChallenge();
         }
         frame.dispose();
      }
      
      private function sendPkg() : void
      {
         SocketManager.Instance.out.sendCatchBeastViewInfo();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,2);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameEventHandler);
         _helpBtn.removeEventListener("click",__onHelpClick);
         _challengeBtn.removeEventListener("click",__onChallengeClick);
         _buyBuffBtn.removeEventListener("click",__onBuyBuffClick);
         _progressSense.removeEventListener("mouseOver",__onProgressOver);
         _progressSense.removeEventListener("mouseOut",__onProgressOut);
         CatchBeastManager.instance.removeEventListener("catchbeast_viewinfo",__onSetViewInfo);
         CatchBeastManager.instance.removeEventListener("catchbeast_getaward",__onIsGetAward);
         CatchBeastManager.instance.removeEventListener("catchbeast_buybuff",__onIsBuyBuff);
         GameControl.Instance.removeEventListener("StartLoading",__startLoading);
         StateManager.getInGame_Step_8 = true;
      }
      
      protected function __alertBuyBuff(event:FrameEvent) : void
      {
         var alertFrame:* = null;
         var frame:BaseAlerFrame = event.currentTarget as BaseAlerFrame;
         frame.removeEventListener("response",__alertBuyBuff);
         switch(int(event.responseCode) - 2)
         {
            case 0:
            case 1:
               if(PlayerManager.Instance.Self.bagLocked)
               {
                  BaglockedManager.Instance.show();
                  ObjectUtils.disposeObject(event.currentTarget);
                  return;
               }
               if(frame.isBand)
               {
                  if(!checkMoney(true))
                  {
                     frame.dispose();
                     alertFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("buried.alertInfo.noBindMoney"),"",LanguageMgr.GetTranslation("cancel"),true,false,false,2);
                     alertFrame.addEventListener("response",onResponseHander);
                     return;
                  }
               }
               else if(!checkMoney(false))
               {
                  frame.dispose();
                  alertFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.title"),LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.content"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
                  alertFrame.addEventListener("response",_response);
                  return;
               }
               SocketManager.Instance.out.sendCatchBeastBuyBuff(frame.isBand);
               break;
         }
         frame.dispose();
      }
      
      private function onResponseHander(e:FrameEvent) : void
      {
         var alertFrame:* = null;
         (e.currentTarget as BaseAlerFrame).removeEventListener("response",onResponseHander);
         if(e.responseCode == 2 || e.responseCode == 3)
         {
            if(!checkMoney(false))
            {
               alertFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.title"),LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.content"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
               alertFrame.addEventListener("response",_response);
               return;
            }
            SocketManager.Instance.out.sendCatchBeastBuyBuff(false);
         }
         e.currentTarget.dispose();
      }
      
      private function _response(evt:FrameEvent) : void
      {
         (evt.currentTarget as BaseAlerFrame).removeEventListener("response",_response);
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            LeavePageManager.leaveToFillPath();
         }
         ObjectUtils.disposeObject(evt.currentTarget);
      }
      
      private function checkMoney(isBand:Boolean) : Boolean
      {
         if(isBand)
         {
            if(PlayerManager.Instance.Self.BandMoney < _info.BuffPrice)
            {
               return false;
            }
         }
         else if(PlayerManager.Instance.Self.Money < _info.BuffPrice)
         {
            return false;
         }
         return true;
      }
      
      private function __frameEventHandler(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               CatchBeastControl.instance.hide();
         }
      }
      
      override public function dispose() : void
      {
         var i:int = 0;
         super.dispose();
         removeEvent();
         if(_bg)
         {
            _bg.bitmapData.dispose();
            _bg = null;
         }
         if(_helpBtn)
         {
            _helpBtn.dispose();
            _helpBtn = null;
         }
         if(_progress)
         {
            _progress.dispose();
            _progress = null;
         }
         if(_challengeBtn)
         {
            _challengeBtn.dispose();
            _challengeBtn = null;
         }
         if(_challengeNumText)
         {
            _challengeNumText.dispose();
            _challengeNumText = null;
         }
         if(_buyBuffNumText)
         {
            _buyBuffNumText.dispose();
            _buyBuffNumText = null;
         }
         if(_beastMovie)
         {
            _beastMovie.dispose();
            _beastMovie = null;
         }
         if(_damageInfo)
         {
            _damageInfo.dispose();
            _damageInfo = null;
         }
         if(_getAwardVec)
         {
            for(i = 0; i < _getAwardVec.length; )
            {
               if(_getAwardVec[i])
               {
                  _getAwardVec[i].removeEventListener("click",__onGetAward);
                  _getAwardVec[i].dispose();
                  _getAwardVec[i] = null;
               }
               i++;
            }
            _getAwardVec.length = 0;
            _getAwardVec = null;
         }
         if(_progressTips)
         {
            _progressTips.dispose();
            _progressTips = null;
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
