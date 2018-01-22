package tofflist.view
{
   import bagAndInfo.info.PlayerInfoViewControl;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.data.ConsortiaApplyInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.character.CharactoryFactory;
   import ddt.view.character.ICharacter;
   import ddt.view.common.LevelIcon;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import team.model.TeamRankInfo;
   import tofflist.TofflistEvent;
   import tofflist.TofflistModel;
   import vip.VipController;
   
   public class TofflistLeftCurrentCharcter extends Sprite implements Disposeable
   {
       
      
      private var _AchievementImg:Bitmap;
      
      private var _EXPImg:Bitmap;
      
      private var _LnTAImg:Bitmap;
      
      private var _NO1Mc:MovieClip;
      
      private var _chairmanNameTxt:FilterFrameText;
      
      private var _chairmanNameTxt2:FilterFrameText;
      
      private var _consortiaName:FilterFrameText;
      
      private var _exploitImg:Bitmap;
      
      private var _fightingImg:Bitmap;
      
      private var _mountsImg:Bitmap;
      
      private var _guildImg:Bitmap;
      
      private var _teamImg:Bitmap;
      
      private var _teamScoreImg:Bitmap;
      
      private var _info:PlayerInfo;
      
      private var _teamInfo:TeamRankInfo;
      
      private var _levelIcon:LevelIcon;
      
      private var _lookEquip_btn:TextButton;
      
      private var _applyJoinBtn:TextButton;
      
      private var _nameTxt:FilterFrameText;
      
      private var _player:ICharacter;
      
      private var _rankNumber:Sprite;
      
      private var _text1:FilterFrameText;
      
      private var _textBg:Scale9CornerImage;
      
      private var _wealthImg:Bitmap;
      
      private var _vipName:GradientText;
      
      private var _chairmanVipName:GradientText;
      
      private var _scoreImg:Bitmap;
      
      private var _charmvalueImg:Bitmap;
      
      private var _levelStar:Bitmap;
      
      private var _mountsLevel:FilterFrameText;
      
      public function TofflistLeftCurrentCharcter()
      {
         super();
         init();
         addEvent();
      }
      
      public function dispose() : void
      {
         if(_player)
         {
            _player.dispose();
         }
         _player = null;
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _AchievementImg = null;
         _EXPImg = null;
         _LnTAImg = null;
         _NO1Mc = null;
         _chairmanNameTxt2 = null;
         _exploitImg = null;
         _fightingImg = null;
         _mountsImg = null;
         _guildImg = null;
         _teamImg = null;
         _levelIcon = null;
         _lookEquip_btn = null;
         _applyJoinBtn = null;
         _nameTxt = null;
         _rankNumber = null;
         _text1 = null;
         _textBg = null;
         _wealthImg = null;
         _vipName = null;
         _chairmanVipName = null;
         _charmvalueImg = null;
         _levelStar = null;
         _mountsLevel = null;
         _teamScoreImg = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      private function NO1Effect() : void
      {
         if(TofflistModel.currentIndex == 1)
         {
            _NO1Mc.visible = true;
            _NO1Mc.gotoAndPlay(1);
         }
         else
         {
            _NO1Mc.visible = false;
            _NO1Mc.gotoAndStop(1);
         }
      }
      
      private function __lookBtnClick(param1:Event) : void
      {
         SoundManager.instance.play("008");
         if((_info || _teamInfo) && (TofflistModel.firstMenuType == "personal" || TofflistModel.firstMenuType == "consortia" || TofflistModel.firstMenuType == "teams"))
         {
            if(_info)
            {
               PlayerInfoViewControl.viewByID(_info.ID);
            }
            else if(_teamInfo)
            {
               PlayerInfoViewControl.viewByID(_teamInfo.CreaterId);
            }
         }
      }
      
      private function __upCurrentPlayerHandler(param1:TofflistEvent) : void
      {
         if(TofflistModel.secondMenuType == "integral")
         {
            _teamInfo = TofflistModel.currentTeamInfo;
         }
         else
         {
            _info = TofflistModel.currentPlayerInfo;
         }
         upView();
      }
      
      private function addEvent() : void
      {
         TofflistModel.addEventListener("tofflistcurrentplaye",__upCurrentPlayerHandler);
         _lookEquip_btn.addEventListener("click",__lookBtnClick);
         _applyJoinBtn.addEventListener("click",onApplyJoinClubBtnClick);
      }
      
      private function onApplyJoinClubBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(TofflistModel.currentConsortiaInfo)
         {
            if(PlayerManager.Instance.Self.Grade < 17)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.consortion.playerTip.notInvite",17));
               return;
            }
            if(!TofflistModel.currentConsortiaInfo.OpenApply)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.consortia.club.ConsortiaClubView.applyJoinClickHandler"));
               return;
            }
            _applyJoinBtn.enable = false;
            SocketManager.Instance.out.sendConsortiaTryIn(TofflistModel.currentConsortiaInfo.ConsortiaID);
         }
      }
      
      private function getRank(param1:int) : void
      {
         var _loc2_:* = null;
         var _loc5_:int = 0;
         if(!_rankNumber)
         {
            _rankNumber = new Sprite();
         }
         while(_rankNumber.numChildren != 0)
         {
            _rankNumber.removeChildAt(0);
         }
         var _loc6_:String = param1.toString();
         var _loc4_:int = _loc6_.length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc2_ = getRankBitmap(int(_loc6_.substr(_loc5_,1)));
            _loc2_.x = _loc5_ * 30;
            _rankNumber.addChild(_loc2_);
            _loc5_++;
         }
         switch(int(param1) - 1)
         {
            case 0:
               _loc2_ = ComponentFactory.Instance.creatBitmap("asset.Toffilist.PlayerRankSt");
               _loc2_.x = 25;
               _loc2_.y = 8;
               _rankNumber.addChild(_loc2_);
               break;
            case 1:
               _loc2_ = ComponentFactory.Instance.creatBitmap("asset.Toffilist.PlayerRankNd");
               _loc2_.x = 34;
               _loc2_.y = 8;
               _rankNumber.addChild(_loc2_);
               break;
            case 2:
               _loc2_ = ComponentFactory.Instance.creatBitmap("asset.Toffilist.PlayerRankRd");
               _loc2_.x = 30;
               _loc2_.y = 8;
               _rankNumber.addChild(_loc2_);
         }
         addChild(_rankNumber);
         var _loc3_:Point = ComponentFactory.Instance.creat("tofflist.rankPos");
         _rankNumber.x = _loc3_.x;
         _rankNumber.y = _loc3_.y;
      }
      
      private function getRankBitmap(param1:int) : Bitmap
      {
         var _loc2_:* = null;
         _loc2_ = ComponentFactory.Instance.creatBitmap("asset.Toffilist.PlayerRankNum" + param1);
         return _loc2_;
      }
      
      private function init() : void
      {
         _textBg = ComponentFactory.Instance.creatComponentByStylename("toffilist.textBg");
         addChild(_textBg);
         _fightingImg = ComponentFactory.Instance.creat("asset.Toffilist.fightingImgAsset1_1");
         addChild(_fightingImg);
         _mountsImg = ComponentFactory.Instance.creat("asset.Toffilist.mountsImgAsset1_1");
         addChild(_mountsImg);
         _exploitImg = ComponentFactory.Instance.creat("asset.Toffilist.exploitImgAsset1_1");
         addChild(_exploitImg);
         _EXPImg = ComponentFactory.Instance.creat("asset.Toffilist.EXPImgAsset1_1");
         addChild(_EXPImg);
         _wealthImg = ComponentFactory.Instance.creat("asset.Toffilist.wealthImgAsset1_1");
         addChild(_wealthImg);
         _LnTAImg = ComponentFactory.Instance.creat("asset.Toffilist.LnTAImgAsset1_1");
         addChild(_LnTAImg);
         _AchievementImg = ComponentFactory.Instance.creat("asset.Toffilist.AchievementImgAsset1_1");
         addChild(_AchievementImg);
         _charmvalueImg = ComponentFactory.Instance.creat("asset.Toffilist.charmvalueImgAsset1_1");
         addChild(_charmvalueImg);
         _guildImg = ComponentFactory.Instance.creat("asset.Toffilist.guildImgAsset");
         addChild(_guildImg);
         _teamImg = ComponentFactory.Instance.creat("asset.Toffilist.teamImgAsset");
         addChild(_teamImg);
         _teamScoreImg = ComponentFactory.Instance.creat("asset.Toffilist.teamScoreImgAsset1_1");
         addChild(_teamScoreImg);
         _scoreImg = ComponentFactory.Instance.creatBitmap("asset.Toffilist.scoreAsset1");
         addChild(_scoreImg);
         _text1 = ComponentFactory.Instance.creatComponentByStylename("toffilist.text1");
         addChild(_text1);
         _consortiaName = ComponentFactory.Instance.creatComponentByStylename("toffilist.consortiaName");
         addChild(_consortiaName);
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("toffilist.nameTxt");
         _chairmanNameTxt = ComponentFactory.Instance.creatComponentByStylename("toffilist.chairmanNameTxt");
         addChild(_chairmanNameTxt);
         _chairmanNameTxt2 = ComponentFactory.Instance.creatComponentByStylename("toffilist.chairmanNameTxt2");
         _lookEquip_btn = ComponentFactory.Instance.creatComponentByStylename("toffilist.lookEquip_btn");
         _lookEquip_btn.text = LanguageMgr.GetTranslation("civil.leftview.equipName");
         addChild(_lookEquip_btn);
         _applyJoinBtn = ComponentFactory.Instance.creatComponentByStylename("toffilist.applyJoinClub_btn");
         _applyJoinBtn.text = LanguageMgr.GetTranslation("tofflist.joinconsortia");
         addChild(_applyJoinBtn);
         _applyJoinBtn.visible = false;
         _NO1Mc = ComponentFactory.Instance.creat("asset.NO1McAsset");
         _NO1Mc.gotoAndStop(1);
         _NO1Mc.visible = false;
         addChild(_NO1Mc);
         _levelStar = ComponentFactory.Instance.creat("asset.Toffilist.levelStarTxtImage");
         PositionUtils.setPos(_levelStar,"tofflist.leftview.levelStarPos");
         _mountsLevel = ComponentFactory.Instance.creatComponentByStylename("toffilist.mountsLevelText");
         PositionUtils.setPos(_mountsLevel,"tofflist.leftview.MountsLevelPos");
         addChild(_mountsLevel);
      }
      
      private function refreshCharater() : void
      {
         var _loc1_:* = null;
         if(_player)
         {
            _player.dispose();
            _player = null;
         }
         if(_info && !(TofflistModel.firstMenuType == "teams" || TofflistModel.firstMenuType == "crossServerTeams"))
         {
            _player = CharactoryFactory.createCharacter(_info,"room");
            _player.show(false,-1);
            _player.showGun = false;
            _player.setShowLight(true);
            PositionUtils.setPos(_player,"tofflist.playerPos");
            addChild(_player as DisplayObject);
         }
         else if(_teamInfo)
         {
            _loc1_ = getPlayerInfo(_teamInfo);
            _player = CharactoryFactory.createCharacter(_loc1_,"room");
            _player.show(false,-1);
            _player.showGun = false;
            _player.setShowLight(true);
            PositionUtils.setPos(_player,"tofflist.playerPos");
            addChild(_player as DisplayObject);
         }
      }
      
      private function removeEvent() : void
      {
         TofflistModel.removeEventListener("tofflistcurrentplaye",__upCurrentPlayerHandler);
         _lookEquip_btn.removeEventListener("click",__lookBtnClick);
         _applyJoinBtn.removeEventListener("click",onApplyJoinClubBtnClick);
      }
      
      private function upLevelIcon() : void
      {
         if(_levelIcon)
         {
            ObjectUtils.disposeObject(_levelIcon);
            _levelIcon = null;
         }
         if(_info)
         {
            _levelIcon = new LevelIcon();
            _levelIcon.setInfo(_info.Grade,_info.ddtKingGrade,_info.Repute,_info.WinCount,_info.TotalCount,_info.FightPower,_info.Offer,true,false);
            addChild(_levelIcon);
         }
      }
      
      private function upStyle() : void
      {
         var _loc1_:* = null;
         _text1.text = "";
         _consortiaName.text = "";
         _nameTxt.text = "";
         _chairmanNameTxt.text = "";
         _chairmanNameTxt2.text = "";
         _mountsLevel.text = "";
         _levelStar.visible = false;
         DisplayUtils.removeDisplay(_vipName);
         DisplayUtils.removeDisplay(_chairmanVipName);
         if(!_info && !(TofflistModel.firstMenuType == "teams" || TofflistModel.firstMenuType == "crossServerTeams") || !_teamInfo && (TofflistModel.firstMenuType == "teams" || TofflistModel.firstMenuType == "crossServerTeams"))
         {
            if(_rankNumber)
            {
               ObjectUtils.disposeObject(_rankNumber);
               _rankNumber = null;
            }
            if(_levelIcon)
            {
               ObjectUtils.disposeObject(_levelIcon);
               _levelIcon = null;
            }
            return;
         }
         if(TofflistModel.firstMenuType == "personal" || TofflistModel.firstMenuType == "crossServerPersonal")
         {
            upLevelIcon();
            _nameTxt.text = _info.NickName;
            _nameTxt.x = (500 - _nameTxt.textWidth) / 2;
            if(_info.IsVIP)
            {
               if(_vipName)
               {
                  ObjectUtils.disposeObject(_vipName);
               }
               _vipName = VipController.instance.getVipNameTxt(390 - _nameTxt.x,_info.typeVIP);
               _vipName.textSize = 18;
               _vipName.x = _nameTxt.x;
               _vipName.y = _nameTxt.y;
               _vipName.text = _nameTxt.text;
               addChild(_vipName);
               DisplayUtils.removeDisplay(_nameTxt);
               addChild(_applyJoinBtn);
            }
            else
            {
               addChild(_nameTxt);
               DisplayUtils.removeDisplay(_vipName);
            }
            _levelIcon.x = _nameTxt.x - (_levelIcon.width + 5);
            _levelIcon.y = _nameTxt.y - 5;
         }
         else if(TofflistModel.firstMenuType == "consortia" || TofflistModel.firstMenuType == "crossServerConsortia")
         {
            if(_levelIcon)
            {
               _levelIcon.visible = false;
            }
            _chairmanNameTxt.text = LanguageMgr.GetTranslation("tank.tofflist.view.TofflistLeftCurrentCharcter.cdr");
            _chairmanNameTxt2.text = _info.NickName;
            _chairmanNameTxt2.x = (500 - _chairmanNameTxt2.textWidth) / 2;
            _chairmanNameTxt.x = _chairmanNameTxt2.x - (_chairmanNameTxt.textWidth + 5);
            if(_info.IsVIP)
            {
               if(_chairmanVipName)
               {
                  ObjectUtils.disposeObject(_chairmanVipName);
               }
               _chairmanVipName = VipController.instance.getVipNameTxt(165,_info.typeVIP);
               _chairmanVipName.textSize = 18;
               _chairmanVipName.x = _chairmanNameTxt2.x;
               _chairmanVipName.y = _chairmanNameTxt2.y;
               _chairmanVipName.text = _chairmanNameTxt2.text;
               addChild(_chairmanVipName);
               DisplayUtils.removeDisplay(_chairmanNameTxt2);
               addChild(_applyJoinBtn);
            }
            else
            {
               addChild(_chairmanNameTxt2);
               DisplayUtils.removeDisplay(_chairmanVipName);
            }
         }
         else if(TofflistModel.firstMenuType == "teams" || TofflistModel.firstMenuType == "crossServerTeams")
         {
            if(_levelIcon)
            {
               _levelIcon.visible = false;
            }
            _chairmanNameTxt.text = LanguageMgr.GetTranslation("tank.tofflist.view.TofflistLeftCurrentCharcter.teamLeader");
            _chairmanNameTxt2.text = _teamInfo.CreaterName;
            _chairmanNameTxt2.x = (500 - _chairmanNameTxt2.textWidth) / 2;
            _chairmanNameTxt.x = _chairmanNameTxt2.x - (_chairmanNameTxt.textWidth + 5);
            _loc1_ = getPlayerInfo(_teamInfo);
            if(_loc1_.IsVIP)
            {
               if(_chairmanVipName)
               {
                  ObjectUtils.disposeObject(_chairmanVipName);
               }
               _chairmanVipName = VipController.instance.getVipNameTxt(165,_loc1_.typeVIP);
               _chairmanVipName.textSize = 18;
               _chairmanVipName.x = _chairmanNameTxt2.x;
               _chairmanVipName.y = _chairmanNameTxt2.y;
               _chairmanVipName.text = _chairmanNameTxt2.text;
               addChild(_chairmanVipName);
               DisplayUtils.removeDisplay(_chairmanNameTxt2);
               addChild(_applyJoinBtn);
            }
            else
            {
               addChild(_chairmanNameTxt2);
               DisplayUtils.removeDisplay(_chairmanVipName);
            }
         }
         if(TofflistModel.secondMenuType == "mounts")
         {
            _levelStar.visible = true;
            _mountsLevel.text = TofflistModel.mountsLevelInfo;
            _consortiaName.text = String(TofflistModel.currentPlayerInfo.ConsortiaName);
         }
         else if(TofflistModel.firstMenuType == "teams" || TofflistModel.firstMenuType == "crossServerTeams")
         {
            _text1.text = String(_teamInfo.TeamScore);
            _consortiaName.text = _teamInfo.TeamName;
         }
         else
         {
            _text1.text = String(TofflistModel.currentText);
            _consortiaName.text = String(TofflistModel.currentPlayerInfo.ConsortiaName);
         }
         getRank(TofflistModel.currentIndex);
      }
      
      private function upView() : void
      {
         _fightingImg.visible = false;
         _mountsImg.visible = false;
         _AchievementImg.visible = false;
         _LnTAImg.visible = false;
         _wealthImg.visible = false;
         _EXPImg.visible = false;
         _exploitImg.visible = false;
         _charmvalueImg.visible = false;
         _scoreImg.visible = false;
         _teamScoreImg.visible = false;
         _guildImg.visible = false;
         _teamImg.visible = false;
         refreshCharater();
         upStyle();
         NO1Effect();
         if((_info || _teamInfo) && (TofflistModel.firstMenuType == "personal" || TofflistModel.firstMenuType == "consortia" || TofflistModel.firstMenuType == "teams"))
         {
            _lookEquip_btn.enable = true;
         }
         else
         {
            _lookEquip_btn.enable = false;
         }
         refreshApplyJoinClubBtn();
         var _loc1_:* = TofflistModel.firstMenuType;
         if("personal" !== _loc1_)
         {
            if("crossServerPersonal" !== _loc1_)
            {
               if("consortia" !== _loc1_)
               {
                  if("crossServerConsortia" !== _loc1_)
                  {
                     if("teams" !== _loc1_)
                     {
                        if("crossServerTeams" !== _loc1_)
                        {
                        }
                     }
                     _teamImg.visible = true;
                     _teamScoreImg.visible = true;
                  }
               }
               _guildImg.visible = true;
               _loc1_ = TofflistModel.secondMenuType;
               if("battle" !== _loc1_)
               {
                  if("level" !== _loc1_)
                  {
                     if("assets" !== _loc1_)
                     {
                        if("geste" !== _loc1_)
                        {
                           if("charm" !== _loc1_)
                           {
                              if("achievementpoint" === _loc1_)
                              {
                                 _AchievementImg.visible = true;
                              }
                           }
                           else
                           {
                              _charmvalueImg.visible = true;
                           }
                        }
                        else
                        {
                           _exploitImg.visible = true;
                        }
                     }
                     else
                     {
                        _LnTAImg.visible = true;
                     }
                  }
                  else
                  {
                     _EXPImg.visible = true;
                  }
               }
               else
               {
                  _fightingImg.visible = true;
               }
            }
            addr237:
            return;
         }
         _guildImg.visible = true;
         _loc1_ = TofflistModel.secondMenuType;
         if("battle" !== _loc1_)
         {
            if("level" !== _loc1_)
            {
               if("geste" !== _loc1_)
               {
                  if("achievementpoint" !== _loc1_)
                  {
                     if("charm" !== _loc1_)
                     {
                        if("matches" !== _loc1_)
                        {
                           if("mounts" === _loc1_)
                           {
                              _mountsImg.visible = true;
                           }
                        }
                        else
                        {
                           _scoreImg.visible = true;
                        }
                     }
                     else
                     {
                        _charmvalueImg.visible = true;
                     }
                  }
                  else
                  {
                     _AchievementImg.visible = true;
                  }
               }
               else
               {
                  _exploitImg.visible = true;
               }
            }
            else
            {
               _EXPImg.visible = true;
            }
         }
         else
         {
            _fightingImg.visible = true;
         }
         §§goto(addr237);
      }
      
      private function refreshApplyJoinClubBtn() : void
      {
         var _loc1_:int = 0;
         if(TofflistModel.currentConsortiaInfo)
         {
            _loc1_ = TofflistModel.currentConsortiaInfo.ConsortiaID;
         }
         if(_info && TofflistModel.firstMenuType == "consortia" && PlayerManager.Instance.Self.ConsortiaID == 0)
         {
            _applyJoinBtn.visible = true;
         }
         else
         {
            _applyJoinBtn.visible = false;
         }
         if(_loc1_ == 0 || !hasApplyJoinClub(_loc1_))
         {
            _applyJoinBtn.enable = true;
         }
         else
         {
            _applyJoinBtn.enable = false;
         }
      }
      
      private function hasApplyJoinClub(param1:int = 0) : Boolean
      {
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc2_:Vector.<ConsortiaApplyInfo> = TofflistModel.Instance.myConsortiaAuditingApplyData;
         if(_loc2_)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc2_.length)
            {
               _loc3_ = _loc2_[_loc4_];
               if(_loc3_.ConsortiaID == param1)
               {
                  return true;
               }
               _loc4_++;
            }
         }
         return false;
      }
      
      private function getPlayerInfo(param1:TeamRankInfo) : PlayerInfo
      {
         var _loc2_:PlayerInfo = PlayerManager.Instance.findPlayer(param1.CreaterId);
         _loc2_.beginChanges();
         _loc2_.Style = param1.CreaterStyle;
         _loc2_.Skin = param1.CreaterSkin;
         _loc2_.Colors = param1.CreaterColors;
         _loc2_.Sex = param1.Sex;
         if(param1.IsVIP > 0)
         {
            _loc2_.IsVIP = true;
         }
         else
         {
            _loc2_.IsVIP = false;
         }
         _loc2_.commitChanges();
         return _loc2_;
      }
   }
}
