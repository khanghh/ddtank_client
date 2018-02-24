package gameCommon.view.smallMap
{
   import bombKing.BombKingControl;
   import bombKing.BombKingManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.map.MissionInfo;
   import ddt.events.DungeonInfoEvent;
   import ddt.events.RoomEvent;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.manager.TimeManager;
   import flash.display.Bitmap;
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import gameCommon.GameControl;
   import gameCommon.view.DungeonHelpView;
   import room.RoomManager;
   import setting.controll.SettingController;
   
   public class SmallMapTitleBar extends Sprite implements Disposeable
   {
      
      private static const Ellipse:int = 4;
       
      
      private var _w:int = 162;
      
      private var _h:int = 23;
      
      private var _hardTxt:FilterFrameText;
      
      private var _timeTxt:FilterFrameText;
      
      private var _timer:Timer;
      
      private var _punishTimes:int;
      
      private var _back:BackBar;
      
      private var _exitBtn:SimpleBitmapButton;
      
      private var _settingBtn:SimpleBitmapButton;
      
      private var _turnButton:GameTurnButton;
      
      private var _mission:MissionInfo;
      
      private var _missionHelp:DungeonHelpView;
      
      private var _fieldNameLoader:DisplayLoader;
      
      private var _fieldName:Bitmap;
      
      private var alert:BaseAlerFrame;
      
      private var alert1:BaseAlerFrame;
      
      private var alert2:BaseAlerFrame;
      
      private var _endTime:Number;
      
      public function SmallMapTitleBar(param1:MissionInfo)
      {
         super();
         _endTime = TimeManager.Instance.NowTime() + GameControl.Instance.Current.exitTimeLimit;
         _punishTimes = ServerConfigManager.instance.gameExitPunishTimes;
         configUI();
         addEvent();
      }
      
      private function configUI() : void
      {
         _back = new BackBar();
         addChild(_back);
         _back.visible = !GameControl.Instance.smallMapBorderEnable();
         _hardTxt = ComponentFactory.Instance.creatComponentByStylename("asset.game.smallMapHardTxt");
         addChild(_hardTxt);
         _settingBtn = ComponentFactory.Instance.creatComponentByStylename("asset.game.settingButton");
         setTip(_settingBtn,LanguageMgr.GetTranslation("tank.game.ToolStripView.set"));
         addChild(_settingBtn);
         _settingBtn.enable = !StateManager.RecordFlag;
         _exitBtn = ComponentFactory.Instance.creatComponentByStylename("asset.game.exitButton");
         setTip(_exitBtn,LanguageMgr.GetTranslation("tank.game.ToolStripView.exit"));
         addChild(_exitBtn);
         _turnButton = ComponentFactory.Instance.creatCustomObject("GameTurnButton",[this]);
         var _loc1_:int = RoomManager.Instance.current.type;
         if(!RoomManager.Instance.current.isDungeonType && _loc1_ != 5 && _loc1_ != 10 && _loc1_ != 19)
         {
            _fieldNameLoader = LoadResourceManager.Instance.createLoader(solveMapPath(),0);
            _fieldNameLoader.addEventListener("complete",__onLoadComplete);
            LoadResourceManager.Instance.startLoad(_fieldNameLoader);
            _back.tipStyle = "ddt.view.tips.PreviewTip";
            _back.tipDirctions = "3,1";
            _back.tipGapV = 5;
         }
         drawBackgound();
      }
      
      private function __onLoadComplete(param1:LoaderEvent) : void
      {
         _fieldNameLoader.removeEventListener("complete",__onLoadComplete);
         _back.tipData = Bitmap(_fieldNameLoader.content);
         ShowTipManager.Instance.addTip(_back);
      }
      
      private function solveMapPath() : String
      {
         var _loc2_:String = PathManager.SITE_MAIN + "image/map/";
         if(GameControl.Instance.Current.gameMode == 8)
         {
            _loc2_ = _loc2_ + "1133/icon.png";
            return _loc2_;
         }
         var _loc1_:int = GameControl.Instance.Current.mapIndex;
         if(RoomManager.Instance.current.mapId > 0)
         {
            _loc1_ = RoomManager.Instance.current.mapId;
         }
         _loc2_ = _loc2_ + (_loc1_.toString() + "/icon.png");
         return _loc2_;
      }
      
      public function get turnButton() : GameTurnButton
      {
         return _turnButton;
      }
      
      private function setTip(param1:SimpleBitmapButton, param2:String) : void
      {
         param1.tipStyle = "ddt.view.tips.OneLineTip";
         param1.tipDirctions = "3,6,1";
         param1.tipGapV = 5;
         param1.tipData = param2;
      }
      
      private function drawBackgound() : void
      {
         var _loc1_:* = null;
         if(!GameControl.Instance.smallMapBorderEnable())
         {
            _loc1_ = graphics;
            _loc1_.clear();
            _loc1_.lineStyle(1,3355443,1,true);
            _loc1_.beginFill(16777215,0.8);
            _loc1_.endFill();
            _loc1_.moveTo(0,_h);
            _loc1_.lineTo(0,4);
            _loc1_.curveTo(0,0,4,0);
            _loc1_.lineTo(_w - 4,0);
            _loc1_.curveTo(_w,0,_w,4);
            _loc1_.lineTo(_w,_h);
            _loc1_.endFill();
         }
         _exitBtn.x = _w - _exitBtn.width - 2;
         _settingBtn.x = _exitBtn.x - _settingBtn.width - 2;
         _turnButton.x = _settingBtn.x - _turnButton.width - 2;
      }
      
      public function setBarrier(param1:int, param2:int) : void
      {
         _turnButton.text = param1 + "/" + param2;
      }
      
      private function removeEvent() : void
      {
         _exitBtn.removeEventListener("click",__exit);
         _settingBtn.removeEventListener("click",__set);
         _turnButton.removeEventListener("click",__turnFieldClick);
      }
      
      private function addEvent() : void
      {
         _exitBtn.addEventListener("click",__exit);
         _settingBtn.addEventListener("click",__set);
         _turnButton.addEventListener("click",__turnFieldClick);
      }
      
      private function __turnFieldClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispatchEvent(new DungeonInfoEvent("DungeonHelpChanged"));
         StageReferance.stage.focus = null;
      }
      
      private function __turnCountChanged(param1:RoomEvent) : void
      {
         _turnButton.text = _mission.turnCount + "/" + _mission.maxTurnCount;
      }
      
      private function __set(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         SettingController.Instance.switchVisible();
      }
      
      private function __exit(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         if(RoomManager.Instance.current.selfRoomPlayer.isViewer)
         {
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.game.ToolStripView.isExit"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
            alert.addEventListener("response",__responseHandler);
            alert.addEventListener("keyDown",__onKeyDown);
            return;
         }
         if(RoomManager.Instance.current.type == 5)
         {
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.game.ToolStripView.isExitLib"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
            alert.addEventListener("response",__responseHandler);
            alert.addEventListener("keyDown",__onKeyDown);
            return;
         }
         if(RoomManager.Instance.current.type == 121)
         {
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.game.ToolStripView.isExitSurvival"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
            alert.addEventListener("response",__responseHandler);
            alert.addEventListener("keyDown",__onKeyDown);
            return;
         }
         if(!GameControl.Instance.Current.selfGamePlayer.isLiving)
         {
            if(GameControl.Instance.Current.selfGamePlayer.selfDieTimeDelayPassed)
            {
               if(RoomManager.Instance.current.type >= 2)
               {
                  alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.game.ToolStripView.isExit"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
                  alert.addEventListener("response",__responseHandler);
                  alert.addEventListener("keyDown",__onKeyDown);
                  return;
               }
            }
         }
         if(RoomManager.Instance.current.type >= 2 && RoomManager.Instance.current.type != 12 && RoomManager.Instance.current.type != 13 && RoomManager.Instance.current.type != 16 && RoomManager.Instance.current.type != 18 && RoomManager.Instance.current.type != 25 && RoomManager.Instance.current.type != 23 && RoomManager.Instance.current.type != 40 && RoomManager.Instance.current.type != 121 && RoomManager.Instance.current.type != 123 && RoomManager.Instance.current.type != 58)
         {
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.game.ToolStripView.isExit"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
            alert.addEventListener("response",__responseHandler);
            alert.addEventListener("keyDown",__onKeyDown);
            return;
         }
         if(RoomManager.Instance.current.type == 23 || RoomManager.Instance.current.type == 123)
         {
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.missionsettle.dungeon.leaveConfirm.contents"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2);
            alert.addEventListener("response",__responseHandler);
            alert.addEventListener("keyDown",__onKeyDown);
            return;
         }
         if(RoomManager.Instance.current.type == 40)
         {
            alert2 = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.game.ToolStripView.isExit"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2);
            alert2.addEventListener("response",__responseChristmasHandler);
            alert2.addEventListener("keyDown",__onKeyDown);
            return;
         }
         if(_endTime > TimeManager.Instance.NowTime())
         {
            _loc2_ = LanguageMgr.GetTranslation("tank.game.ToolStripView.isExitPVP2",GameControl.Instance.Current.exitTimes);
            alert1 = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),_loc2_,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2);
            alert1.addEventListener("response",__responseHandler);
            alert1.addEventListener("keyDown",__onKeyDown);
            _timeTxt = ComponentFactory.Instance.creatComponentByStylename("asset.game.smallMap.timeTxt");
            alert1.addToContent(_timeTxt);
            updateTime();
            if(!_timer)
            {
               _timer = new Timer(1000);
               _timer.addEventListener("timer",__onTimerDown);
            }
            _timer.reset();
            _timer.start();
         }
         else
         {
            _loc2_ = LanguageMgr.GetTranslation("tank.game.ToolStripView.isExitPVP",_punishTimes);
            alert1 = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),_loc2_,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2);
            alert1.addEventListener("response",__responseHandler);
            alert1.addEventListener("keyDown",__onKeyDown);
         }
      }
      
      private function __onTimerDown(param1:TimerEvent) : void
      {
         updateTime();
      }
      
      private function updateTime() : void
      {
         var _loc2_:Number = NaN;
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:* = null;
         var _loc4_:* = null;
         if(_timeTxt)
         {
            _loc2_ = _endTime - TimeManager.Instance.NowTime();
            if(_loc2_ < 0)
            {
               _timeTxt.text = "00:00";
            }
            else
            {
               _loc1_ = _loc2_ / 60000;
               _loc3_ = (_loc2_ - _loc1_ * 60000) / 1000;
               _loc5_ = _loc1_ > 9?_loc1_.toString():"0" + _loc1_;
               _loc4_ = _loc3_ > 9?_loc3_.toString():"0" + _loc3_;
               _timeTxt.text = _loc5_ + ":" + _loc4_;
            }
         }
      }
      
      private function __responseChristmasHandler(param1:FrameEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            GameInSocketOut.sendGamePlayerExit();
         }
         if(param1.target == alert)
         {
            alert = null;
         }
         else if(param1.target == alert1)
         {
            alert1 = null;
         }
         else if(param1.target == alert2)
         {
            alert2 = null;
         }
         (param1.target as BaseAlerFrame).removeEventListener("response",__responseChristmasHandler);
         (param1.target as BaseAlerFrame).dispose();
      }
      
      private function __onKeyDown(param1:KeyboardEvent) : void
      {
         param1.stopImmediatePropagation();
         if(param1.keyCode == 13)
         {
            (param1.currentTarget as BaseAlerFrame).dispatchEvent(new FrameEvent(2));
         }
         else if(param1.keyCode == 27)
         {
            (param1.currentTarget as BaseAlerFrame).dispatchEvent(new FrameEvent(1));
         }
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            if(BombKingManager.instance.Recording)
            {
               BombKingControl.instance.reset();
               StateManager.setState("main");
            }
            else if(param1.target == alert1 && TimeManager.Instance.NowTime() < _endTime)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.game.ToolStripView.cannotExit"));
            }
            else
            {
               GameInSocketOut.sendGamePlayerExit();
               SocketManager.Instance.out.outCampBatttle();
            }
         }
         if(param1.currentTarget == alert)
         {
            alert = null;
         }
         else if(param1.currentTarget == alert1)
         {
            ObjectUtils.disposeObject(_timeTxt);
            if(_timer)
            {
               _timer.stop();
            }
            alert1 = null;
         }
         (param1.currentTarget as BaseAlerFrame).removeEventListener("keyDown",__onKeyDown);
         (param1.currentTarget as BaseAlerFrame).removeEventListener("response",__responseHandler);
         (param1.currentTarget as BaseAlerFrame).dispose();
      }
      
      public function set enableExit(param1:Boolean) : void
      {
         _exitBtn.enable = param1;
      }
      
      override public function set width(param1:Number) : void
      {
         _w = param1;
         _back.width = param1 + 0.5;
         drawBackgound();
      }
      
      override public function set height(param1:Number) : void
      {
         _h = param1;
         drawBackgound();
      }
      
      public function set title(param1:String) : void
      {
         _hardTxt.text = param1;
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__onTimerDown);
            _timer = null;
         }
         if(_hardTxt)
         {
            ObjectUtils.disposeObject(_hardTxt);
            _hardTxt = null;
         }
         if(_exitBtn)
         {
            ObjectUtils.disposeObject(_exitBtn);
            _exitBtn = null;
         }
         if(_settingBtn)
         {
            ObjectUtils.disposeObject(_settingBtn);
            _settingBtn = null;
         }
         if(_turnButton)
         {
            ObjectUtils.disposeObject(_turnButton);
            _turnButton = null;
         }
         if(_back)
         {
            ObjectUtils.disposeObject(_back);
            _back = null;
         }
         if(_fieldName)
         {
            ObjectUtils.disposeObject(_fieldName);
         }
         _fieldName = null;
         if(_fieldNameLoader)
         {
            _fieldNameLoader.removeEventListener("complete",__onLoadComplete);
         }
         _fieldNameLoader = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

import com.pickgliss.ui.ComponentFactory;
import com.pickgliss.ui.core.Disposeable;
import com.pickgliss.ui.core.ITipedDisplay;
import com.pickgliss.utils.ObjectUtils;
import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.display.Graphics;
import flash.display.Sprite;
import flash.geom.Matrix;

class BackBar extends Sprite implements Disposeable, ITipedDisplay
{
    
   
   private var _w:Number = 1;
   
   private var _back1:Bitmap;
   
   private var _back2:Bitmap;
   
   private var _back3:Bitmap;
   
   protected var _tipData:Object;
   
   protected var _tipDirction:String;
   
   protected var _tipGapV:int;
   
   protected var _tipGapH:int;
   
   protected var _tipStyle:String;
   
   function BackBar()
   {
      super();
      _back1 = ComponentFactory.Instance.creatBitmap("asset.game.smallmap.TitleBack1");
      _back2 = ComponentFactory.Instance.creatBitmap("asset.game.smallmap.TitleBack2");
      _back3 = ComponentFactory.Instance.creatBitmap("asset.game.smallmap.TitleBack3");
   }
   
   override public function set width(param1:Number) : void
   {
      _w = param1;
      draw();
   }
   
   private function draw() : void
   {
      var _loc2_:Graphics = graphics;
      _loc2_.clear();
      _loc2_.beginBitmapFill(_back1.bitmapData,null,true,true);
      _loc2_.drawRect(0,0,_back1.width,_back1.height);
      _loc2_.endFill();
      _loc2_.beginBitmapFill(_back2.bitmapData,null,true,true);
      _loc2_.drawRect(_back1.width,0,_w - _back1.width - _back3.width,_back1.height);
      _loc2_.endFill();
      var _loc1_:Matrix = new Matrix();
      _loc1_.tx = _w - _back3.width;
      _loc2_.beginBitmapFill(_back3.bitmapData,_loc1_,true,true);
      _loc2_.drawRect(_w - _back3.width,0,_back3.width,_back1.height);
      _loc2_.endFill();
   }
   
   public function get tipData() : Object
   {
      return _tipData;
   }
   
   public function set tipData(param1:Object) : void
   {
      if(_tipData == param1)
      {
         return;
      }
      _tipData = param1;
   }
   
   public function get tipDirctions() : String
   {
      return _tipDirction;
   }
   
   public function set tipDirctions(param1:String) : void
   {
      if(_tipDirction == param1)
      {
         return;
      }
      _tipDirction = param1;
   }
   
   public function get tipGapV() : int
   {
      return _tipGapV;
   }
   
   public function set tipGapV(param1:int) : void
   {
      if(_tipGapV == param1)
      {
         return;
      }
      _tipGapV = param1;
   }
   
   public function get tipGapH() : int
   {
      return _tipGapH;
   }
   
   public function set tipGapH(param1:int) : void
   {
      if(_tipGapH == param1)
      {
         return;
      }
      _tipGapH = param1;
   }
   
   public function get tipStyle() : String
   {
      return _tipStyle;
   }
   
   public function set tipStyle(param1:String) : void
   {
      if(_tipStyle == param1)
      {
         return;
      }
      _tipStyle = param1;
   }
   
   public function asDisplayObject() : DisplayObject
   {
      return this;
   }
   
   public function dispose() : void
   {
      if(_back1)
      {
         ObjectUtils.disposeObject(_back1);
         _back1 = null;
      }
      if(_back2)
      {
         ObjectUtils.disposeObject(_back2);
         _back2 = null;
      }
      if(_back3)
      {
         ObjectUtils.disposeObject(_back3);
         _back3 = null;
      }
      if(parent)
      {
         parent.removeChild(this);
      }
   }
}
