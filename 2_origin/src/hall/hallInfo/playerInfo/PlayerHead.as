package hall.hallInfo.playerInfo
{
   import bagAndInfo.BagAndInfoManager;
   import bagAndInfo.energyData.EnergyData;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.SelfInfo;
   import ddt.events.CEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.Helpers;
   import ddt.utils.PositionUtils;
   import ddt.view.common.LevelIcon;
   import ddt.view.sceneCharacter.SceneCharacterLoaderHead;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import magicStone.MagicStoneManager;
   import vip.VipController;
   
   public class PlayerHead extends Sprite
   {
      
      private static var HeadWidth:int = 120;
      
      private static var HeadHeight:int = 103;
       
      
      private var _headLoader:SceneCharacterLoaderHead;
      
      private var _headBitmap:Bitmap;
      
      private var _levelIcon:LevelIcon;
      
      private var _selfInfo:SelfInfo;
      
      private var _energyProgress:EnergyProgress;
      
      private var _energyAddBtn:SimpleBitmapButton;
      
      private var _energyData:EnergyData;
      
      private var _nickNameText:FilterFrameText;
      
      private var _vipName:GradientText;
      
      private var _headBtn:BaseButton;
      
      private var _headMask:DisplayObject;
      
      public function PlayerHead()
      {
         super();
         _selfInfo = PlayerManager.Instance.Self;
         initView();
         loadHead();
         initEvent();
      }
      
      private function initEvent() : void
      {
         _energyAddBtn.addEventListener("click",__addEnergyHandler);
         _selfInfo.addEventListener("propertychange",__onUpdateGrade);
         PlayerManager.Instance.addEventListener("girl_head_photo_change",onHeadSelectChange);
      }
      
      protected function onHeadSelectChange(param1:CEvent) : void
      {
         loadHead();
      }
      
      protected function __onUpdateGrade(param1:PlayerPropertyEvent) : void
      {
         if(param1.changedProperties["Energy"])
         {
            if(_energyProgress)
            {
               _energyProgress.showProgressBar(_selfInfo.energy,1500);
            }
         }
         _energyProgress.showProgressBar(_selfInfo.energy,1500);
         if(_levelIcon)
         {
            _levelIcon.setInfo(_selfInfo.Grade,_selfInfo.ddtKingGrade,_selfInfo.Repute,_selfInfo.WinCount,_selfInfo.TotalCount,_selfInfo.FightPower,_selfInfo.Offer,true,false);
         }
      }
      
      public function loadGirlHeadPhoto() : void
      {
      }
      
      public function loadHead() : void
      {
         if(_headLoader)
         {
            _headLoader.dispose();
            _headLoader = null;
         }
         _headLoader = new SceneCharacterLoaderHead(PlayerManager.Instance.Self,PlayerManager.Instance.Self.IsShow);
         _headLoader.load(headLoaderCallBack);
      }
      
      private function initView() : void
      {
         _levelIcon = new LevelIcon();
         _levelIcon.setInfo(_selfInfo.Grade,_selfInfo.ddtKingGrade,_selfInfo.Repute,_selfInfo.WinCount,_selfInfo.TotalCount,_selfInfo.FightPower,_selfInfo.Offer,true,false);
         PositionUtils.setPos(_levelIcon,"hall.playerInfoview.levelIconPos");
         addChild(_levelIcon);
         _energyProgress = ComponentFactory.Instance.creatComponentByStylename("EnergyProgress");
         _energyProgress.tipData = LanguageMgr.GetTranslation("tank.view.energy.tip");
         _energyProgress.showProgressBar(_selfInfo.energy,1500);
         addChild(_energyProgress);
         _energyAddBtn = ComponentFactory.Instance.creatComponentByStylename("hall.playerInfo.energyAddBtn");
         _energyAddBtn.tipData = LanguageMgr.GetTranslation("tank.view.energy.addtip");
         addChild(_energyAddBtn);
         _nickNameText = ComponentFactory.Instance.creatComponentByStylename("hall.playerInfo.nickNameText");
         _nickNameText.text = _selfInfo.NickName;
         addChild(_nickNameText);
         if(_selfInfo.IsVIP)
         {
            _vipName = VipController.instance.getVipNameTxt(104,_selfInfo.typeVIP);
            _vipName.textSize = 16;
            _vipName.x = _nickNameText.x;
            _vipName.y = _nickNameText.y - 2;
            _vipName.text = _selfInfo.NickName;
            addChild(_vipName);
         }
         PositionUtils.adaptNameStyle(_selfInfo,_nickNameText,_vipName);
      }
      
      protected function __addEnergyHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         _energyData = PlayerManager.Instance.energyData[PlayerManager.Instance.Self.buyEnergyCount + 1];
         if(!_energyData)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.energy.cannotbuyEnergy"));
            return;
         }
         var _loc2_:int = 0;
         var _loc8_:int = 0;
         var _loc7_:* = PlayerManager.Instance.energyData;
         for each(var _loc3_ in PlayerManager.Instance.energyData)
         {
            _loc2_++;
         }
         var _loc5_:int = _loc2_ - PlayerManager.Instance.Self.buyEnergyCount;
         var _loc6_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("tank.view.energy.buyEnergy",_energyData.Money,_energyData.Energy),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2,null,"hall.buyEnergySimpleAlert",60,false,1);
         var _loc4_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("hall.buyEnergySimpleAlertCountTxt");
         _loc4_.htmlText = LanguageMgr.GetTranslation("tank.view.energy.buyEnergyCountTxtMsg",_loc5_);
         _loc6_.addToContent(_loc4_);
         _loc6_.addEventListener("response",__alertBuyEnergy);
      }
      
      protected function __alertBuyEnergy(param1:FrameEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc3_.removeEventListener("response",__alertBuyEnergy);
         switch(int(param1.responseCode) - 2)
         {
            case 0:
            case 1:
               if(PlayerManager.Instance.Self.bagLocked)
               {
                  BaglockedManager.Instance.show();
                  param1.currentTarget.removeEventListener("response",__alertBuyEnergy);
                  ObjectUtils.disposeObject(param1.currentTarget);
                  return;
               }
               if(PlayerManager.Instance.Self.energy <= 1500 && PlayerManager.Instance.Self.energy > 1450)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.energy.energyEnough"));
                  _loc3_.dispose();
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
               SocketManager.Instance.out.sendBuyEnergy(_loc3_.isBand);
               break;
         }
         _loc3_.dispose();
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
            SocketManager.Instance.out.sendBuyEnergy(false);
         }
         param1.currentTarget.dispose();
      }
      
      private function checkMoney(param1:Boolean) : Boolean
      {
         if(param1)
         {
            if(PlayerManager.Instance.Self.BandMoney < _energyData.Money)
            {
               return false;
            }
         }
         else if(PlayerManager.Instance.Self.Money < _energyData.Money)
         {
            return false;
         }
         return true;
      }
      
      private function headLoaderCallBack(param1:SceneCharacterLoaderHead, param2:Boolean = true) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         if(param1)
         {
            if(!_headBitmap)
            {
               _headBitmap = new Bitmap();
               _headMask = ComponentFactory.Instance.creat("asset.topleft.girlHead.mask");
               _headMask.x = -116;
               _headMask.y = 5;
            }
            else if(_headBitmap.parent)
            {
               removeChild(_headBitmap);
               _headBitmap = null;
            }
            if(PlayerManager.Instance.Self.ImagePath != "" && PlayerManager.Instance.Self.IsShow)
            {
               _headBitmap = new Bitmap(param1.getContent()[0] as BitmapData,"auto",true);
               _headBitmap.mask = _headMask;
               addChild(_headMask);
               _headBitmap.x = -96;
               _headBitmap.y = 31;
               Helpers.scaleDisplayObject(_headBitmap,null,null,74);
            }
            else
            {
               if(_headBitmap == null)
               {
                  _headBitmap = new Bitmap();
               }
               _loc3_ = new Rectangle(0,0,HeadWidth,HeadHeight);
               _loc4_ = new BitmapData(HeadWidth,HeadHeight,true,0);
               _loc4_.copyPixels(param1.getContent()[0] as BitmapData,_loc3_,new Point(0,0));
               _headBitmap.bitmapData = _loc4_;
               _headBitmap.rotationY = 180;
               _headBitmap.mask = null;
               _headMask && _headMask.parent && removeChild(_headMask);
            }
            addChildAt(_headBitmap,0);
            param1.dispose();
         }
         _headBtn = ComponentFactory.Instance.creatComponentByStylename("hall.playerHeadBtn");
         _headBtn.addEventListener("click",__onHeadClick);
         addChild(_headBtn);
      }
      
      protected function __onHeadClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("003");
         BagAndInfoManager.Instance.showBagAndInfo();
         if(!PlayerManager.Instance.Self.IsWeakGuildFinish(38))
         {
            SocketManager.Instance.out.syncWeakStep(38);
            SocketManager.Instance.out.syncWeakStep(8);
         }
         MagicStoneManager.instance.removeWeakGuide(0);
      }
      
      private function removeEvent() : void
      {
         _energyAddBtn.removeEventListener("click",__addEnergyHandler);
         _selfInfo.removeEventListener("propertychange",__onUpdateGrade);
         PlayerManager.Instance.removeEventListener("girl_head_photo_change",onHeadSelectChange);
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_headLoader)
         {
            _headLoader.dispose();
            _headLoader = null;
         }
         if(_headBitmap && _headBitmap.bitmapData)
         {
            _headBitmap.bitmapData.dispose();
            _headBitmap = null;
         }
         if(_headMask)
         {
            ObjectUtils.disposeObject(_headMask);
            _headMask = null;
         }
         if(_levelIcon)
         {
            _levelIcon.dispose();
            _levelIcon = null;
         }
         if(_energyProgress)
         {
            _energyProgress.dispose();
            _energyProgress = null;
         }
         if(_energyAddBtn)
         {
            _energyAddBtn.dispose();
            _energyAddBtn = null;
         }
         if(_nickNameText)
         {
            _nickNameText.dispose();
            _nickNameText = null;
         }
         if(_vipName)
         {
            _vipName.dispose();
            _vipName = null;
         }
      }
   }
}
