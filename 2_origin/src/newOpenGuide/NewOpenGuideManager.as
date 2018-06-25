package newOpenGuide
{
   import bagAndInfo.BagAndInfoManager;
   import cityWide.CityWideManager;
   import com.greensock.TweenLite;
   import com.pickgliss.layout.StageResizeUtils;
   import com.pickgliss.manager.CacheSysManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.StateManager;
   import ddt.view.MainToolBar;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.setTimeout;
   import hall.HallStateView;
   import hall.IHallStateView;
   import starling.scene.hall.HallPlayerView;
   import trainer.view.NewHandContainer;
   
   public class NewOpenGuideManager extends EventDispatcher
   {
      
      private static var _instance:NewOpenGuideManager;
       
      
      public const openLevelList:Array = [3,5,6,7,20,10,11,8,13,15,14,16,17,18,22,29,24,99,23,19,25,12,30,45,50,70,31,26];
      
      public const openMovePosList:Array = [new Point(662,144),new Point(399,169),new Point(0,0),new Point(635,6),new Point(219,96),new Point(445,-10),new Point(0,0),new Point(891,540),new Point(780,543),new Point(780,543),new Point(445,-10),new Point(780,543),new Point(445,-10),new Point(445,-10),new Point(732,543),new Point(891,540),new Point(891,540),new Point(891,540),new Point(891,540),new Point(0,0),new Point(0,0),new Point(0,0),new Point(445,-10),new Point(445,-10),new Point(638,558),new Point(638,558),new Point(740,550),new Point(891,540)];
      
      public const titleStrList:Array = LanguageMgr.GetTranslation("newOpenGuide.openTitleListStr").split(",");
      
      private var _rightView:NewOpenGuideRightView;
      
      private var _hall:IHallStateView;
      
      private var _playerView:HallPlayerView;
      
      private var _dialog:NewOpenGuideDialogView;
      
      private var _coverSpriteInPlayCartoon:Sprite;
      
      public function NewOpenGuideManager(target:IEventDispatcher = null)
      {
         super(target);
      }
      
      public static function get instance() : NewOpenGuideManager
      {
         if(_instance == null)
         {
            _instance = new NewOpenGuideManager();
         }
         return _instance;
      }
      
      public function getMovePos() : Point
      {
         var i:int = 0;
         var tmpPos:* = null;
         var curLevel:int = PlayerManager.Instance.Self.Grade;
         var tmpLen:int = openLevelList.length;
         for(i = 0; i < tmpLen; )
         {
            if(curLevel == openLevelList[i])
            {
               tmpPos = openMovePosList[i];
               if(tmpPos.x == 0 && tmpPos.y == 0)
               {
                  return MainToolBar.Instance.newBtnOpenCartoon();
               }
               return tmpPos;
            }
            i++;
         }
         return new Point(445,-10);
      }
      
      public function getTitleStrIndexByLevel(level:int) : Array
      {
         var i:int = 0;
         var reArray:Array = [-1,"",-1];
         var titleStr:String = "";
         var tmpIndex:int = -1;
         var tmpLen:int = openLevelList.length;
         for(i = 0; i < tmpLen; )
         {
            if(level == openLevelList[i])
            {
               titleStr = titleStrList[i];
               tmpIndex = i + 1;
               break;
            }
            i++;
         }
         reArray[0] = tmpIndex;
         reArray[1] = titleStr;
         reArray[2] = level;
         return reArray;
      }
      
      public function closeShow() : void
      {
         _playerView = null;
         ObjectUtils.disposeObject(_rightView);
         _rightView = null;
         PlayerManager.Instance.Self.removeEventListener("propertychange",__propertyChange);
      }
      
      public function checkShow(playerView:HallPlayerView, $hall:IHallStateView) : void
      {
         _hall = $hall;
         _playerView = playerView;
         _rightView = new NewOpenGuideRightView();
         _rightView.x = 845;
         _rightView.y = 140;
         LayerManager.Instance.addToLayer(_rightView,4);
         StageResizeUtils.Instance.addAutoResize(_rightView);
         judgeMiddleView();
         PlayerManager.Instance.Self.addEventListener("propertychange",__propertyChange);
      }
      
      private function __propertyChange(event:PlayerPropertyEvent) : void
      {
         var canShowONS:Boolean = false;
         var grade:int = 0;
         if(event.changedProperties["Grade"])
         {
            canShowONS = false;
            grade = PlayerManager.Instance.Self.Grade;
            var _loc4_:* = grade;
            if(14 !== _loc4_)
            {
               if(17 !== _loc4_)
               {
                  if(18 !== _loc4_)
                  {
                     if(19 !== _loc4_)
                     {
                        if(27 !== _loc4_)
                        {
                           if(30 !== _loc4_)
                           {
                              if(45 !== _loc4_)
                              {
                                 if(50 !== _loc4_)
                                 {
                                    if(70 !== _loc4_)
                                    {
                                       canShowONS = true;
                                    }
                                    else
                                    {
                                       CacheSysManager.lock("ddtkingGrade");
                                    }
                                 }
                                 else
                                 {
                                    CacheSysManager.lock("guard_core");
                                 }
                              }
                              else
                              {
                                 CacheSysManager.lock("crypt_guide");
                              }
                           }
                           else
                           {
                              CacheSysManager.lock("secret_area_guide");
                           }
                        }
                        else
                        {
                           CacheSysManager.lock("arena_guide");
                        }
                     }
                     else
                     {
                        CacheSysManager.lock("farm_guide");
                     }
                  }
                  else
                  {
                     CacheSysManager.lock("sales_room_guide");
                  }
               }
               else
               {
                  CacheSysManager.lock("consortia_guide");
               }
            }
            else
            {
               CacheSysManager.lock("church_guide");
            }
            if(canShowONS == false)
            {
               CityWideManager.Instance.hideView();
            }
            if(_rightView)
            {
               _rightView.refreshView();
            }
            judgeMiddleView();
            if(PlayerManager.Instance.Self.Grade >= 10)
            {
               openAllTool();
            }
         }
      }
      
      private function openAllTool() : void
      {
         SocketManager.Instance.out.syncWeakStep(10);
         SocketManager.Instance.out.syncWeakStep(12);
         SocketManager.Instance.out.syncWeakStep(11);
         SocketManager.Instance.out.syncWeakStep(12);
         SocketManager.Instance.out.syncWeakStep(5);
         SocketManager.Instance.out.syncWeakStep(2);
         SocketManager.Instance.out.syncWeakStep(51);
         SocketManager.Instance.out.syncWeakStep(52);
         SocketManager.Instance.out.syncWeakStep(55);
         SocketManager.Instance.out.syncWeakStep(56);
         SocketManager.Instance.out.syncWeakStep(57);
      }
      
      private function judgeMiddleView() : void
      {
         var tmp:Array = getTitleStrIndexByLevel(PlayerManager.Instance.Self.Grade);
         if(tmp[0] > 0 && !PlayerManager.Instance.Self.isNewOnceFinish(200 + tmp[2]))
         {
            setTimeout(createOpenView,1000);
         }
      }
      
      private function createOpenCartoon() : void
      {
         var mc:MovieClip = ComponentFactory.Instance.creat(getOpenCartoonClassName());
         mc.mouseChildren = false;
         mc.mouseEnabled = false;
         mc.addEventListener("enterFrame",openCartoonPlayFrame);
         mc.gotoAndPlay(1);
         var hallStateView:HallStateView = StateManager.getState("main") as HallStateView;
         if(hallStateView)
         {
            hallStateView.bgSprite.addChild(mc);
         }
      }
      
      private function openCartoonPlayFrame(event:Event) : void
      {
         var mc:MovieClip = event.currentTarget as MovieClip;
         if(mc.currentFrame == mc.totalFrames)
         {
            if(mc.parent)
            {
               mc.parent.removeChild(mc);
            }
            mc.stop();
            mc.removeEventListener("enterFrame",openCartoonPlayFrame);
            checkGuide();
         }
      }
      
      private function checkGuide() : void
      {
         var coverType:* = null;
         var argsArr:* = null;
         var arrowPos:* = null;
         var isClickBag:Boolean = false;
         if(PlayerManager.Instance.Self.Grade >= 10)
         {
            _playerView.mapID = 0;
            SocketManager.Instance.out.sendLoadOtherPlayer();
         }
         var grade:int = PlayerManager.Instance.Self.Grade;
         var rotation:int = 135;
         var _loc7_:* = grade;
         if(14 !== _loc7_)
         {
            if(17 !== _loc7_)
            {
               if(18 !== _loc7_)
               {
                  if(19 !== _loc7_)
                  {
                     if(27 !== _loc7_)
                     {
                        if(30 !== _loc7_)
                        {
                           if(45 !== _loc7_)
                           {
                              if(50 !== _loc7_)
                              {
                                 if(70 === _loc7_)
                                 {
                                    coverType = "circle";
                                    argsArr = [644,565,22];
                                    arrowPos = new Point(646,481);
                                    rotation = 0;
                                    CacheSysManager.unlock("ddtkingGrade");
                                    isClickBag = true;
                                 }
                              }
                              else
                              {
                                 coverType = "circle";
                                 argsArr = [644,565,22];
                                 arrowPos = new Point(646,481);
                                 rotation = 0;
                                 CacheSysManager.unlock("guard_core");
                                 isClickBag = true;
                              }
                           }
                           else
                           {
                              coverType = "rect";
                              argsArr = [785,385,220,150];
                              arrowPos = new Point(710,326);
                              rotation = -45;
                              CacheSysManager.unlock("crypt_guide");
                           }
                        }
                        else
                        {
                           coverType = "ellipse";
                           argsArr = [445,0,300,400];
                           arrowPos = new Point(760,385);
                           CacheSysManager.unlock("secret_area_guide");
                        }
                     }
                     else
                     {
                        coverType = "rect";
                        argsArr = [685,0,335,380];
                        arrowPos = new Point(607,206);
                        rotation = -90;
                        CacheSysManager.unlock("arena_guide");
                     }
                  }
                  else
                  {
                     coverType = "circle";
                     argsArr = [589,173,142];
                     arrowPos = new Point(739,329);
                     CacheSysManager.unlock("farm_guide");
                  }
               }
               else
               {
                  coverType = "ellipse";
                  argsArr = [439,173,142,223];
                  arrowPos = new Point(608,395);
                  CacheSysManager.unlock("sales_room_guide");
               }
            }
            else
            {
               coverType = "ellipse";
               argsArr = [395,210,100,200];
               arrowPos = new Point(540,436);
               CacheSysManager.unlock("consortia_guide");
            }
         }
         else
         {
            coverType = "ellipse";
            argsArr = [436,190,100,180];
            arrowPos = new Point(579,342);
            CacheSysManager.unlock("church_guide");
         }
         if(grade > 10 && coverType != null)
         {
            _hall.hideRightGrid();
            TweenLite.to(_rightView,0.8,{"x":1000});
            _playerView.touchable = false;
            NewHandContainer.Instance.showGuideCover(coverType,argsArr);
            NewHandContainer.Instance.showArrow(100000,rotation,arrowPos,"","",LayerManager.Instance.getLayerByType(4),0,true);
            if(isClickBag)
            {
               BagAndInfoManager.Instance.addEventListener("open",__onBagOpenClikc);
            }
            else
            {
               (_hall as EventDispatcher).addEventListener("hall_area_clicked",onHallAreaClick);
               (_hall as EventDispatcher).addEventListener("hall_player_arrived",onHallPlayerArrived);
            }
         }
         if(grade <= 10)
         {
            _playerView.setCenter();
         }
         if(_coverSpriteInPlayCartoon && _coverSpriteInPlayCartoon.parent)
         {
            _coverSpriteInPlayCartoon.parent.removeChild(_coverSpriteInPlayCartoon);
         }
         _coverSpriteInPlayCartoon = null;
      }
      
      protected function __onBagOpenClikc(e:Event) : void
      {
         if(_playerView)
         {
            _rightView.x = 845;
            _hall.showRightGrid();
            _playerView.touchable = true;
            BagAndInfoManager.Instance.removeEventListener("open",__onBagOpenClikc);
            NewHandContainer.Instance.clearArrowByID(100000);
            NewHandContainer.Instance.hideGuideCover();
         }
      }
      
      protected function onHallAreaClick(e:CEvent) : void
      {
         if(_playerView)
         {
            _playerView.touchable = true;
            (_hall as EventDispatcher).removeEventListener("hall_area_clicked",onHallAreaClick);
            NewHandContainer.Instance.hideGuideCover();
            NewHandContainer.Instance.clearArrowByID(100000);
            NewHandContainer.Instance.showCover(0,0);
         }
      }
      
      protected function onHallPlayerArrived(e:CEvent) : void
      {
         _rightView.x = 845;
         (_hall as EventDispatcher).removeEventListener("hall_player_arrived",onHallPlayerArrived);
         NewHandContainer.Instance.hideGuideCover();
      }
      
      private function createOpenView() : void
      {
         var middleView:NewOpenGuideMiddleView = new NewOpenGuideMiddleView();
         middleView.addEventListener("complete",middleViewCompleteHandler);
         LayerManager.Instance.addToLayer(middleView,0,true,1);
      }
      
      private function middleViewCompleteHandler(event:Event) : void
      {
         var tmpPos:* = null;
         var selfPos:* = null;
         var delay:Number = NaN;
         var tmp:NewOpenGuideMiddleView = event.currentTarget as NewOpenGuideMiddleView;
         tmp.removeEventListener("complete",middleViewCompleteHandler);
         var level:int = PlayerManager.Instance.Self.Grade;
         if(isHasOpenCartoon())
         {
            _coverSpriteInPlayCartoon = new Sprite();
            _coverSpriteInPlayCartoon.graphics.beginFill(0,0);
            _coverSpriteInPlayCartoon.graphics.drawRect(-500,-300,2000,1200);
            _coverSpriteInPlayCartoon.graphics.endFill();
            LayerManager.Instance.addToLayer(_coverSpriteInPlayCartoon,0);
            if(level >= 3)
            {
               tmpPos = getMapMovePos();
               if(tmpPos)
               {
                  selfPos = _playerView.getSelfPlayerPos();
                  delay = Math.abs(tmpPos.x - selfPos.x) / 1000;
                  _playerView.moveBgToTargetPos(tmpPos.x,tmpPos.y,delay);
                  setTimeout(createOpenCartoon,delay * 1000);
               }
            }
            else
            {
               createOpenCartoon();
            }
         }
         else if(level > 10)
         {
            tmpPos = getMapMovePos();
            if(tmpPos.x != 0)
            {
               selfPos = _playerView.getSelfPlayerPos();
               delay = Math.abs(tmpPos.x - selfPos.x) / 1000;
               _playerView.moveBgToTargetPos(tmpPos.x,tmpPos.y,delay);
               setTimeout(checkGuide,(delay + 1) * 1000);
            }
            else
            {
               checkGuide();
            }
         }
         disposeDialogView();
         if((level == 3 || level == 5 || level == 6 || level == 10) && !PlayerManager.Instance.Self.IsWeakGuildFinish(144))
         {
            _dialog = new NewOpenGuideDialogView();
            if(level == 3)
            {
               _dialog.show(LanguageMgr.GetTranslation("newOpenGuide.roomListOpenPrompt"));
            }
            else if(level == 5)
            {
               _dialog.show(LanguageMgr.GetTranslation("newOpenGuide.storeOpenPrompt"));
            }
            else if(level == 6)
            {
               _dialog.show(LanguageMgr.GetTranslation("newOpenGuide.reFight"));
            }
            else if(level == 10)
            {
               _dialog.show(LanguageMgr.GetTranslation("newOpenGuide.crossDoorPrompt"));
            }
            LayerManager.Instance.addToLayer(_dialog,0);
            _dialog.addEventListener("click",onDialogClick);
            TweenLite.to(_dialog,4,{"onComplete":onTweenDispose});
         }
      }
      
      private function onTweenDispose() : void
      {
         _dialog.removeEventListener("click",onDialogClick);
         disposeDialogView();
      }
      
      protected function onDialogClick(me:MouseEvent) : void
      {
         TweenLite.killTweensOf(_dialog);
         _dialog.removeEventListener("click",onDialogClick);
         disposeDialogView();
      }
      
      private function disposeDialogView() : void
      {
         _dialog != null && ObjectUtils.disposeObject(_dialog);
         _dialog = null;
      }
      
      private function getBuildOrNpcName() : String
      {
         var tmpGrade:int = PlayerManager.Instance.Self.Grade;
         var _loc2_:* = tmpGrade;
         if(3 !== _loc2_)
         {
            if(5 !== _loc2_)
            {
               if(10 !== _loc2_)
               {
                  if(14 !== _loc2_)
                  {
                     if(17 !== _loc2_)
                     {
                        if(18 !== _loc2_)
                        {
                           if(27 !== _loc2_)
                           {
                              if(30 !== _loc2_)
                              {
                                 if(45 !== _loc2_)
                                 {
                                    return "roomList";
                                 }
                                 return "cryptBoss";
                              }
                              return "labyrinth";
                           }
                           return "ringStation";
                        }
                        return "auction";
                     }
                     return "constrion";
                  }
                  return "church";
               }
               return "dungeon";
            }
            return "store";
         }
         return "roomList";
      }
      
      private function isHasOpenCartoon() : Boolean
      {
         var tmpGrade:int = PlayerManager.Instance.Self.Grade;
         return tmpGrade == 3 || tmpGrade == 5 || tmpGrade == 10 || tmpGrade == 14 || tmpGrade == 17 || tmpGrade == 18 || tmpGrade == 28 || tmpGrade == 30 || tmpGrade == 46;
      }
      
      private function getMapMovePos() : Point
      {
         var tmpGrade:int = PlayerManager.Instance.Self.Grade;
         var _loc2_:* = tmpGrade;
         if(3 !== _loc2_)
         {
            if(5 !== _loc2_)
            {
               if(10 !== _loc2_)
               {
                  if(14 !== _loc2_)
                  {
                     if(17 !== _loc2_)
                     {
                        if(18 !== _loc2_)
                        {
                           if(19 !== _loc2_)
                           {
                              if(27 !== _loc2_)
                              {
                                 if(30 !== _loc2_)
                                 {
                                    if(45 !== _loc2_)
                                    {
                                       return new Point(0,0);
                                    }
                                    return new Point(-2740,0);
                                 }
                                 return new Point(-2400,0);
                              }
                              return new Point(-2740,0);
                           }
                           return new Point(-2700,0);
                        }
                        return new Point(-1900,0);
                     }
                     return new Point(-1450,0);
                  }
                  return new Point(-2300,0);
               }
               return new Point(-956,0);
            }
            return new Point(-956,0);
         }
         return new Point(-1659,0);
      }
      
      private function getOpenCartoonClassName() : String
      {
         return "asset.newOpenGuide.openCartoon" + PlayerManager.Instance.Self.Grade;
      }
   }
}
