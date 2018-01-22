package tofflist.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.view.selfConsortia.Badge;
   import ddt.data.ConsortiaInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.common.LevelIcon;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextFormat;
   import team.TeamManager;
   import team.model.TeamRankInfo;
   import tofflist.TofflistEvent;
   import tofflist.TofflistModel;
   import tofflist.data.TofflistConsortiaData;
   import tofflist.data.TofflistConsortiaInfo;
   import tofflist.data.TofflistPlayerInfo;
   import vip.VipController;
   
   public class TofflistOrderItem extends Sprite implements Disposeable
   {
       
      
      private var _consortiaInfo:TofflistConsortiaInfo;
      
      private var _badge:Badge;
      
      private var _index:int;
      
      private var _info:TofflistPlayerInfo;
      
      private var _teamRankinfo:TeamRankInfo;
      
      private var _isSelect:Boolean;
      
      private var _bg:Image;
      
      private var _shine:Scale9CornerImage;
      
      private var _level:LevelIcon;
      
      private var _vipName:GradientText;
      
      private var _topThreeRink:ScaleFrameImage;
      
      private var _horseNameStrList:Array;
      
      private var _levelStar:Bitmap;
      
      private var _teamSegmentIcon:ScaleFrameImage;
      
      private var _resourceArr:Array;
      
      private var _styleLinkArr:Array;
      
      private var _attestBtn:ScaleFrameImage;
      
      private var hLines:Array;
      
      public function TofflistOrderItem()
      {
         super();
         init();
         addEvent();
      }
      
      public function get currentText() : String
      {
         return _resourceArr[2].dis["text"];
      }
      
      public function dispose() : void
      {
         var _loc2_:* = null;
         var _loc4_:* = 0;
         var _loc1_:* = 0;
         removeEvent();
         if(hLines)
         {
            var _loc6_:int = 0;
            var _loc5_:* = hLines;
            for each(var _loc3_ in hLines)
            {
               ObjectUtils.disposeObject(_loc3_);
            }
         }
         if(_resourceArr)
         {
            _loc4_ = uint(0);
            _loc1_ = uint(_resourceArr.length);
            _loc4_;
            while(_loc4_ < _loc1_)
            {
               _loc2_ = _resourceArr[_loc4_].dis;
               ObjectUtils.disposeObject(_loc2_);
               _loc2_ = null;
               _resourceArr[_loc4_] = null;
               _loc4_++;
            }
            _resourceArr = null;
         }
         if(_teamSegmentIcon)
         {
            ObjectUtils.disposeObject(_teamSegmentIcon);
         }
         _teamSegmentIcon = null;
         _styleLinkArr = null;
         _badge.dispose();
         _badge = null;
         _bg.dispose();
         _bg = null;
         ObjectUtils.disposeAllChildren(this);
         _shine = null;
         if(_topThreeRink)
         {
            _topThreeRink.dispose();
         }
         _topThreeRink = null;
         if(_levelStar)
         {
            _levelStar.bitmapData.dispose();
         }
         _levelStar = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get index() : int
      {
         return this._index;
      }
      
      public function set index(param1:int) : void
      {
         this._index = param1;
         _bg.setFrame(_index % 2 + 1);
      }
      
      public function get MountsLevel() : String
      {
         return _info.MountsLevelInfo;
      }
      
      public function showHLine(param1:Vector.<Point>) : void
      {
         if(hLines)
         {
            var _loc5_:int = 0;
            var _loc4_:* = hLines;
            for each(var _loc3_ in hLines)
            {
               ObjectUtils.disposeObject(_loc3_);
            }
         }
         hLines = [];
         var _loc7_:int = 0;
         var _loc6_:* = param1;
         for each(var _loc2_ in param1)
         {
            _loc3_ = ComponentFactory.Instance.creatBitmap("asset.corel.formLine");
            addChild(_loc3_);
            hLines.push(_loc3_);
            PositionUtils.setPos(_loc3_,new Point(_loc2_.x - parent.parent.x,_loc2_.y));
         }
      }
      
      public function get info() : Object
      {
         return this._info;
      }
      
      public function set info(param1:Object) : void
      {
         var _loc2_:* = null;
         if(param1 is PlayerInfo)
         {
            _info = param1 as TofflistPlayerInfo;
         }
         else if(param1 is TofflistConsortiaData)
         {
            _loc2_ = param1 as TofflistConsortiaData;
            if(_loc2_)
            {
               _info = _loc2_.playerInfo;
               _consortiaInfo = _loc2_.consortiaInfo;
            }
         }
         else if(param1 is TeamRankInfo)
         {
            _teamRankinfo = param1 as TeamRankInfo;
         }
         if(_info)
         {
            upView();
         }
         if(_teamRankinfo)
         {
            upView();
         }
      }
      
      public function set isSelect(param1:Boolean) : void
      {
         var _loc2_:* = param1;
         this._isSelect = _loc2_;
         _shine.visible = _loc2_;
         if(param1)
         {
            this.dispatchEvent(new TofflistEvent("tofflistitemselect",this));
         }
      }
      
      public function set resourceLink(param1:String) : void
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         _resourceArr = [];
         var _loc3_:Array = param1.replace(/(\s*)|(\s*$)/g,"").split("|");
         var _loc6_:uint = 0;
         var _loc2_:uint = _loc3_.length;
         _loc6_;
         while(_loc6_ < _loc2_)
         {
            _loc5_ = {};
            _loc5_.id = _loc3_[_loc6_].split("#")[0];
            _loc5_.className = _loc3_[_loc6_].split("#")[1];
            _loc4_ = ComponentFactory.Instance.creat(_loc5_.className);
            addChild(_loc4_);
            _loc5_.dis = _loc4_;
            _resourceArr.push(_loc5_);
            _loc6_++;
         }
      }
      
      public function set setAllStyleXY(param1:String) : void
      {
         _styleLinkArr = param1.replace(/(\s*)|(\s*$)/g,"").split("~");
         updateStyleXY();
      }
      
      public function updateStyleXY(param1:int = 0) : void
      {
         var _loc5_:* = null;
         var _loc8_:* = 0;
         var _loc6_:* = 0;
         var _loc2_:int = 0;
         var _loc7_:* = null;
         var _loc3_:uint = _resourceArr.length;
         var _loc4_:Array = _styleLinkArr[param1].split("|");
         _loc3_ = _loc4_.length;
         _loc8_ = uint(0);
         while(_loc8_ < _loc3_)
         {
            _loc5_ = null;
            _loc2_ = _loc4_[_loc8_].split("#")[0];
            _loc6_ = uint(0);
            while(_loc6_ < _resourceArr.length)
            {
               if(_loc2_ == _resourceArr[_loc6_].id)
               {
                  _loc5_ = _resourceArr[_loc6_].dis;
                  break;
               }
               _loc6_++;
            }
            if(_loc5_)
            {
               _loc7_ = new Point();
               _loc7_.x = _loc4_[_loc8_].split("#")[1].split(",")[0];
               _loc7_.y = _loc4_[_loc8_].split("#")[1].split(",")[1];
               _loc5_.x = _loc7_.x;
               _loc5_.y = _loc7_.y;
               if(_loc4_[_loc8_].split("#")[1].split(",")[2])
               {
                  _loc5_.width = _loc4_[_loc8_].split("#")[1].split(",")[2];
               }
               if(_loc4_[_loc8_].split("#")[1].split(",")[3])
               {
                  _loc5_.height = _loc4_[_loc8_].split("#")[1].split(",")[3];
               }
               _loc5_["text"] = _loc5_["text"];
               _loc5_.visible = true;
            }
            _loc8_++;
         }
         if(_index < 4)
         {
            _topThreeRink.x = _resourceArr[0].dis.x - 9;
            _topThreeRink.y = _resourceArr[0].dis.y - 2;
            _topThreeRink.visible = true;
            _topThreeRink.setFrame(_index);
            _resourceArr[0].dis.visible = false;
         }
      }
      
      private function get NO_ID() : String
      {
         var _loc1_:String = "";
         switch(int(_index) - 1)
         {
            case 0:
               _loc1_ = "1st";
               break;
            case 1:
               _loc1_ = "2nd";
               break;
            case 2:
               _loc1_ = "3rd";
         }
         return _loc1_;
      }
      
      private function __itemClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(!_isSelect)
         {
            isSelect = true;
         }
      }
      
      private function __itemMouseOutHandler(param1:MouseEvent) : void
      {
         if(_isSelect)
         {
            return;
         }
         _shine.visible = false;
      }
      
      private function __itemMouseOverHandler(param1:MouseEvent) : void
      {
         _shine.visible = true;
      }
      
      private function addEvent() : void
      {
         addEventListener("click",__itemClickHandler);
         addEventListener("mouseOver",__itemMouseOverHandler);
         addEventListener("mouseOut",__itemMouseOutHandler);
         PlayerManager.Instance.Self.addEventListener("propertychange",__offerChange);
      }
      
      private function __offerChange(param1:PlayerPropertyEvent) : void
      {
         if(param1.changedProperties["isVip"])
         {
            upView();
         }
      }
      
      private function init() : void
      {
         _horseNameStrList = LanguageMgr.GetTranslation("horse.horseNameStr").split(",");
         this.graphics.beginFill(0,0);
         this.graphics.drawRect(0,0,495,30);
         this.graphics.endFill();
         this.buttonMode = true;
         _bg = ComponentFactory.Instance.creatComponentByStylename("tofflist.gridItemBg");
         _bg.setFrame(_index % 2 + 1);
         addChild(_bg);
         _shine = ComponentFactory.Instance.creat("tofflist.orderlistitem.shine");
         _shine.visible = false;
         addChild(_shine);
         _badge = new Badge();
         _badge.visible = false;
         addChild(_badge);
         PositionUtils.setPos(_badge,"tofflist.item.badgePos");
         _level = new LevelIcon();
         _level.setSize(1);
         addChild(_level);
         _level.visible = false;
         _topThreeRink = ComponentFactory.Instance.creat("toffilist.topThreeRink");
         addChild(_topThreeRink);
         _topThreeRink.visible = false;
         _teamSegmentIcon = ComponentFactory.Instance.creat("ddtcorei.playerinfoView.teamIcon");
         _teamSegmentIcon.tipStyle = "";
         _teamSegmentIcon.x = 263;
         _teamSegmentIcon.y = -2;
         var _loc1_:* = 0.9;
         _teamSegmentIcon.scaleY = _loc1_;
         _teamSegmentIcon.scaleX = _loc1_;
         addChild(_teamSegmentIcon);
         _teamSegmentIcon.visible = false;
         _levelStar = ComponentFactory.Instance.creat("asset.Toffilist.levelStarTxtImage");
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__itemClickHandler);
         removeEventListener("mouseOver",__itemMouseOverHandler);
         removeEventListener("mouseOut",__itemMouseOutHandler);
         PlayerManager.Instance.Self.removeEventListener("propertychange",__offerChange);
      }
      
      private function upView() : void
      {
         var _loc3_:* = null;
         var _loc5_:* = 0;
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc1_:uint = _resourceArr.length;
         _loc5_ = uint(0);
         while(_loc5_ < _loc1_)
         {
            _loc3_ = _resourceArr[_loc5_].dis;
            _loc3_["text"] = "";
            _loc3_.visible = false;
            _loc5_++;
         }
         _resourceArr[0].dis["text"] = NO_ID;
         _levelStar.visible = false;
         _teamSegmentIcon.visible = false;
         var _loc6_:* = TofflistModel.firstMenuType;
         if("personal" !== _loc6_)
         {
            if("crossServerPersonal" !== _loc6_)
            {
               if("consortia" !== _loc6_)
               {
                  if("crossServerConsortia" !== _loc6_)
                  {
                     if("teams" !== _loc6_)
                     {
                        if("crossServerTeams" === _loc6_)
                        {
                           updateStyleXY(20);
                           _resourceArr[1].dis["text"] = _teamRankinfo.TeamName;
                           _resourceArr[2].dis["text"] = _teamRankinfo.AreaName;
                           _resourceArr[3].dis["text"] = _teamRankinfo.TeamScore;
                           _teamSegmentIcon.visible = true;
                           _teamSegmentIcon.x = 210;
                           _teamSegmentIcon.y = -3;
                           _teamSegmentIcon.setFrame(TeamManager.instance.model.getTeamBattleSegment(_teamRankinfo.TeamScore) + 2);
                        }
                     }
                     else
                     {
                        updateStyleXY(19);
                        _resourceArr[1].dis["text"] = _teamRankinfo.TeamName;
                        _resourceArr[2].dis["text"] = _teamRankinfo.TeamScore;
                        _teamSegmentIcon.visible = true;
                        _teamSegmentIcon.x = 263;
                        _teamSegmentIcon.y = -2;
                        _teamSegmentIcon.setFrame(TeamManager.instance.model.getTeamBattleSegment(_teamRankinfo.TeamScore) + 2);
                     }
                  }
                  else if(_consortiaInfo)
                  {
                     _badge.visible = _consortiaInfo.BadgeID > 0;
                     _badge.badgeID = _consortiaInfo.BadgeID;
                     _resourceArr[1].dis["text"] = _consortiaInfo.ConsortiaName;
                     if(_consortiaInfo.AreaName)
                     {
                        _resourceArr[3].dis["text"] = _consortiaInfo.AreaName;
                     }
                     _loc6_ = TofflistModel.secondMenuType;
                     if("battle" !== _loc6_)
                     {
                        if("level" !== _loc6_)
                        {
                           if("assets" !== _loc6_)
                           {
                              if("charm" === _loc6_)
                              {
                                 updateStyleXY(16);
                                 _loc6_ = TofflistModel.thirdMenuType;
                                 if("day" !== _loc6_)
                                 {
                                    if("week" !== _loc6_)
                                    {
                                       if("total" === _loc6_)
                                       {
                                          _resourceArr[2].dis["text"] = _consortiaInfo.ConsortiaGiftGp;
                                       }
                                    }
                                    else
                                    {
                                       _resourceArr[2].dis["text"] = _consortiaInfo.ConsortiaAddWeekGiftGp;
                                    }
                                 }
                                 else
                                 {
                                    _resourceArr[2].dis["text"] = _consortiaInfo.ConsortiaAddDayGiftGp;
                                 }
                              }
                           }
                           else
                           {
                              updateStyleXY(15);
                              _loc6_ = TofflistModel.thirdMenuType;
                              if("day" !== _loc6_)
                              {
                                 if("week" !== _loc6_)
                                 {
                                    if("total" === _loc6_)
                                    {
                                       _resourceArr[2].dis["text"] = _consortiaInfo.LastDayRiches;
                                    }
                                 }
                                 else
                                 {
                                    _resourceArr[2].dis["text"] = _consortiaInfo.AddWeekRiches;
                                 }
                              }
                              else
                              {
                                 _resourceArr[2].dis["text"] = _consortiaInfo.AddDayRiches;
                              }
                           }
                        }
                        else
                        {
                           updateStyleXY(14);
                           _loc6_ = TofflistModel.thirdMenuType;
                           if("total" === _loc6_)
                           {
                              _resourceArr[2].dis["text"] = _consortiaInfo.LastDayRiches;
                              _resourceArr[4].dis["text"] = _consortiaInfo.Level;
                           }
                        }
                     }
                     else
                     {
                        updateStyleXY(13);
                        _loc6_ = TofflistModel.thirdMenuType;
                        if("total" === _loc6_)
                        {
                           if(_consortiaInfo.FightPower < 0)
                           {
                              _resourceArr[2].dis["text"] = _consortiaInfo.FightPower + Math.pow(2,32);
                           }
                           else
                           {
                              _resourceArr[2].dis["text"] = _consortiaInfo.FightPower;
                           }
                        }
                     }
                  }
               }
               else if(_consortiaInfo)
               {
                  _badge.visible = _consortiaInfo.BadgeID > 0;
                  _badge.badgeID = _consortiaInfo.BadgeID;
                  _resourceArr[1].dis["text"] = _consortiaInfo.ConsortiaName;
                  _loc6_ = TofflistModel.secondMenuType;
                  if("battle" !== _loc6_)
                  {
                     if("level" !== _loc6_)
                     {
                        if("assets" !== _loc6_)
                        {
                           if("charm" === _loc6_)
                           {
                              updateStyleXY(8);
                              _loc6_ = TofflistModel.thirdMenuType;
                              if("day" !== _loc6_)
                              {
                                 if("week" !== _loc6_)
                                 {
                                    if("total" === _loc6_)
                                    {
                                       _resourceArr[2].dis["text"] = _consortiaInfo.ConsortiaGiftGp;
                                    }
                                 }
                                 else
                                 {
                                    _resourceArr[2].dis["text"] = _consortiaInfo.ConsortiaAddWeekGiftGp;
                                 }
                              }
                              else
                              {
                                 _resourceArr[2].dis["text"] = _consortiaInfo.ConsortiaAddDayGiftGp;
                              }
                           }
                        }
                        else
                        {
                           updateStyleXY(7);
                           _loc6_ = TofflistModel.thirdMenuType;
                           if("day" !== _loc6_)
                           {
                              if("week" !== _loc6_)
                              {
                                 if("total" === _loc6_)
                                 {
                                    _resourceArr[2].dis["text"] = _consortiaInfo.LastDayRiches;
                                 }
                              }
                              else
                              {
                                 _resourceArr[2].dis["text"] = _consortiaInfo.AddWeekRiches;
                              }
                           }
                           else
                           {
                              _resourceArr[2].dis["text"] = _consortiaInfo.AddDayRiches;
                           }
                        }
                     }
                     else
                     {
                        updateStyleXY(6);
                        _loc6_ = TofflistModel.thirdMenuType;
                        if("total" === _loc6_)
                        {
                           _resourceArr[2].dis["text"] = _consortiaInfo.LastDayRiches;
                           _resourceArr[3].dis["text"] = _consortiaInfo.Level;
                        }
                     }
                  }
                  else
                  {
                     updateStyleXY(5);
                     _loc6_ = TofflistModel.thirdMenuType;
                     if("total" === _loc6_)
                     {
                        if(_consortiaInfo.FightPower < 0)
                        {
                           _resourceArr[2].dis["text"] = _consortiaInfo.FightPower + Math.pow(2,32);
                        }
                        else
                        {
                           _resourceArr[2].dis["text"] = _consortiaInfo.FightPower;
                        }
                     }
                  }
               }
            }
            else
            {
               _resourceArr[1].dis["text"] = _info.NickName;
               _resourceArr[3].dis["text"] = !!_info.AreaName?_info.AreaName:"";
               _loc6_ = TofflistModel.secondMenuType;
               if("battle" !== _loc6_)
               {
                  if("level" !== _loc6_)
                  {
                     if("achievementpoint" !== _loc6_)
                     {
                        if("charm" !== _loc6_)
                        {
                           if("mounts" === _loc6_)
                           {
                              updateStyleXY(18);
                              _levelStar.visible = true;
                              PositionUtils.setPos(_levelStar,"tofflist.cross.levelStarPos");
                              _resourceArr[2].dis["text"] = _horseNameStrList[_info.MountsLevel];
                              _resourceArr[5].dis["text"] = _info.MountsLevelInfo;
                           }
                        }
                        else
                        {
                           updateStyleXY(12);
                           _loc6_ = TofflistModel.thirdMenuType;
                           if("day" !== _loc6_)
                           {
                              if("week" !== _loc6_)
                              {
                                 if("total" === _loc6_)
                                 {
                                    _resourceArr[2].dis["text"] = _info.GiftGp;
                                    _resourceArr[4].dis["text"] = _info.GiftLevel;
                                 }
                              }
                              else
                              {
                                 _resourceArr[2].dis["text"] = _info.AddWeekGiftGp;
                                 _resourceArr[4].dis["text"] = _info.GiftLevel;
                              }
                           }
                           else
                           {
                              _resourceArr[2].dis["text"] = _info.AddDayGiftGp;
                              _resourceArr[4].dis["text"] = _info.GiftLevel;
                           }
                        }
                     }
                     else
                     {
                        updateStyleXY(11);
                        _loc6_ = TofflistModel.thirdMenuType;
                        if("day" !== _loc6_)
                        {
                           if("week" !== _loc6_)
                           {
                              if("total" === _loc6_)
                              {
                                 _resourceArr[2].dis["text"] = _info.AchievementPoint;
                              }
                           }
                           else
                           {
                              _resourceArr[2].dis["text"] = _info.AddWeekAchievementPoint;
                           }
                        }
                        else
                        {
                           _resourceArr[2].dis["text"] = _info.AddDayAchievementPoint;
                        }
                     }
                  }
                  else
                  {
                     updateStyleXY(10);
                     if(_vipName)
                     {
                        _vipName.x = _resourceArr[1].dis.x - _vipName.width / 2;
                     }
                     _level.x = 208;
                     _level.y = 3;
                     _level.setInfo(_info.Grade,_info.ddtKingGrade,_info.Repute,_info.WinCount,_info.TotalCount,_info.FightPower,_info.Offer,true,false);
                     _level.visible = true;
                     _loc6_ = TofflistModel.thirdMenuType;
                     if("day" !== _loc6_)
                     {
                        if("week" !== _loc6_)
                        {
                           if("total" === _loc6_)
                           {
                              _resourceArr[2].dis["text"] = _info.GP;
                           }
                        }
                        else
                        {
                           _resourceArr[2].dis["text"] = _info.AddWeekGP;
                        }
                     }
                     else
                     {
                        _resourceArr[2].dis["text"] = _info.AddDayGP;
                     }
                  }
               }
               else
               {
                  updateStyleXY(9);
                  _loc6_ = TofflistModel.thirdMenuType;
                  if("total" === _loc6_)
                  {
                     _resourceArr[2].dis["text"] = _info.FightPower;
                  }
               }
               if(_info.IsVIP)
               {
                  if(_vipName)
                  {
                     ObjectUtils.disposeObject(_vipName);
                  }
                  _vipName = VipController.instance.getVipNameTxt(1,_info.typeVIP);
                  _loc4_ = new TextFormat();
                  _loc4_.align = "center";
                  _loc4_.bold = true;
                  _vipName.textField.defaultTextFormat = _loc4_;
                  _vipName.textSize = 16;
                  _vipName.textField.width = _resourceArr[1].dis.width;
                  _vipName.x = _resourceArr[1].dis.x;
                  _vipName.y = _resourceArr[1].dis.y;
                  _vipName.text = _info.NickName;
                  addChild(_vipName);
               }
               PositionUtils.adaptNameStyle(_info,_resourceArr[1].dis,_vipName);
               creatAttestBtn();
            }
         }
         else
         {
            _resourceArr[1].dis["text"] = _info.NickName;
            _loc6_ = TofflistModel.secondMenuType;
            if("battle" !== _loc6_)
            {
               if("level" !== _loc6_)
               {
                  if("achievementpoint" !== _loc6_)
                  {
                     if("charm" !== _loc6_)
                     {
                        if("matches" !== _loc6_)
                        {
                           if("mounts" === _loc6_)
                           {
                              updateStyleXY(17);
                              _levelStar.visible = true;
                              PositionUtils.setPos(_levelStar,"tofflist.person.levelStarPos");
                              _resourceArr[3].dis["text"] = _horseNameStrList[_info.MountsLevel];
                              _resourceArr[5].dis["text"] = String(_info.MountsLevelInfo);
                           }
                        }
                        else
                        {
                           updateStyleXY(4);
                           _loc6_ = TofflistModel.thirdMenuType;
                           if("day" !== _loc6_)
                           {
                              if("week" !== _loc6_)
                              {
                                 if("total" === _loc6_)
                                 {
                                    _resourceArr[2].dis["text"] = String(_info.TotalPrestige);
                                 }
                              }
                              else
                              {
                                 _resourceArr[2].dis["text"] = String(_info.AddWeekPrestige);
                              }
                           }
                           else
                           {
                              _resourceArr[2].dis["text"] = String(_info.AddDayPrestige);
                           }
                        }
                     }
                     else
                     {
                        updateStyleXY(3);
                        _loc6_ = TofflistModel.thirdMenuType;
                        if("day" !== _loc6_)
                        {
                           if("week" !== _loc6_)
                           {
                              if("total" === _loc6_)
                              {
                                 _resourceArr[2].dis["text"] = _info.GiftGp;
                                 _resourceArr[3].dis["text"] = _info.GiftLevel;
                              }
                           }
                           else
                           {
                              _resourceArr[2].dis["text"] = _info.AddWeekGiftGp;
                              _resourceArr[3].dis["text"] = _info.GiftLevel;
                           }
                        }
                        else
                        {
                           _resourceArr[2].dis["text"] = _info.AddDayGiftGp;
                           _resourceArr[3].dis["text"] = _info.GiftLevel;
                        }
                     }
                  }
                  else
                  {
                     updateStyleXY(2);
                     _loc6_ = TofflistModel.thirdMenuType;
                     if("day" !== _loc6_)
                     {
                        if("week" !== _loc6_)
                        {
                           if("total" === _loc6_)
                           {
                              _resourceArr[2].dis["text"] = _info.AchievementPoint;
                           }
                        }
                        else
                        {
                           _resourceArr[2].dis["text"] = _info.AddWeekAchievementPoint;
                        }
                     }
                     else
                     {
                        _resourceArr[2].dis["text"] = _info.AddDayAchievementPoint;
                     }
                  }
               }
               else
               {
                  updateStyleXY(1);
                  if(_vipName)
                  {
                     _vipName.x = _resourceArr[1].dis.x - _vipName.width / 2;
                  }
                  _level.x = 227;
                  _level.y = 3;
                  _level.setInfo(_info.Grade,_info.ddtKingGrade,_info.Repute,_info.WinCount,_info.TotalCount,_info.FightPower,_info.Offer,true,false);
                  _level.visible = true;
                  _loc6_ = TofflistModel.thirdMenuType;
                  if("day" !== _loc6_)
                  {
                     if("week" !== _loc6_)
                     {
                        if("total" === _loc6_)
                        {
                           _resourceArr[2].dis["text"] = _info.GP;
                        }
                     }
                     else
                     {
                        _resourceArr[2].dis["text"] = _info.AddWeekGP;
                     }
                  }
                  else
                  {
                     _resourceArr[2].dis["text"] = _info.AddDayGP;
                  }
               }
            }
            else
            {
               updateStyleXY(0);
               _loc6_ = TofflistModel.thirdMenuType;
               if("total" === _loc6_)
               {
                  _resourceArr[2].dis["text"] = _info.FightPower;
               }
            }
            if(_info.IsVIP)
            {
               if(_vipName)
               {
                  ObjectUtils.disposeObject(_vipName);
               }
               _vipName = VipController.instance.getVipNameTxt(1,_info.typeVIP);
               _loc2_ = new TextFormat();
               _loc2_.align = "center";
               _loc2_.bold = true;
               _vipName.textField.defaultTextFormat = _loc2_;
               _vipName.textSize = 16;
               _vipName.textField.width = _resourceArr[1].dis.width;
               _vipName.x = _resourceArr[1].dis.x;
               _vipName.y = _resourceArr[1].dis.y;
               _vipName.text = _info.NickName;
            }
            PositionUtils.adaptNameStyle(_info,_resourceArr[1].dis,_vipName);
            creatAttestBtn();
         }
         if(_vipName)
         {
            addChild(_vipName);
         }
      }
      
      private function creatAttestBtn() : void
      {
         if(_info.isAttest)
         {
            _attestBtn = ComponentFactory.Instance.creatComponentByStylename("hall.playerInfo.attest");
            _attestBtn.buttonMode = true;
            addChild(_attestBtn);
            if(_info.IsVIP)
            {
               _attestBtn.x = _vipName.x + _vipName.width;
               _attestBtn.y = _vipName.y;
            }
            else
            {
               _attestBtn.x = _resourceArr[1].dis.x + _resourceArr[1].dis.width;
               _attestBtn.y = _resourceArr[1].dis.y;
            }
         }
      }
      
      public function get consortiaInfo() : ConsortiaInfo
      {
         return _consortiaInfo;
      }
      
      public function get teamRankinfo() : TeamRankInfo
      {
         return _teamRankinfo;
      }
   }
}
