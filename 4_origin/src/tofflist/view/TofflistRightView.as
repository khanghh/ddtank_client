package tofflist.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import tofflist.TofflistController;
   import tofflist.TofflistEvent;
   import tofflist.TofflistModel;
   
   public class TofflistRightView extends Sprite implements Disposeable
   {
       
      
      private var _contro:TofflistController;
      
      private var _currentData:Array;
      
      private var _currentPage:int;
      
      private var _gridBox:TofflistGridBox;
      
      private var _pageTxt:FilterFrameText;
      
      private var _pgdn:BaseButton;
      
      private var _pgup:BaseButton;
      
      private var _stairMenu:TofflistStairMenu;
      
      private var _thirdClassMenu:TofflistThirdClassMenu;
      
      private var _totalPage:int;
      
      private var _twoGradeMenu:TofflistTwoGradeMenu;
      
      private var _leftInfo:TofflistLeftInfoView;
      
      private var _upDownTextBg:Image;
      
      private var _bg:MutipleImage;
      
      public function TofflistRightView($contro:TofflistController)
      {
         _contro = $contro;
         super();
         init();
         addEvent();
      }
      
      public function get gridBox() : TofflistGridBox
      {
         return _gridBox;
      }
      
      public function dispose() : void
      {
         _contro = null;
         _currentData = null;
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         if(_gridBox)
         {
            ObjectUtils.disposeObject(_gridBox);
         }
         if(_pageTxt)
         {
            ObjectUtils.disposeObject(_pageTxt);
         }
         if(_pgdn)
         {
            ObjectUtils.disposeObject(_pgdn);
         }
         if(_pgup)
         {
            ObjectUtils.disposeObject(_pgup);
         }
         if(_upDownTextBg)
         {
            ObjectUtils.disposeObject(_upDownTextBg);
         }
         if(_stairMenu)
         {
            ObjectUtils.disposeObject(_stairMenu);
         }
         if(_twoGradeMenu)
         {
            ObjectUtils.disposeObject(_twoGradeMenu);
         }
         if(_thirdClassMenu)
         {
            ObjectUtils.disposeObject(_thirdClassMenu);
         }
         if(_leftInfo)
         {
            ObjectUtils.disposeObject(_leftInfo);
         }
         _bg = null;
         _gridBox = null;
         _pageTxt = null;
         _pgdn = null;
         _pgup = null;
         _upDownTextBg = null;
         _stairMenu = null;
         _twoGradeMenu = null;
         _thirdClassMenu = null;
         _leftInfo = null;
      }
      
      public function updateTime(timeStr:String) : void
      {
         if(timeStr)
         {
            _leftInfo.updateTimeTxt.text = LanguageMgr.GetTranslation("tank.tofflist.view.lastUpdateTime") + timeStr;
         }
         else
         {
            _leftInfo.updateTimeTxt.text = "";
         }
      }
      
      public function get firstType() : String
      {
         return _stairMenu.type;
      }
      
      public function orderList($list:Array) : void
      {
         if(!$list)
         {
            return;
         }
         _currentData = $list;
         _gridBox.updateList($list);
         _totalPage = Math.ceil(($list == null?0:$list.length) / 8);
         if(_currentData && _currentData.length > 0)
         {
            _currentPage = 1;
         }
         else
         {
            _currentPage = 1;
         }
         checkPageBtn();
      }
      
      public function get twoGradeType() : String
      {
         return this._twoGradeMenu.type;
      }
      
      private function __addToStageHandler(evt:Event) : void
      {
         _stairMenu.type = "personal";
         _twoGradeMenu.setParentType(_stairMenu.type);
      }
      
      private function __menuTypeHandler(evt:TofflistEvent) : void
      {
         var _loc2_:* = TofflistModel.firstMenuType;
         if("personal" !== _loc2_)
         {
            if("consortia" !== _loc2_)
            {
               if("crossServerPersonal" !== _loc2_)
               {
                  if("crossServerConsortia" !== _loc2_)
                  {
                     if("teams" !== _loc2_)
                     {
                        if("crossServerTeams" === _loc2_)
                        {
                           _gridBox.updateStyleXY("teamCross");
                        }
                     }
                     else
                     {
                        _gridBox.updateStyleXY("teamThe");
                     }
                  }
                  else
                  {
                     _loc2_ = TofflistModel.secondMenuType;
                     if("battle" !== _loc2_)
                     {
                        if("level" !== _loc2_)
                        {
                           if("assets" !== _loc2_)
                           {
                              if("charm" === _loc2_)
                              {
                                 _gridBox.updateStyleXY("consortiaCrossCharm");
                              }
                           }
                           else
                           {
                              _gridBox.updateStyleXY("consortiaCrossAsset");
                           }
                        }
                        else
                        {
                           _gridBox.updateStyleXY("consortiaCrossLevel");
                        }
                     }
                     else
                     {
                        _gridBox.updateStyleXY("consortiaCrossBattle");
                     }
                  }
               }
               else
               {
                  _loc2_ = TofflistModel.secondMenuType;
                  if("battle" !== _loc2_)
                  {
                     if("level" !== _loc2_)
                     {
                        if("achievementpoint" !== _loc2_)
                        {
                           if("charm" !== _loc2_)
                           {
                              if("mounts" === _loc2_)
                              {
                                 _gridBox.updateStyleXY("personCrossMounts");
                              }
                           }
                           else
                           {
                              _gridBox.updateStyleXY("personCrossCharm");
                           }
                        }
                        else
                        {
                           _gridBox.updateStyleXY("personCrossAchive");
                        }
                     }
                     else
                     {
                        _gridBox.updateStyleXY("personCrossLevel");
                     }
                  }
                  else
                  {
                     _gridBox.updateStyleXY("personCrossBattle");
                  }
               }
            }
            else
            {
               _loc2_ = TofflistModel.secondMenuType;
               if("battle" !== _loc2_)
               {
                  if("level" !== _loc2_)
                  {
                     if("assets" !== _loc2_)
                     {
                        if("charm" === _loc2_)
                        {
                           _gridBox.updateStyleXY("consortiaLocalCharm");
                        }
                     }
                     else
                     {
                        _gridBox.updateStyleXY("consortiaLocalAsset");
                     }
                  }
                  else
                  {
                     _gridBox.updateStyleXY("consortiaLocalLevel");
                  }
               }
               else
               {
                  _gridBox.updateStyleXY("consortiaLocalBattle");
               }
            }
         }
         else
         {
            _loc2_ = TofflistModel.secondMenuType;
            if("battle" !== _loc2_)
            {
               if("level" !== _loc2_)
               {
                  if("achievementpoint" !== _loc2_)
                  {
                     if("charm" !== _loc2_)
                     {
                        if("matches" !== _loc2_)
                        {
                           if("mounts" === _loc2_)
                           {
                              _gridBox.updateStyleXY("personLocalMounts");
                           }
                        }
                        else
                        {
                           _gridBox.updateStyleXY("personLocalMatch");
                        }
                     }
                     else
                     {
                        _gridBox.updateStyleXY("personLocalCharm");
                     }
                  }
                  else
                  {
                     _gridBox.updateStyleXY("personLocalAchive");
                  }
               }
               else
               {
                  _gridBox.updateStyleXY("personLocalLevel");
               }
            }
            else
            {
               _gridBox.updateStyleXY("personLocalBattle");
            }
         }
      }
      
      private function __pgdnHandler(evt:MouseEvent) : void
      {
         if(!_currentData)
         {
            return;
         }
         SoundManager.instance.play("008");
         _currentPage = Number(_currentPage) + 1;
         if(_currentPage > _totalPage)
         {
            _currentPage = 1;
         }
         _gridBox.updateList(_currentData,_currentPage);
         checkPageBtn();
      }
      
      private function __pgupHandler(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _currentPage = Number(_currentPage) - 1;
         if(_currentPage < 1)
         {
            _currentPage = _totalPage;
         }
         _gridBox.updateList(_currentData,_currentPage);
         checkPageBtn();
      }
      
      private function __searchOrderHandler(evt:TofflistEvent) : void
      {
         var _type:* = null;
         _contro.clearDisplayContent();
         if(TofflistModel.firstMenuType == "personal")
         {
            _type = "personal";
            if(TofflistModel.secondMenuType == "battle")
            {
               if(_thirdClassMenu.type == "total")
               {
                  _contro.loadFormData("personalBattleAccumulate","CelebByDayFightPowerList.xml",_type);
               }
            }
            else if(TofflistModel.secondMenuType == "level")
            {
               if(_thirdClassMenu.type == "day")
               {
                  _contro.loadFormData("individualGradeDay","CelebByDayGPList.xml",_type);
               }
               else if(_thirdClassMenu.type == "week")
               {
                  _contro.loadFormData("individualGradeWeek","CelebByWeekGPList.xml",_type);
               }
               else if(_thirdClassMenu.type == "total")
               {
                  _contro.loadFormData("individualGradeAccumulate","CelebByGPList.xml",_type);
               }
            }
            else if(TofflistModel.secondMenuType == "achievementpoint")
            {
               if(_thirdClassMenu.type == "day")
               {
                  _contro.loadFormData("PersonalAchievementPointDay","CelebByAchievementPointDayList.xml",_type);
               }
               else if(_thirdClassMenu.type == "week")
               {
                  _contro.loadFormData("PersonalAchievementPointWeek","CelebByAchievementPointWeekList.xml",_type);
               }
               else if(_thirdClassMenu.type == "total")
               {
                  _contro.loadFormData("PersonalAchievementPoint","CelebByAchievementPointList.xml",_type);
               }
            }
            else if(TofflistModel.secondMenuType == "charm")
            {
               if(_thirdClassMenu.type == "day")
               {
                  _contro.loadFormData("PersonalCharmvalueDay","CelebByDayGiftGp.xml",_type);
               }
               else if(_thirdClassMenu.type == "week")
               {
                  _contro.loadFormData("PersonalCharmvalueWeek","CelebByWeekGiftGp.xml",_type);
               }
               else if(_thirdClassMenu.type == "total")
               {
                  _contro.loadFormData("PersonalCharmvalue","CelebByGiftGpList.xml",_type);
               }
            }
            else if(TofflistModel.secondMenuType == "matches")
            {
               if(_thirdClassMenu.type == "day")
               {
                  _contro.loadFormData("personalMatchesDay","CelebByDayPrestige.xml",_type);
               }
               else if(_thirdClassMenu.type == "week")
               {
                  _contro.loadFormData("personalMatchesWeek","CelebByWeekPrestige.xml",_type);
               }
               else if(_thirdClassMenu.type == "total")
               {
                  _contro.loadFormData("personalMatchesTotal","CelebByTotalPrestige.xml",_type);
               }
            }
            else if(TofflistModel.secondMenuType == "mounts")
            {
               if(_thirdClassMenu.type == "total")
               {
                  _contro.loadFormData("personalMountsAccumulate","CelebByMountExpList.xml",_type);
               }
            }
         }
         else if(TofflistModel.firstMenuType == "consortia")
         {
            _type = "sociaty";
            if(TofflistModel.secondMenuType == "battle")
            {
               if(_thirdClassMenu.type == "total")
               {
                  _contro.loadFormData("consortiaBattleAccumulate","CelebByConsortiaFightPower.xml",_type);
               }
            }
            else if(TofflistModel.secondMenuType == "level")
            {
               if(_thirdClassMenu.type == "total")
               {
                  _contro.loadFormData("consortiaGradeAccumulate","CelebByConsortiaLevel.xml",_type);
               }
            }
            else if(TofflistModel.secondMenuType == "assets")
            {
               if(_thirdClassMenu.type == "day")
               {
                  _contro.loadFormData("consortiaAssetDay","CelebByConsortiaDayRiches.xml",_type);
               }
               else if(_thirdClassMenu.type == "week")
               {
                  _contro.loadFormData("consortiaAssetWeek","CelebByConsortiaWeekRiches.xml",_type);
               }
               else if(_thirdClassMenu.type == "total")
               {
                  _contro.loadFormData("consortiaAssetAccumulate","CelebByConsortiaRiches.xml",_type);
               }
            }
            else if(TofflistModel.secondMenuType == "charm")
            {
               if(_thirdClassMenu.type == "day")
               {
                  _contro.loadFormData("ConsortiaCharmvalueDay","CelebByConsortiaDayGiftGp.xml",_type);
               }
               else if(_thirdClassMenu.type == "week")
               {
                  _contro.loadFormData("ConsortiaCharmvalueWeek","CelebByConsortiaWeekGiftGp.xml",_type);
               }
               else if(_thirdClassMenu.type == "total")
               {
                  _contro.loadFormData("ConsortiaCharmvalue","CelebByConsortiaGiftGp.xml",_type);
               }
            }
         }
         else if(TofflistModel.firstMenuType == "crossServerPersonal")
         {
            _type = "personal";
            if(TofflistModel.secondMenuType == "battle")
            {
               if(_thirdClassMenu.type == "total")
               {
                  _contro.loadFormData("crossServerPersonalBattleAccumulate","AreaCelebByDayFightPowerList.xml",_type);
               }
            }
            else if(TofflistModel.secondMenuType == "level")
            {
               if(_thirdClassMenu.type == "day")
               {
                  _contro.loadFormData("crossServerIndividualGradeDay","AreaCelebByDayGPList.xml",_type);
               }
               else if(_thirdClassMenu.type == "week")
               {
                  _contro.loadFormData("crossServerIndividualGradeWeek","AreaCelebByWeekGPList.xml",_type);
               }
               else if(_thirdClassMenu.type == "total")
               {
                  _contro.loadFormData("crossServerIndividualGradeAccumulate","AreaCelebByGPList.xml",_type);
               }
            }
            else if(TofflistModel.secondMenuType == "achievementpoint")
            {
               if(_thirdClassMenu.type == "day")
               {
                  _contro.loadFormData("crossServerPersonalAchievementPointDay","AreaCelebByAchievementPointDayList.xml",_type);
               }
               else if(_thirdClassMenu.type == "week")
               {
                  _contro.loadFormData("crossServerPersonalAchievementPointWeek","AreaCelebByAchievementPointWeekList.xml",_type);
               }
               else if(_thirdClassMenu.type == "total")
               {
                  _contro.loadFormData("crossServerPersonalAchievementPoint","AreaCelebByAchievementPointList.xml",_type);
               }
            }
            else if(TofflistModel.secondMenuType == "charm")
            {
               if(_thirdClassMenu.type == "day")
               {
                  _contro.loadFormData("crossServerPersonalCharmvalueDay","AreaCelebByGiftGpDayList.xml",_type);
               }
               else if(_thirdClassMenu.type == "week")
               {
                  _contro.loadFormData("crossServerPersonalCharmvalueWeek","AreaCelebByGiftGpWeekList.xml",_type);
               }
               else if(_thirdClassMenu.type == "total")
               {
                  _contro.loadFormData("crossServerPersonalCharmvalue","AreaCelebByGiftGpList.xml",_type);
               }
            }
            else if(TofflistModel.secondMenuType == "mounts")
            {
               if(_thirdClassMenu.type == "total")
               {
                  _contro.loadFormData("crossServerIndividualMountsAccumulate","AreaCelebByMountExpList.xml",_type);
               }
            }
         }
         else if(TofflistModel.firstMenuType == "crossServerConsortia")
         {
            _type = "sociaty";
            if(TofflistModel.secondMenuType == "level")
            {
               if(_thirdClassMenu.type == "total")
               {
                  _contro.loadFormData("crossServerConsortiaGradeAccumulate","AreaCelebByConsortiaLevel.xml",_type);
               }
            }
            else if(TofflistModel.secondMenuType == "assets")
            {
               if(_thirdClassMenu.type == "day")
               {
                  _contro.loadFormData("crossServerConsortiaAssetDay","AreaCelebByConsortiaDayRiches.xml",_type);
               }
               else if(_thirdClassMenu.type == "week")
               {
                  _contro.loadFormData("crossServerConsortiaAssetWeek","AreaCelebByConsortiaWeekRiches.xml",_type);
               }
               else if(_thirdClassMenu.type == "total")
               {
                  _contro.loadFormData("crossServerConsortiaAssetAccumulate","AreaCelebByConsortiaRiches.xml",_type);
               }
            }
            else if(TofflistModel.secondMenuType == "battle")
            {
               if(_thirdClassMenu.type == "total")
               {
                  _contro.loadFormData("crossServerConsortiaBattleAccumulate","AreaCelebByConsortiaFightPower.xml",_type);
               }
            }
            else if(TofflistModel.secondMenuType == "charm")
            {
               if(_thirdClassMenu.type == "day")
               {
                  _contro.loadFormData("crossServerConsortiaCharmvalueDay","AreaCelebByConsortiaDayGiftGp.xml",_type);
               }
               else if(_thirdClassMenu.type == "week")
               {
                  _contro.loadFormData("crossServerConsortiaCharmvalueWeek","AreaCelebByConsortiaWeekGiftGp.xml",_type);
               }
               else if(_thirdClassMenu.type == "total")
               {
                  _contro.loadFormData("crossServerConsortiaCharmvalue","AreaCelebByConsortiaGiftGp.xml",_type);
               }
            }
         }
         else if(TofflistModel.firstMenuType == "teams")
         {
            _type = "team";
            _contro.loadFormData("theServerTeamIntegral","CelebByBattleTeamDayRank.xml",_type);
         }
         else if(TofflistModel.firstMenuType == "crossServerTeams")
         {
            _type = "team";
            _contro.loadFormData("crossServerTeamIntegral","AreaCelebByBattleTeamDayRank.xml",_type);
         }
      }
      
      private function __selectChildBarHandler(evt:TofflistEvent) : void
      {
         _contro.clearDisplayContent();
         _thirdClassMenu.selectType(_stairMenu.type,TofflistModel.secondMenuType);
      }
      
      private function __selectStairMenuHandler(evt:TofflistEvent) : void
      {
         _contro.clearDisplayContent();
         _twoGradeMenu.setParentType(TofflistModel.firstMenuType);
      }
      
      private function addEvent() : void
      {
         _thirdClassMenu.addEventListener("tofflisttoolbarselect",__searchOrderHandler);
         _twoGradeMenu.addEventListener("tofflisttoolbarselect",__selectChildBarHandler);
         _stairMenu.addEventListener("tofflisttoolbarselect",__selectStairMenuHandler);
         TofflistModel.addEventListener("tofflisttypechange",__menuTypeHandler);
         _pgup.addEventListener("click",__pgupHandler);
         _pgdn.addEventListener("click",__pgdnHandler);
         this.addEventListener("addedToStage",__addToStageHandler);
      }
      
      private function checkPageBtn() : void
      {
         _pageTxt.text = _currentPage + "/" + _totalPage;
      }
      
      private function init() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("toffilist.rightBg");
         addChild(_bg);
         _gridBox = ComponentFactory.Instance.creatCustomObject("tofflist.gridBox");
         addChild(_gridBox);
         _stairMenu = ComponentFactory.Instance.creatCustomObject("tofflist.stairMenu");
         addChild(_stairMenu);
         _twoGradeMenu = ComponentFactory.Instance.creatCustomObject("tofflist.twoGradeMenu");
         addChild(_twoGradeMenu);
         _thirdClassMenu = ComponentFactory.Instance.creatCustomObject("tofflist.hirdClassMenu");
         addChild(_thirdClassMenu);
         _pgup = ComponentFactory.Instance.creatComponentByStylename("toffilist.prePageBtn");
         addChild(_pgup);
         _pgdn = ComponentFactory.Instance.creatComponentByStylename("toffilist.nextPageBtn");
         addChild(_pgdn);
         _upDownTextBg = ComponentFactory.Instance.creat("asset.Toffilist.upDownTextBgImgAsset");
         addChild(_upDownTextBg);
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("toffilist.pageTxt");
         addChild(_pageTxt);
         _leftInfo = ComponentFactory.Instance.creatCustomObject("tofflist.leftInfoView");
         addChild(_leftInfo);
      }
      
      private function removeEvent() : void
      {
         _stairMenu.removeEventListener("tofflisttoolbarselect",__selectStairMenuHandler);
         _twoGradeMenu.removeEventListener("tofflisttoolbarselect",__selectChildBarHandler);
         _thirdClassMenu.removeEventListener("tofflisttoolbarselect",__searchOrderHandler);
         TofflistModel.removeEventListener("tofflisttypechange",__menuTypeHandler);
         _pgup.removeEventListener("click",__pgupHandler);
         _pgdn.removeEventListener("click",__pgdnHandler);
         this.removeEventListener("addedToStage",__addToStageHandler);
      }
   }
}
