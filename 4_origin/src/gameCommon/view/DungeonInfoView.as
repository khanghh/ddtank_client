package gameCommon.view
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.data.map.MissionInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.GameEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextFormat;
   import gameCommon.GameControl;
   import gameCommon.view.smallMap.GameTurnButton;
   import labyrinth.LabyrinthManager;
   import road7th.comm.PackageIn;
   import room.RoomManager;
   
   public class DungeonInfoView extends Sprite
   {
       
      
      private var _bg:Bitmap;
      
      private var _helpBtn:SimpleBitmapButton;
      
      private var _title1:FilterFrameText;
      
      private var _title2:FilterFrameText;
      
      private var _title3:FilterFrameText;
      
      private var _title4:FilterFrameText;
      
      private var _info1:FilterFrameText;
      
      private var _info2:FilterFrameText;
      
      private var _info3:FilterFrameText;
      
      private var _info4:FilterFrameText;
      
      private var _info:MissionInfo;
      
      private var _button:GameTurnButton;
      
      private var _container:DisplayObjectContainer;
      
      private var _sourceRect:Rectangle;
      
      private var _tweened:Boolean = false;
      
      private var _totalTrunTrainer:int = 100;
      
      private var _Vy:int;
      
      private var _textFormat:TextFormat;
      
      private var arrowCount:int;
      
      public function DungeonInfoView(button:GameTurnButton, container:DisplayObjectContainer)
      {
         super();
         _bg = ComponentFactory.Instance.creatBitmap("asset.game.missionInfoBgAsset");
         addChild(_bg);
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("asset.game.missionInfoViewButton");
         addChild(_helpBtn);
         _title1 = ComponentFactory.Instance.creatComponentByStylename("asset.game.missionInfoTitle1Txt");
         addChild(_title1);
         _title2 = ComponentFactory.Instance.creatComponentByStylename("asset.game.missionInfoTitle2Txt");
         addChild(_title2);
         _title3 = ComponentFactory.Instance.creatComponentByStylename("asset.game.missionInfoTitle3Txt");
         addChild(_title3);
         _title4 = ComponentFactory.Instance.creatComponentByStylename("asset.game.missionInfoTitle4Txt");
         addChild(_title4);
         _info1 = ComponentFactory.Instance.creatComponentByStylename("asset.game.missionInfo1Txt");
         addChild(_info1);
         _info2 = ComponentFactory.Instance.creatComponentByStylename("asset.game.missionInfo2Txt");
         addChild(_info2);
         _info3 = ComponentFactory.Instance.creatComponentByStylename("asset.game.missionInfo3Txt");
         addChild(_info3);
         _info4 = ComponentFactory.Instance.creatComponentByStylename("asset.game.missionInfo4Txt");
         addChild(_info4);
         _info = GameControl.Instance.Current.missionInfo;
         if(_info.title1)
         {
            _title1.text = _info.title1;
         }
         if(_info.title2)
         {
            _title2.text = _info.title2;
         }
         if(_info.title3)
         {
            _title3.text = _info.title3;
         }
         if(_info.title4)
         {
            _title4.text = _info.title4;
         }
         if(RoomManager.Instance.current.type == 29)
         {
            _title4.text = LanguageMgr.GetTranslation("rescue.remainArrow");
         }
         else if(RoomManager.Instance.current.type == 52)
         {
            _title1.visible = false;
            _info1.visible = false;
         }
         else if(RoomManager.Instance.current.type == 49)
         {
            _title1.text = LanguageMgr.GetTranslation("tank.game.actions.turn");
            _title2.text = LanguageMgr.GetTranslation("game.view.DungeonInfoView.title2");
            _title3.text = LanguageMgr.GetTranslation("game.view.DungeonInfoView.title4");
            var _loc4_:Boolean = false;
            _info4.visible = _loc4_;
            _title4.visible = _loc4_;
         }
         _sourceRect = getBounds(this);
         var barrierPos:Point = ComponentFactory.Instance.creatCustomObject("asset.game.barrierPos");
         _sourceRect.x = barrierPos.x;
         _sourceRect.y = barrierPos.y;
         _container = container;
         _button = button;
         _textFormat = ComponentFactory.Instance.model.getSet("game.missionInfoTitle_Text2");
         addEvent();
      }
      
      private function addEvent() : void
      {
         _helpBtn.addEventListener("click",__openHelpHandler);
         addEventListener("update_activitydungeon_info",__updateActivityInfo);
      }
      
      protected function __updateActivityInfo(event:Event) : void
      {
         _title2.text = LanguageMgr.GetTranslation("game.view.DungeonInfoView.title5") + GameControl.Instance.bossName;
         _title3.text = LanguageMgr.GetTranslation("game.view.DungeonInfoView.title4");
         _info3.text = GameControl.Instance.currentNum.toString();
         if(RoomManager.Instance.current.type == 49 && _info)
         {
            _info3.text = _info.currentValue3.toString();
         }
         _title3.setTextFormat(_textFormat);
         _info3.setTextFormat(_textFormat);
      }
      
      private function removeEvent() : void
      {
         _helpBtn.removeEventListener("click",__openHelpHandler);
      }
      
      private function __openHelpHandler(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispatchEvent(new GameEvent("DungeonHelpVisibleChanged",true));
      }
      
      public function barrierInfoHandler(evt:CrazyTankSocketEvent) : void
      {
         _info = GameControl.Instance.Current.missionInfo;
         var pkg:PackageIn = evt.pkg;
         _info.currentValue1 = pkg.readInt();
         _info.currentValue2 = pkg.readInt();
         _info.currentValue3 = pkg.readInt();
         _info.currentValue4 = pkg.readInt();
         upView();
         dispatchEvent(new GameEvent("updateSmallMapView",true));
      }
      
      public function trainerView($currentTrun:int) : void
      {
         _title1.text = "TRUN";
         if($currentTrun == -1)
         {
            _info1.text = "";
            return;
         }
         _info1.text = $currentTrun.toString() + "/" + _totalTrunTrainer.toString();
         if(_totalTrunTrainer == $currentTrun)
         {
            StateManager.setState("main");
         }
      }
      
      public function open() : void
      {
         TweenLite.killTweensOf(this);
         var bounds:Rectangle = _button.getBounds(_container);
         x = bounds.x;
         y = bounds.y;
         width = bounds.width;
         height = bounds.height;
         _container.addChild(this);
         TweenLite.to(this,0.3,{
            "x":_sourceRect.x,
            "y":_sourceRect.y,
            "width":_sourceRect.width,
            "height":_sourceRect.height
         });
      }
      
      private function closeComplete() : void
      {
         if(parent)
         {
            parent.removeChild(this);
         }
         if(_button)
         {
            _button.shine();
         }
      }
      
      public function close() : void
      {
         TweenLite.killTweensOf(this);
         x = _sourceRect.x;
         y = _sourceRect.y;
         width = _sourceRect.width;
         height = _sourceRect.height;
         var bounds:Rectangle = _button.getBounds(_container);
         TweenLite.to(this,0.3,{
            "x":bounds.x,
            "y":bounds.y,
            "width":bounds.width,
            "height":bounds.height,
            "onComplete":closeComplete
         });
         dispatchEvent(new GameEvent("DungeonHelpVisibleChanged",false));
      }
      
      private function upView() : void
      {
         if(_info.currentValue1 != -1 && _info.totalValue1 > 0)
         {
            _info1.text = _info.currentValue1 + "/" + _info.totalValue1;
         }
         if(_info.currentValue2 != -1 && _info.totalValue2 > 0)
         {
            _info2.text = _info.currentValue2 + "/" + _info.totalValue2;
         }
         if(_info.currentValue3 != -1 && _info.totalValue3 > 0)
         {
            _info3.text = _info.currentValue3 + "/" + _info.totalValue3;
         }
         if(_info.currentValue4 != -1 && _info.totalValue4 > 0)
         {
            _info4.text = _info.currentValue4 + "/" + _info.totalValue4;
         }
         if(RoomManager.Instance.current.type == 15)
         {
            _title3.text = LanguageMgr.GetTranslation("game.view.DungeonInfoView.title3");
            _info3.text = LabyrinthManager.Instance.model.currentFloor.toString();
            _title3.setTextFormat(_textFormat);
            _info3.setTextFormat(_textFormat);
         }
         else if(RoomManager.Instance.current.type == 49)
         {
            _info3.text = _info.currentValue3.toString();
            _title3.setTextFormat(_textFormat);
            _info3.setTextFormat(_textFormat);
         }
         else if(RoomManager.Instance.current.type == 70)
         {
            _info3.text = _info.currentValue3.toString();
            _title3.setTextFormat(_textFormat);
            _info3.setTextFormat(_textFormat);
         }
         if(RoomManager.Instance.current.type == 29)
         {
            _info4.text = arrowCount.toString();
         }
      }
      
      public function setRescueArrow(count:int) : void
      {
         arrowCount = count;
         _info4.text = arrowCount.toString();
      }
      
      public function dispose() : void
      {
         TweenLite.killTweensOf(this);
         removeEvent();
         removeChild(_bg);
         _bg.bitmapData.dispose();
         _bg = null;
         _helpBtn.dispose();
         _helpBtn = null;
         _title1.dispose();
         _title1 = null;
         _title2.dispose();
         _title2 = null;
         _title3.dispose();
         _title3 = null;
         _title4.dispose();
         _title4 = null;
         _info1.dispose();
         _info1 = null;
         _info2.dispose();
         _info2 = null;
         _info3.dispose();
         _info3 = null;
         _info4.dispose();
         _info4 = null;
         _info = null;
         _button = null;
         _container = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
