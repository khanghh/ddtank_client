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
         var _loc3_:int = 0;
         var _loc2_:* = null;
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
         var _loc1_:Point = PositionUtils.creatPoint("catchBeast.view.awardPos");
         _loc3_ = 0;
         while(_loc3_ < AWARD_NUM)
         {
            _loc2_ = ComponentFactory.Instance.creat("catchBeast.view.getAwardMovie");
            _loc2_.id = _loc3_;
            _loc2_.x = _loc1_.x + _loc3_ * 83;
            _loc2_.y = _loc1_.y;
            addToContent(_loc2_);
            _loc2_.movie.gotoAndStop(1);
            _getAwardVec.push(_loc2_);
            _loc3_++;
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
      
      private function setProgressLength(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         if(param1 >= _progressInfo[5].damage * 10000)
         {
            param1 = _progressInfo[5].damage * 10000;
         }
         _loc3_ = 1;
         while(_loc3_ < _progressInfo.length)
         {
            if(param1 <= _progressInfo[_loc3_].damage * 10000)
            {
               _loc2_ = (_progressInfo[_loc3_].pos - _progressInfo[_loc3_ - 1].pos) * (param1 - _progressInfo[_loc3_ - 1].damage * 10000) / ((_progressInfo[_loc3_].damage - _progressInfo[_loc3_ - 1].damage) * 10000) + _progressInfo[_loc3_ - 1].pos;
               break;
            }
            _loc3_++;
         }
         _progressMask.x = _progressMask.x + _loc2_;
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
      
      protected function __onHelpClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:DisplayObject = ComponentFactory.Instance.creat("catchBeast.HelpPrompt");
         var _loc3_:HelpFrame = ComponentFactory.Instance.creat("catchBeast.HelpFrame");
         _loc3_.setView(_loc2_);
         _loc3_.titleText = LanguageMgr.GetTranslation("store.view.HelpButtonText");
         LayerManager.Instance.addToLayer(_loc3_,1,true,1);
      }
      
      private function __startLoading(param1:Event) : void
      {
         StateManager.getInGame_Step_6 = true;
         StateManager.setState("roomLoading",GameControl.Instance.Current);
         StateManager.getInGame_Step_7 = true;
      }
      
      protected function __onSetViewInfo(param1:CrazyTankSocketEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:PackageIn = param1.pkg;
         _info.ChallengeNum = _loc3_.readInt();
         _info.BuyBuffNum = _loc3_.readInt();
         _info.BuffPrice = _loc3_.readInt();
         _info.DamageNum = _loc3_.readInt();
         var _loc2_:int = _loc3_.readInt();
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _getAwardVec[_loc4_].tipData = new GoodTipInfo();
            _getAwardVec[_loc4_].tipData.itemInfo = setAwardBoxInfo(_loc3_.readInt());
            InventoryItemInfo(_getAwardVec[_loc4_].tipData.itemInfo).IsBinds = true;
            _progressInfo[_loc4_ + 1].damage = _loc3_.readInt() / 10000;
            _info.BoxState.push(_loc3_.readInt());
            _loc4_++;
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
      
      private function setProgressTipNum(param1:int) : void
      {
         var _loc2_:String = param1.toString() + "/" + (_progressInfo[_progressInfo.length - 1].damage * 10000).toString();
         _progressTips.tipData = LanguageMgr.GetTranslation("catchBeast.view.progressTips",_loc2_);
      }
      
      private function setAwardBoxState() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _info.BoxState.length)
         {
            if(_info.BoxState[_loc1_] == 2)
            {
               _getAwardVec[_loc1_].buttonMode = true;
               _getAwardVec[_loc1_].addEventListener("click",__onGetAward);
            }
            _getAwardVec[_loc1_].movie.gotoAndStop(_info.BoxState[_loc1_]);
            _loc1_++;
         }
      }
      
      protected function __onGetAward(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var _loc2_:MovieImage = param1.currentTarget as MovieImage;
         _getAwardVec[_loc2_.id].removeEventListener("click",__onGetAward);
         SocketManager.Instance.out.sendCatchBeastGetAward(_loc2_.id);
      }
      
      protected function __onIsGetAward(param1:CrazyTankSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.pkg;
         var _loc3_:Boolean = _loc4_.readBoolean();
         var _loc2_:int = _loc4_.readInt();
         if(_loc3_)
         {
            _getAwardVec[_loc2_].movie.gotoAndStop(3);
            _getAwardVec[_loc2_].buttonMode = false;
         }
      }
      
      private function setAwardBoxInfo(param1:int) : InventoryItemInfo
      {
         var _loc2_:InventoryItemInfo = new InventoryItemInfo();
         _loc2_.TemplateID = param1;
         return ItemManager.fill(_loc2_);
      }
      
      protected function __onProgressOver(param1:MouseEvent) : void
      {
         _progressTips.visible = true;
      }
      
      protected function __onProgressOut(param1:MouseEvent) : void
      {
         _progressTips.visible = false;
      }
      
      protected function __onBuyBuffClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var _loc2_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("catchBeast.view.buyBuffInfoText",_info.BuffPrice),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2,null,"SimpleAlert",60,false);
         _loc2_.addEventListener("response",__alertBuyBuff);
      }
      
      protected function __onIsBuyBuff(param1:CrazyTankSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:int = _loc3_.readInt();
         _buyBuffBtn.enable = _loc2_ <= 0?false:true;
         _buyBuffNumText.text = LanguageMgr.GetTranslation("catchBeast.view.challengeNum",_loc2_);
      }
      
      protected function __onChallengeClick(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.playButtonSound();
         if(_info.ChallengeNum < 0)
         {
            _challengeBtn.enable = false;
         }
         else
         {
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("catchBeast.view.challengeInofText"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2,null,"SimpleAlert",60,false,0);
            _loc2_.addEventListener("response",__alertChallenge);
         }
      }
      
      protected function __alertChallenge(param1:FrameEvent) : void
      {
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",__alertChallenge);
         switch(int(param1.responseCode) - 2)
         {
            case 0:
            case 1:
               SocketManager.Instance.out.sendCatchBeastChallenge();
         }
         _loc2_.dispose();
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
      
      protected function __alertBuyBuff(param1:FrameEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc3_.removeEventListener("response",__alertBuyBuff);
         switch(int(param1.responseCode) - 2)
         {
            case 0:
            case 1:
               if(PlayerManager.Instance.Self.bagLocked)
               {
                  BaglockedManager.Instance.show();
                  ObjectUtils.disposeObject(param1.currentTarget);
                  return;
               }
               if(_loc3_.isBand)
               {
                  if(!checkMoney(true))
                  {
                     _loc3_.dispose();
                     _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("buried.alertInfo.noBindMoney"),"",LanguageMgr.GetTranslation("cancel"),true,false,false,2);
                     _loc2_.addEventListener("response",onResponseHander);
                     return;
                  }
               }
               else if(!checkMoney(false))
               {
                  _loc3_.dispose();
                  _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.title"),LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.content"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
                  _loc2_.addEventListener("response",_response);
                  return;
               }
               SocketManager.Instance.out.sendCatchBeastBuyBuff(_loc3_.isBand);
               break;
         }
         _loc3_.dispose();
      }
      
      private function onResponseHander(param1:FrameEvent) : void
      {
         var _loc2_:* = null;
         (param1.currentTarget as BaseAlerFrame).removeEventListener("response",onResponseHander);
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            if(!checkMoney(false))
            {
               _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.title"),LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.content"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
               _loc2_.addEventListener("response",_response);
               return;
            }
            SocketManager.Instance.out.sendCatchBeastBuyBuff(false);
         }
         param1.currentTarget.dispose();
      }
      
      private function _response(param1:FrameEvent) : void
      {
         (param1.currentTarget as BaseAlerFrame).removeEventListener("response",_response);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            LeavePageManager.leaveToFillPath();
         }
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      private function checkMoney(param1:Boolean) : Boolean
      {
         if(param1)
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
      
      private function __frameEventHandler(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               CatchBeastControl.instance.hide();
         }
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
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
            _loc1_ = 0;
            while(_loc1_ < _getAwardVec.length)
            {
               if(_getAwardVec[_loc1_])
               {
                  _getAwardVec[_loc1_].removeEventListener("click",__onGetAward);
                  _getAwardVec[_loc1_].dispose();
                  _getAwardVec[_loc1_] = null;
               }
               _loc1_++;
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
