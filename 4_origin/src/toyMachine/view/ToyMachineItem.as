package toyMachine.view
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.ComponentEvent;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.loader.LoaderCreate;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.HelperDataModuleLoad;
   import ddt.utils.PositionUtils;
   import ddt.view.caddyII.CaddyModel;
   import ddt.view.caddyII.LookTrophy;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.media.SoundTransform;
   import flash.utils.Timer;
   import kingBless.KingBlessManager;
   import road7th.comm.PackageIn;
   import trainer.view.NewHandContainer;
   
   public class ToyMachineItem extends Sprite implements Disposeable
   {
      
      private static var GrappleSilvelOne:int = ServerConfigManager.instance.getToyMachinePrice()[0];
      
      private static var GrappleSilvelTen:int = ServerConfigManager.instance.getToyMachinePrice()[1];
      
      private static var GrappleGoldOne:int = ServerConfigManager.instance.getToyMachinePrice()[2];
      
      private static var GrappleGoldTen:int = ServerConfigManager.instance.getToyMachinePrice()[3];
      
      private static var FreeCount:int = 10;
       
      
      private var _index:int;
      
      private var _rewardBtn:BaseButton;
      
      private var _machineBg:ScaleFrameImage;
      
      private var _tipsInfo:ScaleFrameImage;
      
      private var _grappleOneBtn:BaseButton;
      
      private var _grappleTenBtn:BaseButton;
      
      private var _countDown:FilterFrameText;
      
      private var _showPrize:LookTrophy;
      
      private var _grappleMovie:MovieClip;
      
      private var _timeSprite:Sprite;
      
      private var _freeCountBg:Image;
      
      private var _freeCountText:FilterFrameText;
      
      private var _freeCount:int = 0;
      
      private var _freeTime:Date;
      
      private var _freeTimeNum:Number;
      
      private var _time:Timer;
      
      private var _money:int;
      
      private var _rewardInfo:Array;
      
      private var _tenFlag:Boolean = false;
      
      private var _bigEgg:MovieClip;
      
      private var _smallEgg:MovieClip;
      
      private var _randIndex:int;
      
      private var _yinX1Text:FilterFrameText;
      
      private var _yinX10Text:FilterFrameText;
      
      private var _jinX1Text:FilterFrameText;
      
      private var _jinX10Text:FilterFrameText;
      
      public function ToyMachineItem(index:int)
      {
         super();
         _index = index;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _rewardBtn = ComponentFactory.Instance.creatComponentByStylename("toyMachine.rewardBtn" + _index);
         addChild(_rewardBtn);
         _machineBg = ComponentFactory.Instance.creatComponentByStylename("toyMachine.machineBg");
         _machineBg.setFrame(_index);
         addChild(_machineBg);
         _grappleOneBtn = ComponentFactory.Instance.creatComponentByStylename("toyMachine.grappleOneBtn");
         addChild(_grappleOneBtn);
         _grappleTenBtn = ComponentFactory.Instance.creatComponentByStylename("toyMachine.grappleTenBtn");
         addChild(_grappleTenBtn);
         _tipsInfo = ComponentFactory.Instance.creatComponentByStylename("toyMachine.tipsInfo");
         _tipsInfo.setFrame(_index);
         addChild(_tipsInfo);
         _freeCountBg = ComponentFactory.Instance.creatComponentByStylename("toyMachine.freeCountBg");
         addChild(_freeCountBg);
         _freeCountText = ComponentFactory.Instance.creatComponentByStylename("toyMachine.freeNum");
         _freeCountBg.addChild(_freeCountText);
         if(_index == 1)
         {
            _yinX1Text = ComponentFactory.Instance.creatComponentByStylename("toyMachine.yinX1Text");
            _yinX1Text.text = ServerConfigManager.instance.getToyMachinePrice()[0] + "Xu";
            addChild(_yinX1Text);
            _yinX10Text = ComponentFactory.Instance.creatComponentByStylename("toyMachine.yinX10Text");
            _yinX10Text.text = ServerConfigManager.instance.getToyMachinePrice()[1] + "Xu";
            addChild(_yinX10Text);
         }
         else
         {
            _jinX1Text = ComponentFactory.Instance.creatComponentByStylename("toyMachine.jinX1Text");
            _jinX1Text.text = ServerConfigManager.instance.getToyMachinePrice()[2] + "Xu";
            addChild(_jinX1Text);
            _jinX10Text = ComponentFactory.Instance.creatComponentByStylename("toyMachine.jinX10Text");
            _jinX10Text.text = ServerConfigManager.instance.getToyMachinePrice()[3] + "Xu";
            addChild(_jinX10Text);
         }
         _timeSprite = new Sprite();
         addChild(_timeSprite);
         var countDownBg:Bitmap = ComponentFactory.Instance.creat("asset.toyMachine.countdownBg");
         _timeSprite.addChild(countDownBg);
         _countDown = ComponentFactory.Instance.creatComponentByStylename("toyMachine.countDown");
         _timeSprite.addChild(_countDown);
         PositionUtils.setPos(_timeSprite,"toyMachine.countDownPos");
      }
      
      private function initEvent() : void
      {
         _rewardBtn.addEventListener("click",__onRewardClick);
         _grappleOneBtn.addEventListener("click",__onGrappleOneClick);
         _grappleTenBtn.addEventListener("click",__onGrappleTenClick);
      }
      
      public function setItemInfo(freeTime:Date, count:int = 0) : void
      {
         _freeCount = count;
         _freeTime = freeTime;
         updateInfo();
      }
      
      private function updateInfo() : void
      {
         if(_index == 1)
         {
            _freeTimeNum = (_freeTime.time - TimeManager.Instance.Now().time) / 1000 + 600;
            if(KingBlessManager.instance.openType == 0 && _freeTimeNum > 0)
            {
               if(_freeCount == 10)
               {
                  _freeTimeNum = 0;
               }
               beginCountDown(_freeCount != 10);
            }
            else
            {
               beginCountDown(false);
            }
         }
         else if(_index == 2)
         {
            _freeTimeNum = (_freeTime.time - TimeManager.Instance.Now().time) / 1000 + 252000;
            if(_freeTimeNum > 0)
            {
               _freeCount = 0;
               beginCountDown(true);
            }
            else
            {
               _freeCount = 1;
               beginCountDown(false);
            }
         }
         _freeCountText.text = _freeCount.toString();
      }
      
      private function beginCountDown(flag:Boolean) : void
      {
         _timeSprite.visible = flag;
         if(flag)
         {
            _freeCountBg.setFrame(4);
            _countDown.text = transSecond(_freeTimeNum);
            if(_time == null)
            {
               _time = new Timer(1000);
               _time.addEventListener("timer",__onUpdateCountDown);
            }
            _time.start();
         }
         else
         {
            _freeCountBg.setFrame(1);
            if(_time != null)
            {
               _time.stop();
               _time.reset();
            }
         }
      }
      
      protected function __onUpdateCountDown(event:TimerEvent) : void
      {
         _freeTimeNum = Number(_freeTimeNum) - 1;
         if(_freeTimeNum >= 0)
         {
            _countDown.text = transSecond(_freeTimeNum);
         }
         else
         {
            _time.stop();
            _time.reset();
            updateInfo();
         }
      }
      
      private function transSecond(num:Number) : String
      {
         var hour:int = num / 3600;
         num = num - hour * 3600;
         return (String("0" + Math.floor(hour))).substr(-2) + ":" + (String("0" + Math.floor(num / 60))).substr(-2) + ":" + (String("0" + Math.floor(num % 60))).substr(-2);
      }
      
      protected function __onGrappleOneClick(event:MouseEvent) : void
      {
         var alertAsk:* = null;
         SoundManager.instance.playButtonSound();
         _randIndex = Math.random() * 5;
         _tenFlag = false;
         if((KingBlessManager.instance.openType > 0 || _freeTimeNum <= 0) && _freeCount > 0)
         {
            SocketManager.Instance.out.sendToyMachineReward(_index,1,false,false);
         }
         else
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            if(_index == 1 && PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(11570) > 0)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("toyMachine.silver.useTicketText"));
               SocketManager.Instance.out.sendToyMachineReward(_index,1,false,false);
            }
            else
            {
               _money = _index == 1?GrappleSilvelOne:int(GrappleGoldOne);
               alertAsk = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("tank.game.GameView.gypsyRMBTicketConfirm",_money),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2,null,"SimpleAlert",60,false,1);
               alertAsk.addEventListener("response",__alertAllBack);
            }
         }
         if(!PlayerManager.Instance.Self.IsWeakGuildFinish(135))
         {
            if(PlayerManager.Instance.Self.Grade >= 25)
            {
               NewHandContainer.Instance.clearArrowByID(146);
               SocketManager.Instance.out.syncWeakStep(135);
            }
         }
      }
      
      protected function __onGrappleTenClick(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         _randIndex = 4;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         _tenFlag = true;
         _money = _index == 1?GrappleSilvelTen:int(GrappleGoldTen);
         var alertAsk:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("tank.game.GameView.gypsyRMBTicketConfirm",_money),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2,null,"SimpleAlert",60,false,1);
         alertAsk.addEventListener("response",__alertAllBack);
      }
      
      private function __alertAllBack(event:FrameEvent) : void
      {
         var frame:BaseAlerFrame = event.currentTarget as BaseAlerFrame;
         frame.removeEventListener("response",__alertAllBack);
         SoundManager.instance.playButtonSound();
         switch(int(event.responseCode) - 2)
         {
            case 0:
            case 1:
               CheckMoneyUtils.instance.checkMoney(frame.isBand,_money,sendGetReward);
         }
         frame.dispose();
      }
      
      private function sendGetReward() : void
      {
         SocketManager.Instance.out.sendToyMachineReward(_index,!!_tenFlag?10:1,true,CheckMoneyUtils.instance.isBind);
      }
      
      public function getReward(pkg:PackageIn) : void
      {
         var info:* = null;
         var cnt:int = pkg.readByte();
         _rewardInfo = [];
         while(pkg.bytesAvailable)
         {
            info = new InventoryItemInfo();
            info.TemplateID = pkg.readInt();
            info = ItemManager.fill(info);
            info.Count = pkg.readInt();
            info.IsBinds = pkg.readBoolean();
            info.ValidDate = pkg.readInt();
            info.StrengthenLevel = pkg.readInt();
            info.AttackCompose = pkg.readInt();
            info.DefendCompose = pkg.readInt();
            info.AgilityCompose = pkg.readInt();
            info.LuckCompose = pkg.readInt();
            if(EquipType.isMagicStone(info.CategoryID))
            {
               info.Level = info.StrengthenLevel;
               info.Attack = info.AttackCompose;
               info.Defence = info.DefendCompose;
               info.Agility = info.AgilityCompose;
               info.Luck = info.LuckCompose;
               info.Level = info.StrengthenLevel;
               info.MagicAttack = pkg.readInt();
               info.MagicDefence = pkg.readInt();
            }
            else
            {
               pkg.readInt();
               pkg.readInt();
            }
            _rewardInfo.push(info);
         }
         grappleMovie();
      }
      
      private function grappleMovie() : void
      {
         if(_index == 1)
         {
            _grappleMovie = ComponentFactory.Instance.creat("asset.toyMachine.silvelGrapple");
         }
         else if(_index == 2)
         {
            _grappleMovie = ComponentFactory.Instance.creat("asset.toyMachine.goldGrapple");
         }
         if(SoundManager.instance.allowSound)
         {
            setGrappleMovieSoundVolume(1);
         }
         else
         {
            setGrappleMovieSoundVolume(0);
         }
         _grappleMovie.y = 32;
         addChild(_grappleMovie);
         _grappleMovie.addEventListener("enterFrame",__onMovieFrame);
      }
      
      protected function __onMovieFrame(event:Event) : void
      {
         if(_grappleMovie.currentFrame == 41)
         {
            _smallEgg = ComponentFactory.Instance.creat("asset.toyMachine.smallEggs" + _randIndex);
            _smallEgg.x = 153;
            _smallEgg.y = 65;
            _grappleMovie.addChild(_smallEgg);
         }
         if(_grappleMovie.currentFrame == 81)
         {
            if(_smallEgg)
            {
               _grappleMovie.removeChild(_smallEgg);
            }
            _smallEgg = null;
            _bigEgg = ComponentFactory.Instance.creat("asset.toyMachine.bigEggs" + _randIndex);
            _bigEgg.x = 79;
            _bigEgg.y = 85;
            _grappleMovie.addChild(_bigEgg);
         }
         if(_grappleMovie.currentFrame == _grappleMovie.totalFrames)
         {
            setGrappleMovieSoundVolume(0);
            _grappleMovie.removeEventListener("enterFrame",__onMovieFrame);
            _grappleMovie.stop();
            _bigEgg["closeBtn"].addEventListener("click",__onCloseGrappleMovie);
            addRewardToMovie();
         }
      }
      
      private function addRewardToMovie() : void
      {
         var i:int = 0;
         var tempInfo:* = null;
         var tempIndex:int = 0;
         var cell:* = null;
         var len:int = _rewardInfo.length;
         for(i = 0; i < len; )
         {
            tempIndex = Math.random() * len;
            tempInfo = _rewardInfo[tempIndex];
            _rewardInfo[tempIndex] = _rewardInfo[i];
            _rewardInfo[i] = tempInfo;
            i++;
         }
         for(i = 0; i < _rewardInfo.length; )
         {
            cell = new BagCell(0,_rewardInfo[i]);
            cell.x = i * cell.width + 15;
            if(i > 4)
            {
               cell.x = (i - 5) * cell.width + 15;
               cell.y = cell.height + 5;
            }
            _bigEgg["rewardSprite"].addChild(cell);
            i++;
         }
         SocketManager.Instance.out.getToyMachineInfo();
      }
      
      private function setGrappleMovieSoundVolume(num:int) : void
      {
         var currentSoundTransForm:* = null;
         if(_grappleMovie)
         {
            currentSoundTransForm = _grappleMovie.soundTransform;
            currentSoundTransForm.volume = num;
            _grappleMovie.soundTransform = currentSoundTransForm;
         }
      }
      
      private function __onCloseGrappleMovie(event:MouseEvent) : void
      {
         if(_bigEgg && _bigEgg["closeBtn"])
         {
            _bigEgg["closeBtn"].removeEventListener("click",__onCloseGrappleMovie);
         }
         if(_grappleMovie != null)
         {
            setGrappleMovieSoundVolume(0);
            _grappleMovie.stop();
            removeChild(_grappleMovie);
            ObjectUtils.disposeObject(_grappleMovie);
            _grappleMovie = null;
         }
      }
      
      protected function __onRewardClick(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         new HelperDataModuleLoad().loadDataModule([LoaderCreate.Instance.createCaddyAwardsLoader],lookTrophy);
      }
      
      private function lookTrophy() : void
      {
         _showPrize = ComponentFactory.Instance.creatCustomObject("toyMachine.LookTrophy");
         _showPrize.show(CaddyModel.instance.getCaddyTrophy(_index == 1?1222010:1222110));
         _showPrize.addEventListener("dispose",onshowPrizeDispose);
      }
      
      private function onshowPrizeDispose(event:ComponentEvent) : void
      {
         _showPrize.removeEventListener("dispose",onshowPrizeDispose);
         ObjectUtils.disposeObject(_showPrize);
         _showPrize = null;
      }
      
      private function removeEvent() : void
      {
         _rewardBtn.removeEventListener("click",__onRewardClick);
         _grappleOneBtn.removeEventListener("click",__onGrappleOneClick);
         _grappleTenBtn.removeEventListener("click",__onGrappleTenClick);
         if(_grappleMovie)
         {
            _grappleMovie.removeEventListener("enterFrame",__onMovieFrame);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         __onCloseGrappleMovie(null);
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeObject(_rewardBtn);
         _rewardBtn = null;
         ObjectUtils.disposeObject(_machineBg);
         _machineBg = null;
         ObjectUtils.disposeObject(_grappleOneBtn);
         _grappleOneBtn = null;
         ObjectUtils.disposeObject(_grappleTenBtn);
         _grappleTenBtn = null;
         ObjectUtils.disposeObject(_countDown);
         _countDown = null;
         ObjectUtils.disposeObject(_tipsInfo);
         _tipsInfo = null;
         ObjectUtils.disposeObject(_smallEgg);
         _smallEgg = null;
         ObjectUtils.disposeObject(_bigEgg);
         _bigEgg = null;
         if(_time != null)
         {
            _time.stop();
            _time.reset();
            _time.removeEventListener("timer",__onUpdateCountDown);
            _time = null;
         }
      }
   }
}
