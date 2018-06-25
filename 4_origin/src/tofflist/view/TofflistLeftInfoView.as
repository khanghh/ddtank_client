package tofflist.view
{
   import battleGroud.BattleGroudControl;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.club.ClubInfo;
   import ddt.data.player.SelfInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.utils.PositionUtils;
   import ddt.view.common.LevelIcon;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import horse.HorseManager;
   import tofflist.TofflistEvent;
   import tofflist.TofflistModel;
   import tofflist.data.RankInfo;
   import tofflist.data.TofflistPlayerInfo;
   
   public class TofflistLeftInfoView extends Sprite implements Disposeable
   {
       
      
      private var _levelIcon:LevelIcon;
      
      private var _RankingLiftImg:ScaleFrameImage;
      
      private var _rankTitle:FilterFrameText;
      
      private var _levelTitle:FilterFrameText;
      
      private var _valueTitle:FilterFrameText;
      
      private var _titleBg:ScaleFrameImage;
      
      private var _textArr:Array;
      
      private var _updateTimeTxt:FilterFrameText;
      
      private var _tempArr:Vector.<RankInfo>;
      
      private var _levelStar:Bitmap;
      
      private var _mountsLevel:FilterFrameText;
      
      private var _bg:MovieClip;
      
      public function TofflistLeftInfoView()
      {
         super();
         init();
         addEvent();
      }
      
      public function dispose() : void
      {
         removeEvent();
         var _loc3_:int = 0;
         var _loc2_:* = _textArr;
         for each(var txt in _textArr)
         {
            ObjectUtils.disposeObject(txt);
         }
         _textArr = null;
         ObjectUtils.disposeObject(_titleBg);
         _titleBg = null;
         ObjectUtils.disposeObject(_levelTitle);
         _levelTitle = null;
         ObjectUtils.disposeObject(_valueTitle);
         _valueTitle = null;
         ObjectUtils.disposeObject(_rankTitle);
         _rankTitle = null;
         ObjectUtils.disposeObject(_mountsLevel);
         _mountsLevel = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_levelIcon);
         _levelIcon = null;
         ObjectUtils.disposeObject(_updateTimeTxt);
         _updateTimeTxt = null;
         if(_RankingLiftImg)
         {
            ObjectUtils.disposeObject(_RankingLiftImg);
         }
         _RankingLiftImg = null;
         if(_levelStar)
         {
            ObjectUtils.disposeObject(_levelStar);
         }
         _levelStar = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get updateTimeTxt() : FilterFrameText
      {
         return _updateTimeTxt;
      }
      
      private function __tofflistTypeHandler(evt:TofflistEvent) : void
      {
         var num:int = 0;
         var self:SelfInfo = PlayerManager.Instance.Self;
         var consortia:ClubInfo = PlayerManager.Instance.SelfConsortia;
         _levelStar.visible = false;
         _levelIcon.visible = false;
         _RankingLiftImg.visible = false;
         _textArr[3].visible = false;
         _bg.gotoAndStop(2);
         var _loc5_:* = "";
         _mountsLevel.text = _loc5_;
         _textArr[2].text = _loc5_;
         _loc5_ = false;
         _levelTitle.visible = _loc5_;
         _textArr[1].visible = _loc5_;
         _loc5_ = TofflistModel.firstMenuType;
         if("personal" !== _loc5_)
         {
            if("crossServerPersonal" !== _loc5_)
            {
               if("consortia" !== _loc5_)
               {
                  if("crossServerConsortia" !== _loc5_)
                  {
                     if("teams" !== _loc5_)
                     {
                        if("crossServerTeams" !== _loc5_)
                        {
                        }
                     }
                     _titleBg.setFrame(3);
                     _valueTitle.text = LanguageMgr.GetTranslation("team.rank.score");
                     _textArr[0].text = TofflistModel.Instance.rankInfo == null?"0":TofflistModel.Instance.rankInfo.BattleTeamRank;
                     _textArr[2].text = self.teamScore;
                  }
                  else
                  {
                     _titleBg.setFrame(2);
                     _loc5_ = TofflistModel.secondMenuType;
                     if("battle" !== _loc5_)
                     {
                        if("level" !== _loc5_)
                        {
                           if("assets" !== _loc5_)
                           {
                              if("charm" === _loc5_)
                              {
                                 _valueTitle.text = LanguageMgr.GetTranslation("ddt.giftSystem.GiftGoodItem.charmNum");
                                 _textArr[0].text = TofflistModel.Instance.rankInfo == null?"0":TofflistModel.Instance.rankInfo.ConsortiaGiftGp;
                                 _textArr[2].text = self.charmGP;
                              }
                           }
                           else
                           {
                              _valueTitle.text = LanguageMgr.GetTranslation("tofflist.totalasset");
                              if(!consortia || !self.consortiaInfo.ChairmanName)
                              {
                                 consortiaEmpty();
                              }
                              else
                              {
                                 _textArr[0].text = TofflistModel.Instance.rankInfo == null?"0":TofflistModel.Instance.rankInfo.ConsortiaRiches;
                                 _textArr[2].text = self.consortiaInfo.Riches;
                              }
                           }
                        }
                        else
                        {
                           _valueTitle.text = LanguageMgr.GetTranslation("consortia.Money");
                           _loc5_ = true;
                           _levelTitle.visible = _loc5_;
                           _textArr[1].visible = _loc5_;
                           _bg.gotoAndStop(1);
                           if(!consortia || !self.consortiaInfo.ChairmanName)
                           {
                              consortiaEmpty();
                           }
                           else
                           {
                              _textArr[0].text = TofflistModel.Instance.rankInfo == null?"0":TofflistModel.Instance.rankInfo.ConsortiaLevel;
                              _textArr[2].text = self.consortiaInfo.Riches;
                              _textArr[1].text = self.consortiaInfo.Level;
                           }
                        }
                     }
                     else
                     {
                        _valueTitle.text = LanguageMgr.GetTranslation("tank.menu.FightPoweTxt");
                        _textArr[0].text = TofflistModel.Instance.rankInfo == null?"0":TofflistModel.Instance.rankInfo.ConsortiaFightPower;
                        _textArr[2].text = self.FightPower;
                     }
                  }
               }
               _titleBg.setFrame(2);
               _loc5_ = TofflistModel.secondMenuType;
               if("battle" !== _loc5_)
               {
                  if("level" !== _loc5_)
                  {
                     if("assets" !== _loc5_)
                     {
                        if("charm" === _loc5_)
                        {
                           _valueTitle.text = LanguageMgr.GetTranslation("ddt.giftSystem.GiftGoodItem.charmNum");
                           _textArr[0].text = TofflistModel.Instance.rankInfo == null?"0":TofflistModel.Instance.rankInfo.ConsortiaGiftGp;
                           if(TofflistModel.Instance.rankInfo != null)
                           {
                              onComPare(TofflistModel.Instance.rankInfo.ConsortiaGiftGp,TofflistModel.Instance.rankInfo.ConsortiaPrevGiftGp);
                           }
                           _textArr[2].text = self.consortiaInfo.CharmGP;
                        }
                     }
                     else
                     {
                        _valueTitle.text = LanguageMgr.GetTranslation("tofflist.totalasset");
                        if(!consortia || !self.consortiaInfo.ChairmanName)
                        {
                           consortiaEmpty();
                        }
                        else
                        {
                           _textArr[0].text = TofflistModel.Instance.rankInfo == null?"0":TofflistModel.Instance.rankInfo.ConsortiaRiches;
                           if(TofflistModel.Instance.rankInfo != null)
                           {
                              onComPare(TofflistModel.Instance.rankInfo.ConsortiaRiches,TofflistModel.Instance.rankInfo.ConsortiaPrevRiches);
                           }
                           _textArr[2].text = self.consortiaInfo.Riches;
                        }
                     }
                  }
                  else
                  {
                     _bg.gotoAndStop(1);
                     _valueTitle.text = LanguageMgr.GetTranslation("consortia.Money");
                     _loc5_ = true;
                     _levelTitle.visible = _loc5_;
                     _textArr[1].visible = _loc5_;
                     if(!consortia || !self.consortiaInfo.ChairmanName)
                     {
                        consortiaEmpty();
                     }
                     _textArr[0].text = TofflistModel.Instance.rankInfo == null?"0":TofflistModel.Instance.rankInfo.ConsortiaLevel;
                     if(TofflistModel.Instance.rankInfo != null)
                     {
                        onComPare(TofflistModel.Instance.rankInfo.ConsortiaLevel,TofflistModel.Instance.rankInfo.ConsortiaPrevLevel);
                     }
                     _textArr[2].text = self.consortiaInfo.Riches;
                     _textArr[1].text = self.consortiaInfo.Level;
                  }
               }
               else
               {
                  _valueTitle.text = LanguageMgr.GetTranslation("tank.menu.FightPoweTxt");
                  _textArr[0].text = TofflistModel.Instance.rankInfo == null?"0":TofflistModel.Instance.rankInfo.ConsortiaFightPower;
                  if(TofflistModel.Instance.rankInfo != null)
                  {
                     onComPare(TofflistModel.Instance.rankInfo.ConsortiaFightPower,TofflistModel.Instance.rankInfo.ConsortiaPrevFightPower);
                  }
                  _textArr[2].text = self.FightPower;
               }
            }
            else
            {
               _titleBg.setFrame(1);
               _loc5_ = TofflistModel.secondMenuType;
               if("mounts" !== _loc5_)
               {
                  if("battle" !== _loc5_)
                  {
                     if("level" !== _loc5_)
                     {
                        if("achievementpoint" !== _loc5_)
                        {
                           if("charm" === _loc5_)
                           {
                              _valueTitle.text = LanguageMgr.GetTranslation("ddt.giftSystem.GiftGoodItem.charmNum");
                              _textArr[0].text = TofflistModel.Instance.rankInfo == null?"0":TofflistModel.Instance.rankInfo.GiftGp;
                              _textArr[2].text = self.charmGP;
                           }
                        }
                        else
                        {
                           _valueTitle.text = LanguageMgr.GetTranslation("tofflist.achivepoint");
                           _textArr[0].text = TofflistModel.Instance.rankInfo == null?"0":TofflistModel.Instance.rankInfo.AchievementPoint;
                           _textArr[2].text = self.AchievementPoint;
                        }
                     }
                     else
                     {
                        _valueTitle.text = LanguageMgr.GetTranslation("exp");
                        _levelTitle.visible = true;
                        _bg.gotoAndStop(1);
                        _textArr[0].text = TofflistModel.Instance.rankInfo == null?"0":TofflistModel.Instance.rankInfo.GP;
                        _textArr[2].text = self.GP;
                        _levelIcon.setInfo(self.Grade,self.ddtKingGrade,self.Repute,self.WinCount,self.TotalCount,self.FightPower,self.Offer,true,false);
                        _levelIcon.visible = true;
                     }
                  }
                  else
                  {
                     _valueTitle.text = LanguageMgr.GetTranslation("tank.menu.FightPoweTxt");
                     _textArr[0].text = TofflistModel.Instance.rankInfo == null?"0":TofflistModel.Instance.rankInfo.FightPower;
                     _textArr[2].text = self.FightPower;
                  }
               }
               else
               {
                  _levelStar.visible = true;
                  _valueTitle.text = LanguageMgr.GetTranslation("tofflist.mountslevel");
                  _textArr[0].text = TofflistModel.Instance.rankInfo == null?"0":TofflistModel.Instance.rankInfo.MountExp;
                  if(TofflistModel.Instance.rankInfo != null)
                  {
                     onComPare(TofflistModel.Instance.rankInfo.MountExp,TofflistModel.Instance.rankInfo.PrevMountExp);
                  }
                  _mountsLevel.text = String(HorseManager.instance.curLevel % 10) + "             " + (int(HorseManager.instance.curLevel / 10 + 1)).toString();
               }
            }
         }
         else
         {
            _titleBg.setFrame(1);
            _loc5_ = TofflistModel.secondMenuType;
            if("mounts" !== _loc5_)
            {
               if("battle" !== _loc5_)
               {
                  if("level" !== _loc5_)
                  {
                     if("achievementpoint" !== _loc5_)
                     {
                        if("charm" !== _loc5_)
                        {
                           if("matches" === _loc5_)
                           {
                              _valueTitle.text = LanguageMgr.GetTranslation("tofflist.battleScore");
                              _textArr[0].text = BattleGroudControl.Instance.orderdata.rankings;
                              if(TofflistModel.Instance.rankInfo != null)
                              {
                                 onComPare(TofflistModel.Instance.rankInfo.LeagueAddWeek,TofflistModel.Instance.rankInfo.PrevLeagueAddWeek);
                              }
                              _textArr[2].text = BattleGroudControl.Instance.orderdata.totalPrestige;
                           }
                        }
                        else
                        {
                           _valueTitle.text = LanguageMgr.GetTranslation("ddt.giftSystem.GiftGoodItem.charmNum");
                           _textArr[0].text = TofflistModel.Instance.rankInfo == null?"0":TofflistModel.Instance.rankInfo.GiftGp;
                           if(TofflistModel.Instance.rankInfo != null)
                           {
                              onComPare(TofflistModel.Instance.rankInfo.GiftGp,TofflistModel.Instance.rankInfo.PrevGiftGp);
                           }
                           _textArr[2].text = self.charmGP;
                        }
                     }
                     else
                     {
                        _valueTitle.text = LanguageMgr.GetTranslation("tofflist.achivepoint");
                        _textArr[0].text = TofflistModel.Instance.rankInfo == null?"0":TofflistModel.Instance.rankInfo.AchievementPoint;
                        if(TofflistModel.Instance.rankInfo != null)
                        {
                           onComPare(TofflistModel.Instance.rankInfo.AchievementPoint,TofflistModel.Instance.rankInfo.PrevAchievementPoint);
                        }
                        _textArr[2].text = self.AchievementPoint;
                     }
                  }
                  else
                  {
                     _valueTitle.text = LanguageMgr.GetTranslation("exp");
                     _levelTitle.visible = true;
                     _bg.gotoAndStop(1);
                     _textArr[0].text = TofflistModel.Instance.rankInfo == null?"0":TofflistModel.Instance.rankInfo.GP;
                     if(TofflistModel.Instance.rankInfo != null)
                     {
                        onComPare(TofflistModel.Instance.rankInfo.GP,TofflistModel.Instance.rankInfo.PrevGP);
                     }
                     _textArr[2].text = self.GP;
                     _levelIcon.setInfo(self.Grade,self.ddtKingGrade,self.Repute,self.WinCount,self.TotalCount,self.FightPower,self.Offer,true,false);
                     _levelIcon.visible = true;
                  }
               }
               else
               {
                  _valueTitle.text = LanguageMgr.GetTranslation("tank.menu.FightPoweTxt");
                  _textArr[0].text = TofflistModel.Instance.rankInfo == null?"0":TofflistModel.Instance.rankInfo.FightPower;
                  if(TofflistModel.Instance.rankInfo != null)
                  {
                     onComPare(TofflistModel.Instance.rankInfo.FightPower,TofflistModel.Instance.rankInfo.PrevFightPower);
                  }
                  _textArr[2].text = self.FightPower;
               }
            }
            else
            {
               _levelStar.visible = true;
               _valueTitle.text = LanguageMgr.GetTranslation("tofflist.mountslevel");
               _textArr[0].text = TofflistModel.Instance.rankInfo == null?"0":TofflistModel.Instance.rankInfo.MountExp;
               if(TofflistModel.Instance.rankInfo != null)
               {
                  onComPare(TofflistModel.Instance.rankInfo.MountExp,TofflistModel.Instance.rankInfo.PrevMountExp);
               }
               _mountsLevel.text = String(HorseManager.instance.curLevel % 10) + "             " + (int(HorseManager.instance.curLevel / 10 + 1)).toString();
            }
         }
         if(TofflistModel.secondMenuType != "level")
         {
            PositionUtils.setPos(_RankingLiftImg,"tofflist.rankImagePos1");
            PositionUtils.setPos(_textArr[3],"tofflist.comparePos1");
            PositionUtils.setPos(_valueTitle,"tofflist.valueTitlePos1");
            PositionUtils.setPos(_textArr[2],"tofflist.valueTextPos1");
         }
         else
         {
            PositionUtils.setPos(_RankingLiftImg,"tofflist.rankImagePos2");
            PositionUtils.setPos(_textArr[3],"tofflist.comparePos2");
            PositionUtils.setPos(_valueTitle,"tofflist.valueTitlePos2");
            PositionUtils.setPos(_textArr[2],"tofflist.valueTextPos2");
         }
         _textArr[3].x = _textArr[3].x - _textArr[3].textWidth / 2;
         _valueTitle.x = _valueTitle.x - _valueTitle.textWidth / 2;
         _textArr[2].x = _textArr[2].x - _textArr[2].textWidth / 2;
      }
      
      private function getToffistPlayerInfo(id:int) : TofflistPlayerInfo
      {
         var i:int = 0;
         var data:* = null;
         var len:int = TofflistModel.Instance.personalMatchesWeek.list.length;
         for(i = 0; i < len; )
         {
            data = TofflistModel.Instance.personalMatchesWeek.list[i];
            if(data.ID == id)
            {
               return data;
            }
            i++;
         }
         return null;
      }
      
      private function addEvent() : void
      {
         TofflistModel.addEventListener("rankInfo_ready",__rankInfoHandler);
         TofflistModel.addEventListener("tofflisttypechange",__tofflistTypeHandler);
      }
      
      private function __rankInfoHandler(event:TofflistEvent) : void
      {
         __tofflistTypeHandler(null);
      }
      
      private function consortiaEmpty() : void
      {
         var _loc1_:* = LanguageMgr.GetTranslation("tank.tofflist.view.TofflistLeftInfo.no");
         _textArr[2].text = _loc1_;
         _textArr[0].text = _loc1_;
      }
      
      private function onComPare(nowN:Number, PreN:Number) : void
      {
         var num:int = 0;
         _RankingLiftImg.visible = true;
         if(TofflistModel.Instance.rankInfo != null && nowN < PreN)
         {
            _RankingLiftImg.setFrame(1);
            num = PreN - nowN;
            _textArr[3].text = num;
         }
         if(TofflistModel.Instance.rankInfo != null && nowN > PreN)
         {
            _RankingLiftImg.setFrame(2);
            num = nowN - PreN;
            _textArr[3].text = num;
         }
         if(TofflistModel.Instance.rankInfo != null && (nowN == PreN || PreN == 0))
         {
            _RankingLiftImg.visible = false;
            _textArr[3].text = "";
         }
         _textArr[3].visible = _RankingLiftImg.visible;
      }
      
      private function init() : void
      {
         _textArr = [];
         _bg = ClassUtils.CreatInstance("asset.tofflist.infobgAsset");
         _bg.gotoAndStop(2);
         addChild(_bg);
         _titleBg = ComponentFactory.Instance.creatComponentByStylename("toffilist.lefeinfoTitleBg");
         addChild(_titleBg);
         _rankTitle = ComponentFactory.Instance.creatComponentByStylename("toffilist.leftInfoRankTitleText");
         addChild(_rankTitle);
         _rankTitle.text = LanguageMgr.GetTranslation("repute");
         _levelTitle = ComponentFactory.Instance.creatComponentByStylename("toffilist.leftInfoLevelTitleText");
         addChild(_levelTitle);
         _levelTitle.text = LanguageMgr.GetTranslation("tank.menu.LevelTxt");
         _valueTitle = ComponentFactory.Instance.creatComponentByStylename("toffilist.leftInfoValueTitleText");
         addChild(_valueTitle);
         _textArr.push(addChild(ComponentFactory.Instance.creatComponentByStylename("toffilist.leftInfoRankText")));
         _textArr.push(addChild(ComponentFactory.Instance.creatComponentByStylename("toffilist.leftInfoLevelText")));
         _textArr.push(addChild(ComponentFactory.Instance.creatComponentByStylename("toffilist.leftInfoValueText")));
         _textArr.push(addChild(ComponentFactory.Instance.creatComponentByStylename("toffilist.leftInfoComPareText")));
         _updateTimeTxt = ComponentFactory.Instance.creatComponentByStylename("toffilist.updateTimeTxt");
         addChild(_updateTimeTxt);
         _RankingLiftImg = ComponentFactory.Instance.creatComponentByStylename("toffilist.RankingLift");
         addChild(_RankingLiftImg);
         _levelIcon = new LevelIcon();
         _levelIcon.setSize(1);
         PositionUtils.setPos(_levelIcon,"tofflist.levelIconPos");
         addChild(_levelIcon);
         _levelIcon.visible = false;
         _RankingLiftImg.visible = false;
         _levelStar = ComponentFactory.Instance.creat("asset.Toffilist.levelStarTxtImage");
         PositionUtils.setPos(_levelStar,"tofflist.myRank.levelStarPos");
         addChild(_levelStar);
         _mountsLevel = ComponentFactory.Instance.creatComponentByStylename("toffilist.mountsLevelText");
         addChild(_mountsLevel);
      }
      
      private function removeEvent() : void
      {
         TofflistModel.removeEventListener("rankInfo_ready",__rankInfoHandler);
         TofflistModel.removeEventListener("tofflisttypechange",__tofflistTypeHandler);
      }
   }
}
