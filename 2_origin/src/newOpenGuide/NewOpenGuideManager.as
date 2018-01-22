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
      
      public function NewOpenGuideManager(param1:IEventDispatcher = null)
      {
         super(param1);
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
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc2_:int = PlayerManager.Instance.Self.Grade;
         var _loc1_:int = openLevelList.length;
         _loc4_ = 0;
         while(_loc4_ < _loc1_)
         {
            if(_loc2_ == openLevelList[_loc4_])
            {
               _loc3_ = openMovePosList[_loc4_];
               if(_loc3_.x == 0 && _loc3_.y == 0)
               {
                  return MainToolBar.Instance.newBtnOpenCartoon();
               }
               return _loc3_;
            }
            _loc4_++;
         }
         return new Point(445,-10);
      }
      
      public function getTitleStrIndexByLevel(param1:int) : Array
      {
         var _loc6_:int = 0;
         var _loc3_:Array = [-1,"",-1];
         var _loc4_:String = "";
         var _loc5_:int = -1;
         var _loc2_:int = openLevelList.length;
         _loc6_ = 0;
         while(_loc6_ < _loc2_)
         {
            if(param1 == openLevelList[_loc6_])
            {
               _loc4_ = titleStrList[_loc6_];
               _loc5_ = _loc6_ + 1;
               break;
            }
            _loc6_++;
         }
         _loc3_[0] = _loc5_;
         _loc3_[1] = _loc4_;
         _loc3_[2] = param1;
         return _loc3_;
      }
      
      public function closeShow() : void
      {
         _playerView = null;
         ObjectUtils.disposeObject(_rightView);
         _rightView = null;
         PlayerManager.Instance.Self.removeEventListener("propertychange",__propertyChange);
      }
      
      public function checkShow(param1:HallPlayerView, param2:IHallStateView) : void
      {
         _hall = param2;
         _playerView = param1;
         _rightView = new NewOpenGuideRightView();
         _rightView.x = 845;
         _rightView.y = 140;
         LayerManager.Instance.addToLayer(_rightView,4);
         StageResizeUtils.Instance.addAutoResize(_rightView);
         judgeMiddleView();
         PlayerManager.Instance.Self.addEventListener("propertychange",__propertyChange);
      }
      
      private function __propertyChange(param1:PlayerPropertyEvent) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         if(param1.changedProperties["Grade"])
         {
            _loc2_ = false;
            _loc3_ = PlayerManager.Instance.Self.Grade;
            var _loc4_:* = _loc3_;
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
                                       _loc2_ = true;
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
            if(_loc2_ == false)
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
         var _loc1_:Array = getTitleStrIndexByLevel(PlayerManager.Instance.Self.Grade);
         if(_loc1_[0] > 0 && !PlayerManager.Instance.Self.isNewOnceFinish(200 + _loc1_[2]))
         {
            setTimeout(createOpenView,1000);
         }
      }
      
      private function createOpenCartoon() : void
      {
         var _loc1_:MovieClip = ComponentFactory.Instance.creat(getOpenCartoonClassName());
         _loc1_.mouseChildren = false;
         _loc1_.mouseEnabled = false;
         _loc1_.addEventListener("enterFrame",openCartoonPlayFrame);
         _loc1_.gotoAndPlay(1);
         var _loc2_:HallStateView = StateManager.getState("main") as HallStateView;
         if(_loc2_)
         {
            _loc2_.bgSprite.addChild(_loc1_);
         }
      }
      
      private function openCartoonPlayFrame(param1:Event) : void
      {
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         if(_loc2_.currentFrame == _loc2_.totalFrames)
         {
            if(_loc2_.parent)
            {
               _loc2_.parent.removeChild(_loc2_);
            }
            _loc2_.stop();
            _loc2_.removeEventListener("enterFrame",openCartoonPlayFrame);
            checkGuide();
         }
      }
      
      private function checkGuide() : void
      {
         var _loc6_:* = null;
         var _loc3_:* = null;
         var _loc1_:* = null;
         var _loc5_:Boolean = false;
         if(PlayerManager.Instance.Self.Grade >= 10)
         {
            _playerView.mapID = 0;
            SocketManager.Instance.out.sendLoadOtherPlayer();
         }
         var _loc4_:int = PlayerManager.Instance.Self.Grade;
         var _loc2_:int = 135;
         var _loc7_:* = _loc4_;
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
                                    _loc6_ = "circle";
                                    _loc3_ = [644,565,22];
                                    _loc1_ = new Point(646,481);
                                    _loc2_ = 0;
                                    CacheSysManager.unlock("ddtkingGrade");
                                    _loc5_ = true;
                                 }
                              }
                              else
                              {
                                 _loc6_ = "circle";
                                 _loc3_ = [644,565,22];
                                 _loc1_ = new Point(646,481);
                                 _loc2_ = 0;
                                 CacheSysManager.unlock("guard_core");
                                 _loc5_ = true;
                              }
                           }
                           else
                           {
                              _loc6_ = "rect";
                              _loc3_ = [785,385,220,150];
                              _loc1_ = new Point(710,326);
                              _loc2_ = -45;
                              CacheSysManager.unlock("crypt_guide");
                           }
                        }
                        else
                        {
                           _loc6_ = "ellipse";
                           _loc3_ = [445,0,300,400];
                           _loc1_ = new Point(760,385);
                           CacheSysManager.unlock("secret_area_guide");
                        }
                     }
                     else
                     {
                        _loc6_ = "rect";
                        _loc3_ = [685,0,335,380];
                        _loc1_ = new Point(607,206);
                        _loc2_ = -90;
                        CacheSysManager.unlock("arena_guide");
                     }
                  }
                  else
                  {
                     _loc6_ = "circle";
                     _loc3_ = [589,173,142];
                     _loc1_ = new Point(739,329);
                     CacheSysManager.unlock("farm_guide");
                  }
               }
               else
               {
                  _loc6_ = "ellipse";
                  _loc3_ = [439,173,142,223];
                  _loc1_ = new Point(608,395);
                  CacheSysManager.unlock("sales_room_guide");
               }
            }
            else
            {
               _loc6_ = "ellipse";
               _loc3_ = [395,210,100,200];
               _loc1_ = new Point(540,436);
               CacheSysManager.unlock("consortia_guide");
            }
         }
         else
         {
            _loc6_ = "ellipse";
            _loc3_ = [436,190,100,180];
            _loc1_ = new Point(579,342);
            CacheSysManager.unlock("church_guide");
         }
         if(_loc4_ > 10 && _loc6_ != null)
         {
            _hall.hideRightGrid();
            TweenLite.to(_rightView,0.8,{"x":1000});
            _playerView.touchable = false;
            NewHandContainer.Instance.showGuideCover(_loc6_,_loc3_);
            NewHandContainer.Instance.showArrow(100000,_loc2_,_loc1_,"","",LayerManager.Instance.getLayerByType(4),0,true);
            if(_loc5_)
            {
               BagAndInfoManager.Instance.addEventListener("open",__onBagOpenClikc);
            }
            else
            {
               (_hall as EventDispatcher).addEventListener("hall_area_clicked",onHallAreaClick);
               (_hall as EventDispatcher).addEventListener("hall_player_arrived",onHallPlayerArrived);
            }
         }
         if(_loc4_ <= 10)
         {
            _playerView.setCenter();
         }
         if(_coverSpriteInPlayCartoon && _coverSpriteInPlayCartoon.parent)
         {
            _coverSpriteInPlayCartoon.parent.removeChild(_coverSpriteInPlayCartoon);
         }
         _coverSpriteInPlayCartoon = null;
      }
      
      protected function __onBagOpenClikc(param1:Event) : void
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
      
      protected function onHallAreaClick(param1:CEvent) : void
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
      
      protected function onHallPlayerArrived(param1:CEvent) : void
      {
         _rightView.x = 845;
         (_hall as EventDispatcher).removeEventListener("hall_player_arrived",onHallPlayerArrived);
         NewHandContainer.Instance.hideGuideCover();
      }
      
      private function createOpenView() : void
      {
         var _loc1_:NewOpenGuideMiddleView = new NewOpenGuideMiddleView();
         _loc1_.addEventListener("complete",middleViewCompleteHandler);
         LayerManager.Instance.addToLayer(_loc1_,0,true,1);
      }
      
      private function middleViewCompleteHandler(param1:Event) : void
      {
         var _loc6_:* = null;
         var _loc3_:* = null;
         var _loc5_:Number = NaN;
         var _loc4_:NewOpenGuideMiddleView = param1.currentTarget as NewOpenGuideMiddleView;
         _loc4_.removeEventListener("complete",middleViewCompleteHandler);
         var _loc2_:int = PlayerManager.Instance.Self.Grade;
         if(isHasOpenCartoon())
         {
            _coverSpriteInPlayCartoon = new Sprite();
            _coverSpriteInPlayCartoon.graphics.beginFill(0,0);
            _coverSpriteInPlayCartoon.graphics.drawRect(-500,-300,2000,1200);
            _coverSpriteInPlayCartoon.graphics.endFill();
            LayerManager.Instance.addToLayer(_coverSpriteInPlayCartoon,0);
            if(_loc2_ >= 3)
            {
               _loc6_ = getMapMovePos();
               if(_loc6_)
               {
                  _loc3_ = _playerView.getSelfPlayerPos();
                  _loc5_ = Math.abs(_loc6_.x - _loc3_.x) / 1000;
                  _playerView.moveBgToTargetPos(_loc6_.x,_loc6_.y,_loc5_);
                  setTimeout(createOpenCartoon,_loc5_ * 1000);
               }
            }
            else
            {
               createOpenCartoon();
            }
         }
         else if(_loc2_ > 10)
         {
            _loc6_ = getMapMovePos();
            if(_loc6_.x != 0)
            {
               _loc3_ = _playerView.getSelfPlayerPos();
               _loc5_ = Math.abs(_loc6_.x - _loc3_.x) / 1000;
               _playerView.moveBgToTargetPos(_loc6_.x,_loc6_.y,_loc5_);
               setTimeout(checkGuide,(_loc5_ + 1) * 1000);
            }
            else
            {
               checkGuide();
            }
         }
         disposeDialogView();
         if((_loc2_ == 3 || _loc2_ == 5 || _loc2_ == 6 || _loc2_ == 10) && !PlayerManager.Instance.Self.IsWeakGuildFinish(144))
         {
            _dialog = new NewOpenGuideDialogView();
            if(_loc2_ == 3)
            {
               _dialog.show(LanguageMgr.GetTranslation("newOpenGuide.roomListOpenPrompt"));
            }
            else if(_loc2_ == 5)
            {
               _dialog.show(LanguageMgr.GetTranslation("newOpenGuide.storeOpenPrompt"));
            }
            else if(_loc2_ == 6)
            {
               _dialog.show(LanguageMgr.GetTranslation("newOpenGuide.reFight"));
            }
            else if(_loc2_ == 10)
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
      
      protected function onDialogClick(param1:MouseEvent) : void
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
         var _loc1_:int = PlayerManager.Instance.Self.Grade;
         var _loc2_:* = _loc1_;
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
         var _loc1_:int = PlayerManager.Instance.Self.Grade;
         return _loc1_ == 3 || _loc1_ == 5 || _loc1_ == 10 || _loc1_ == 14 || _loc1_ == 17 || _loc1_ == 18 || _loc1_ == 28 || _loc1_ == 30 || _loc1_ == 46;
      }
      
      private function getMapMovePos() : Point
      {
         var _loc1_:int = PlayerManager.Instance.Self.Grade;
         var _loc2_:* = _loc1_;
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
