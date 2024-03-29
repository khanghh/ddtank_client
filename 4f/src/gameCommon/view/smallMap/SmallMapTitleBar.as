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
   import ddt.data.PathInfo;
   import ddt.data.map.MissionInfo;
   import ddt.events.DungeonInfoEvent;
   import ddt.events.RoomEvent;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.manager.TimeManager;
   import flash.display.Bitmap;
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
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
      
      private var _startDate:Date;
      
      public function SmallMapTitleBar(param1:MissionInfo){super();}
      
      private function configUI() : void{}
      
      private function __onLoadComplete(param1:LoaderEvent) : void{}
      
      private function solveMapPath() : String{return null;}
      
      public function get turnButton() : GameTurnButton{return null;}
      
      private function setTip(param1:SimpleBitmapButton, param2:String) : void{}
      
      private function drawBackgound() : void{}
      
      public function setBarrier(param1:int, param2:int) : void{}
      
      private function removeEvent() : void{}
      
      private function addEvent() : void{}
      
      private function __turnFieldClick(param1:MouseEvent) : void{}
      
      private function __turnCountChanged(param1:RoomEvent) : void{}
      
      private function __set(param1:MouseEvent) : void{}
      
      private function __exit(param1:MouseEvent) : void{}
      
      private function __responseChristmasHandler(param1:FrameEvent) : void{}
      
      private function __onKeyDown(param1:KeyboardEvent) : void{}
      
      private function __responseHandler(param1:FrameEvent) : void{}
      
      public function set enableExit(param1:Boolean) : void{}
      
      override public function set width(param1:Number) : void{}
      
      override public function set height(param1:Number) : void{}
      
      public function set title(param1:String) : void{}
      
      public function dispose() : void{}
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
   
   function BackBar(){super();}
   
   override public function set width(param1:Number) : void{}
   
   private function draw() : void{}
   
   public function get tipData() : Object{return null;}
   
   public function set tipData(param1:Object) : void{}
   
   public function get tipDirctions() : String{return null;}
   
   public function set tipDirctions(param1:String) : void{}
   
   public function get tipGapV() : int{return 0;}
   
   public function set tipGapV(param1:int) : void{}
   
   public function get tipGapH() : int{return 0;}
   
   public function set tipGapH(param1:int) : void{}
   
   public function get tipStyle() : String{return null;}
   
   public function set tipStyle(param1:String) : void{}
   
   public function asDisplayObject() : DisplayObject{return null;}
   
   public function dispose() : void{}
}
